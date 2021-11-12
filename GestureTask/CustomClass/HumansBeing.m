//
//  Human.m
//  GestureTask
//
//  Created by Maksim Vaselkov on 11.11.2021.
//

#import "HumansBeing.h"

@implementation HumansBeing

static NSString *const HumanNameArchiveKey = @"nameArchiveKey";
static NSString *const HumanAgeArchiveKey = @"ageArchiveKey";
static NSString *const HumanClothesArchiveKey = @"clothesArchiveKey";

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super init];
    if (self) {
        _name = [coder decodeObjectForKey:HumanNameArchiveKey];
        _age = [coder decodeIntForKey:HumanAgeArchiveKey];
        _metaClothes = [coder decodeObjectForKey:HumanClothesArchiveKey];
    }
    return self;
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:self.name forKey:HumanNameArchiveKey];
    [coder encodeInt:self.age forKey:HumanAgeArchiveKey];
//    [coder encodeObject:self.clothes forKey:HumanClothesArchiveKey];
}

@end
