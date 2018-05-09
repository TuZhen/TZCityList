//
//  KLCityListCollectionCell.h
//  KLCityListToolTest
//
//  Created by kinglian on 2018/5/3.
//  Copyright © 2018年 kinglian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KLCityModel;
@protocol KLCityListCollectionCellDelegate<NSObject>
- (void)cityCellDidSelected:(KLCityModel *)cityModel selectedIndex:(NSInteger)selectedIndex;
@end
@interface KLCityListCollectionCell : UICollectionViewCell
@property (nonatomic ,strong) NSArray * tableViewDataSource; //
@property (nonatomic, weak) id <KLCityListCollectionCellDelegate>delegate;
@property (nonatomic ,copy) NSString *selectedIndexStr;//选中项纪录
@end
