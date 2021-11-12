//
//  ViewInformation.h
//  GestureTask
//
//  Created by Maksim Vaselkov on 11.11.2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewInformation : NSObject <NSCoding>

@property (nonatomic, strong) UIColor *colorView;
@property (nonatomic, strong) NSString *viewCoordinate;

@end

NS_ASSUME_NONNULL_END
