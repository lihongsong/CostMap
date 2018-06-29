//
//  NSString+NSData.m
//  HuaQianWuYou
//
//  Created by jason on 2018/6/7.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "NSString+NSData.h"
#import "Objective-Zip.h"
#import "GTMBase64.h"

@implementation NSString (NSData)

+ (void)stringWithZYZData:(void(^)(NSString *str))block{
  NSString *fileName=[[self tempUnzipPathInDoc] stringByAppendingPathComponent:@"baseConfig"];
  if (GetUserDefault(@"baseConfig") != nil && [GetUserDefault(@"baseConfig") isEqualToString:[UIDevice hj_appVersion]]) {
      block(fileName);
  }else{
    dispatch_queue_t aDQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t disgroup = dispatch_group_create();
        @autoreleasepool {
          dispatch_group_async(disgroup, aDQueue, ^{
            [self startUnZip];
          });
          dispatch_group_async(disgroup, aDQueue, ^{
            NSArray *arr = @[@"AlertView",@"Toast",@"Keyboard",@"Animation",@"charts"];
            NSMutableString *str = [NSMutableString new];
            for (int i = 0; i < arr.count; i++) {
              [self decompressFileFromPath:[[NSBundle mainBundle] pathForResource:arr[i] ofType:@"a"] append:str];
              if (i == arr.count - 1) {
                if ([str writeToFile:fileName atomically:YES]) {
                  
                  NSLog(@">>write ok.");
                  SetUserDefault([UIDevice hj_appVersion], @"baseConfig");
                }
              }
          };
          });
      dispatch_group_notify(disgroup, aDQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
         block(fileName);
        });
      });
  }
  }
}

+ (void)startUnZip
{
  NSString *filePath = [[NSBundle mainBundle]pathForResource:@"assets.zip" ofType:nil];
  NSString *unzipPath = [self tempUnzipPathInDoc];
  NSLog(@"sg__%@",unzipPath);
  [self decompressFileFromPath:filePath toPath:(NSString *)unzipPath];
}



+ (void)decompressFileFromPath:(NSString *)from toPath:(NSString *)to{
  @try {
    OZZipFile *unzipFile = [[OZZipFile alloc] initWithFileName:from mode:OZZipFileModeUnzip];
    　　//解压是否完成
    BOOL unzipFinished = NO;
    
    while (!unzipFinished) {
      
      　　　　//获取当前遍历到的文件信息
      OZFileInZipInfo *info = [unzipFile getCurrentFileInZipInfo];
      //OZZipReadStream *stream = [unzipFile readCurrentFileInZipWithPassword:@"Qwertyuiopazsx998"];
      OZZipReadStream *stream = [unzipFile readCurrentFileInZip];
      NSMutableData *buffer = [[NSMutableData alloc] initWithLength:1024];
      
      // unzip files to the write path
      NSString *writePath = [to stringByAppendingPathComponent:info.name];
      if ([info.name hasSuffix:@"/"]) {
        
        　　　　//创建目录
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        [fileManager createDirectoryAtPath:writePath withIntermediateDirectories:YES attributes:nil error:nil];
        //                    [MFFileToolkit createDrectoryIfNeeded:writePath];
      }else{
        
        　　　　//创建文件
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createFileAtPath:writePath contents:nil attributes:nil];
        
        //                    [MFFileToolkit createFilePath:writePath];
        
        //create fileHanderler to manage writing data to specified path, before writing data, move
        //the cusor to the end of the file first.
        NSFileHandle *fileHandler = [NSFileHandle fileHandleForWritingAtPath:writePath];
        [buffer setLength:0];
        
        do {
          [buffer setLength:1024];
          int bytesRead = [stream readDataWithBuffer:buffer];
          
          
          　　　　　　//每次读取BUFFER_SIZE大小的数据，如果读出的数据大小>0，就继续循环读取数据，
          
          　　　　　　//直到读到的数据大小<= 0时，退出循环，当前遍历的文件已解压完毕
          if (bytesRead > 0) {
            [buffer setLength:bytesRead];
            [fileHandler seekToEndOfFile];
            [fileHandler writeData:buffer];
          }else{
            break;
          }
        } while (YES);
        
        [fileHandler closeFile];
      }
      
      [stream finishedReading];
      buffer = nil;
      
      // Check if we should continue reading
      unzipFinished = ![unzipFile goToNextFileInZip];
    }
  }
  @catch (OZZipException *exception) {
    @throw exception;
  }
}

+ (void)decompressFileFromPath:(NSString *)from append:(NSMutableString *)appendBuffer{
  @try {
    OZZipFile *unzipFile = [[OZZipFile alloc] initWithFileName:from mode:OZZipFileModeUnzip];
    　　//解压是否完成
    BOOL unzipFinished = NO;
    
    while (!unzipFinished) {
      OZZipReadStream *stream = [unzipFile readCurrentFileInZip];
      NSMutableData *buffer = [[NSMutableData alloc] initWithLength:1024];
  
        [buffer setLength:0];
        
        do {
          [buffer setLength:1024];
          int bytesRead = [stream readDataWithBuffer:buffer];
          
          
          　　　　　　//每次读取BUFFER_SIZE大小的数据，如果读出的数据大小>0，就继续循环读取数据，
          
          　　　　　　//直到读到的数据大小<= 0时，退出循环，当前遍历的文件已解压完毕
          if (bytesRead > 0) {
            [buffer setLength:bytesRead];
            
            NSData *resultData = [GTMBase64 decodeData:buffer];
            NSString *resultString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
            [appendBuffer appendString:resultString];
          }else{
            break;
          }
        } while (YES);

      [stream finishedReading];
      buffer = nil;
      
      // Check if we should continue reading
      unzipFinished = ![unzipFile goToNextFileInZip];
    }
  }
  @catch (OZZipException *exception) {
    @throw exception;
  }
}

+ (NSString *)tempUnzipPathInDoc
{
  NSString *path = [NSString stringWithFormat:@"%@",
                    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]];
  NSURL *url = [NSURL fileURLWithPath:path];
  NSError *error = nil;
  [[NSFileManager defaultManager] createDirectoryAtURL:url
                           withIntermediateDirectories:YES
                                            attributes:nil
                                                 error:&error];
  if (error) {
    return nil;
  }
  return url.path;
}
@end
