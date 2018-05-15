//
//  KLCityListMainView.h
//  KLCityListToolTest
//
//  Created by kinglian on 2018/4/27.
//  Copyright © 2018年 kinglian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TZCityListSelectedStyle;

@interface TZCityListMainView : UIView



/**
 获取城市列表实例化对象

 @param selectedStyle 选中样式，可以为NUll
 @return 城市列表实例化对象
 */
- (instancetype)initWithSelectedStyle:(TZCityListSelectedStyle *__nullable)selectedStyle;

/** 展示CityList视图 */
- (void)show;

/** 选择完成后的回调 */
@property (nonatomic ,copy) void(^finishBlock)(NSArray *cityArr);


@end
