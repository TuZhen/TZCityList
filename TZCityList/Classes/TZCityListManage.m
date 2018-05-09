//
//  TZCityListView.m
//  TZTest
//
//  Created by kinglian on 2018/4/27.
//  Copyright © 2018年 kinglian. All rights reserved.
//

#import "TZCityListManage.h"
#import "TZCityModel.h"

@interface TZCityListManage ()

@property (nonatomic ,strong) FMDatabase * dataBase;


@end

@implementation TZCityListManage

- (instancetype)initWithDatabase:(FMDatabase *)database{
    if (self = [super init]) {
        _dataBase = database;
    }
    return self;
}
- (NSArray *)getCityListWithParentID:(NSString *)parentID{
    
    NSMutableArray *cityList = [NSMutableArray array];
    FMResultSet *resultSet = [self.dataBase executeQuery:@"select * from city where parentId = ?",parentID];
    while ([resultSet next]) {
        TZCityModel *city = [[TZCityModel alloc] init];
        city.name = [resultSet stringForColumn:@"name"];
        city.parentId = [resultSet intForColumn:@"parentId"];
        city.Id = [resultSet intForColumn:@"id"];
        city.code = [resultSet intForColumn:@"code"];
        [cityList addObject:city];
    }
    return cityList;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
