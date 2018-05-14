//
//  TZSelectedStyle.h
//  FMDB
//
//  Created by kinglian on 2018/5/14.
//

#import <Foundation/Foundation.h>

@interface TZCityListSelectedStyle : NSObject<NSCoding>
/** 选中颜色 */
@property (nonatomic ,strong) UIColor * selectedColor;
/** 选中的cell上的标记图片 */
@property (nonatomic ,strong) UIImage * selectedCellSignImage;

/**
 用以获取已存放好的selectedStyle
 @return 已存储了的TZSelectedStyle实例化对象
 */
+ (instancetype)selectedStyle;

/**
将selectedStyle存储到本地沙河
*/
- (void)saveSelectedStyle;
@end
