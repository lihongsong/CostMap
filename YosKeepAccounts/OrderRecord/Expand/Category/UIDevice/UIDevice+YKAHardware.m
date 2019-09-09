#import "UIDevice+YKAHardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <sys/socket.h>
#import <sys/param.h>
#import <sys/mount.h>
#import <sys/stat.h>
#import <sys/utsname.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <mach/processor_info.h>
#include <mach/machine.h>
@implementation UIDevice (YKAHardware)
- (NSString *)hardwareString {
    int name[]  = {CTL_HW, HW_MACHINE};
    size_t size = 100;
    sysctl(name, 2, NULL, &size, NULL, 0); 
    char *hw_machine = malloc(size);
    sysctl(name, 2, hw_machine, &size, NULL, 0);
    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);
    return hardware;
}
- (NSDictionary *)getDeviceList {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LNRiskBunldle" ofType:@"bundle"];
    NSString *plistPath = [path stringByAppendingPathComponent:@"LNDeviceList.plist"];
    NSDictionary *deviceListDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSAssert(deviceListDic != nil, @"DevicePlist not found in the bundle.");
    return deviceListDic;
}
- (BOOL)isIphoneWith4inchDisplay {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        double height = [[UIScreen mainScreen] bounds].size.height;
        if (fabs(height - 568.0f) < DBL_EPSILON) {
            return YES;
        }
    }
    return NO;
}
+ (NSString *)macAddress {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. Rrror!\n");
        return NULL;
    }
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    ifm                 = (struct if_msghdr *)buf;
    sdl                 = (struct sockaddr_dl *)(ifm + 1);
    ptr                 = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                                     *ptr, *(ptr + 1), *(ptr + 2), *(ptr + 3), *(ptr + 4), *(ptr + 5)];
    free(buf);
    return outstring;
}
+ (NSString *)systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}
+ (BOOL)hasCamera {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
+ (unsigned long)getSysInfo:(uint)typeSpecifier {
    size_t size = sizeof(int);
    unsigned long result;
    int mib[3] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (unsigned long)result;
}
+ (NSUInteger)cpuFrequency {
    return [self getSysInfo:HW_CPU_FREQ];
}
+ (NSUInteger)busFrequency {
    return [self getSysInfo:HW_BUS_FREQ];
}
+ (NSUInteger)ramSize {
    return [self getSysInfo:HW_MEMSIZE];
}
+ (NSUInteger)cpuNumber {
    return [self getSysInfo:HW_NCPU];
}
+ (NSUInteger)totalMemoryBytes {
    return [self getSysInfo:HW_PHYSMEM];
}
+ (NSUInteger)freeMemoryBytes {
    mach_port_t host_port            = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    host_page_size(host_port, &pagesize);
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        return 0;
    }
    unsigned long mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}
+ (long long)freeDiskSpaceBytes {
    struct statfs buf;
    long long freespace;
    freespace = 0;
    if (statfs("/private/var", &buf) >= 0) {
        freespace = (long long)buf.f_bsize * buf.f_bfree;
    }
    return freespace;
}
+ (long long)totalDiskSpaceBytes {
    struct statfs buf;
    long long totalspace;
    totalspace = 0;
    if (statfs("/private/var", &buf) >= 0) {
        totalspace = (long long)buf.f_bsize * buf.f_blocks;
    }
    return totalspace;
}
+ (NSString *)getDeviceType {
    NSString *deviceName = [[UIDevice currentDevice] hardwareString];
    if ([deviceName hasPrefix:@"iPhone"]) {
        return @"iPhone";
    } else if ([deviceName hasPrefix:@"iPod"]) {
        return @"iPod";
    } else if ([deviceName hasPrefix:@"iPad"]) {
        return @"iPad";
    } else {
        return [[UIDevice currentDevice] model];
    }
    return @"UNKNOWN";
}
+ (NSString *)cpuType {
    int error = 0;
    int cputype   = -1;
    size_t length = sizeof(cputype);
    error         = sysctlbyname("hw.cputype", &cputype, &length, NULL, 0);
    if (error != 0) {
        NSLog(@"Failed to obtain CPU type");
        return nil;
    }
    if (cputype == CPU_TYPE_X86) {
        char stringValue[256] = {0};
        size_t stringLength   = sizeof(stringValue);
        error                 = sysctlbyname("machdep.cpu.brand_string", &stringValue, &stringLength, NULL, 0);
        if (error == 0) {
            NSString *brandString = [NSString stringWithUTF8String:stringValue];
            if (brandString)
                return brandString;
        }
    }
    int cpusubtype = -1;
    length         = sizeof(cpusubtype);
    error          = sysctlbyname("hw.cpusubtype", &cpusubtype, &length, NULL, 0);
    if (error != 0) {
        NSLog(@"Failed to obtain CPU subtype");
        return nil;
    }
    switch (cputype) {
        case CPU_TYPE_X86:
            return @"Intel";
        case CPU_TYPE_POWERPC:
            return @"PowerPC";
        case CPU_TYPE_ARM:
            return @"ARM";
        case CPU_TYPE_ARM64:
            return @"ARM64";
    }
    NSLog(@"Unknown CPU type %d, CPU subtype %d", cputype, cpusubtype);
    return nil;
}
@end
