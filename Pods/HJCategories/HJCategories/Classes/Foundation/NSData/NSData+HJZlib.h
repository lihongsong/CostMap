//
//  NSData+HJZlib.h
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import <Foundation/Foundation.h>

/**
 ZLib error domain
 */
extern NSString *const HJZlibErrorDomain;
/**
 When a zlib error occurs, querying this key in the @p userInfo dictionary of the
 @p NSError object will return the underlying zlib error code.
 */
extern NSString *const HJZlibErrorInfoKey;

typedef NS_ENUM(NSUInteger, HJZlibErrorCode) {
    HJZlibErrorCodeFileTooLarge = 0,
    HJZlibErrorCodeDeflationError = 1,
    HJZlibErrorCodeInflationError = 2,
    HJZlibErrorCodeCouldNotCreateFileError = 3,
};

@interface NSData (HJZlib)

/**
 Apply zlib compression.
 
 @param error If an error occurs during compression, upon return contains an
 NSError object describing the problem.
 
 @returns An NSData instance containing the result of applying zlib
 compression to this instance.
 */
- (NSData *)hj_dataByDeflatingWithError:(NSError *__autoreleasing *)error;

/**
 Apply zlib decompression.
 
 @param error If an error occurs during decompression, upon return contains an
 NSError object describing the problem.
 
 @returns An NSData instance containing the result of applying zlib
 decompression to this instance.
 */
- (NSData *)hj_dataByInflatingWithError:(NSError *__autoreleasing *)error;

/**
 Apply zlib compression and write the result to a file at path
 
 @param path The path at which the file should be written
 
 @param error If an error occurs during compression, upon return contains an
 NSError object describing the problem.
 
 @returns @p YES if the compression succeeded; otherwise, @p NO.
 */
- (BOOL)hj_writeDeflatedToFile:(NSString *)path
                         error:(NSError *__autoreleasing *)error;

/**
 Apply zlib decompression and write the result to a file at path
 
 @param path The path at which the file should be written
 
 @param error If an error occurs during decompression, upon return contains an
 NSError object describing the problem.
 
 @returns @p YES if the compression succeeded; otherwise, @p NO.
 */
- (BOOL)hj_writeInflatedToFile:(NSString *)path
                         error:(NSError *__autoreleasing *)error;

@end
