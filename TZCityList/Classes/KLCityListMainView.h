//
//  KLCityListMainView.h
//  KLCityListToolTest
//
//  Created by kinglian on 2018/4/27.
//  Copyright © 2018年 kinglian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLCityListMainView : UIView
- (void)show;
@property (nonatomic ,copy) void(^finishBlock)(NSArray *cityArr);
@end
