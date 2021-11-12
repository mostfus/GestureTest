//
//  Humans.h
//  GestureTask
//
//  Created by Maksim Vaselkov on 11.11.2021.
//

#import <Foundation/Foundation.h>
//#import "Clothes.h"

NS_ASSUME_NONNULL_BEGIN

@interface HumansBeing : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) id metaClothes;

@end

NS_ASSUME_NONNULL_END
