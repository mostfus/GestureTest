//
//  ViewInformation.m
//  GestureTask
//
//  Created by Maksim Vaselkov on 11.11.2021.
//

#import "ViewInformation.h"

@implementation ViewInformation

static NSString *const ViewColorArchiveKey = @"vColorArchiveKey";
static NSString *const ViewCoordinateArchiveKey = @"vCoordinateArchiveKey";

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _colorView = [coder decodeObjectForKey:ViewColorArchiveKey];
        _viewCoordinate = [coder decodeObjectForKey:ViewCoordinateArchiveKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.colorView forKey:ViewColorArchiveKey];
    [coder encodeObject:self.viewCoordinate forKey:ViewCoordinateArchiveKey];
}

@end
