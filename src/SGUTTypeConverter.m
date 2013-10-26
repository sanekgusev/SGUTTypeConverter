//
//  SGUTTypeConverter.m
//  SGUTTypeConverter
//
//  Created by Alexander Gusev on 10/26/13.
//  Copyright (c) 2013 sanekgusev. All rights reserved.
//

#import "SGUTTypeConverter.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation SGUTTypeConverter

@synthesize UTI = _UTI, fileExtension = _fileExtension, MIMEType = _MIMEType;

#pragma mark - Properties

- (NSString *)UTI {
    if (_UTI) {
        return _UTI;
    }
    if (_fileExtension) {
        return _UTI =
        (__bridge_transfer NSString*)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                                           (__bridge CFStringRef)_fileExtension,
                                                                           NULL);
    }
    if (_MIMEType) {
        return _UTI =
        (__bridge_transfer NSString*)UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType,
                                                                           (__bridge CFStringRef)_MIMEType,
                                                                           NULL);
    }
    return nil;
}

- (void)setUTI:(NSString *)UTI {
    _UTI = [UTI copy];
    _fileExtension = nil;
    _MIMEType = nil;
}

- (NSString *)fileExtension {
    if (_fileExtension) {
        return _fileExtension;
    }
    if (self.UTI) {
        return _fileExtension =
        (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)self.UTI,
                                                                      kUTTagClassFilenameExtension);
    }
    return nil;
}

- (void)setFileExtension:(NSString *)fileExtension {
    _fileExtension = [fileExtension copy];
    _UTI = nil;
    _MIMEType = nil;
}

- (NSString *)MIMEType {
    if (_MIMEType) {
        return _MIMEType;
    }
    if (self.UTI) {
        return _MIMEType =
        (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)self.UTI,
                                                                      kUTTagClassMIMEType);
    }
    return nil;
}

- (void)setMIMEType:(NSString *)MIMEType {
    _MIMEType = [MIMEType copy];
    _UTI = nil;
    _fileExtension = nil;
}

@end
