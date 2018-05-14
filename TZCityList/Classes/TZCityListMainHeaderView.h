//
//  KLCityListMainHeaderView.h
//  KLCityListToolTest
//
//  Created by kinglian on 2018/5/4.
//  Copyright © 2018年 kinglian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZCityListMainHeaderView : UIView
- (instancetype)initWithFrame:(CGRect)frame WithSelectedColor:(UIColor *)selecterColor;
- (void)changeSelectedItemNameArr:(NSArray<NSString *>*)itemNameArr isLast:(BOOL)isLast;
- (void)changeSelectedSignViewCenterWithItemIndex:(NSInteger)itemIndex;
@property (nonatomic ,copy) void(^cancelBtnDidClickBlock)(void);
@end
