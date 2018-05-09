//
//  TZCityListView.h
//  TZTest
//
//  Created by kinglian on 2018/4/27.
//  Copyright © 2018年 kinglian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FMDB/FMDB.h>
@interface TZCityListManage : NSObject
- (instancetype)initWithDatabase:(FMDatabase *)database;
- (NSArray *)getCityListWithParentID:(NSString *)parentID;
@end
