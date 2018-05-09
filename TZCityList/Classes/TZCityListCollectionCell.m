//
//  KLCityListCollectionCell.m
//  KLCityListToolTest
//
//  Created by kinglian on 2018/5/3.
//  Copyright © 2018年 kinglian. All rights reserved.
//

#import "TZCityListCollectionCell.h"
#import "TZCityListTableViewCell.h"
#import "TZCityModel.h"

static NSString *TZCityListTableViewCellID = @"TZCityListTableViewCell";
@interface TZCityListCollectionCell()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) UITableView * myTableView; //

@end
@implementation TZCityListCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.myTableView];
    }
    return self;
}
- (void)setTableViewDataSource:(NSArray *)tableViewDataSource{
    _tableViewDataSource = tableViewDataSource;
    [self.myTableView reloadData];
}
- (void)setSelectedIndexStr:(NSString *)selectedIndexStr{
    _selectedIndexStr = selectedIndexStr;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewDataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TZCityListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TZCityListTableViewCellID];
    TZCityModel *model = self.tableViewDataSource[indexPath.row];
    cell.cityName = model.name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cityIsSelected = NO;
    if (self.selectedIndexStr && self.selectedIndexStr.integerValue == indexPath.row) {
        cell.cityIsSelected = YES;
    }
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(cityCellDidSelected:selectedIndex:)]) {
        KLCityModel *model = self.tableViewDataSource[indexPath.row];
        [self.delegate cityCellDidSelected:model selectedIndex:indexPath.row];
    }
}

#pragma mark - Lazy Load
- (UITableView *)myTableView{
    if (_myTableView) {
        return _myTableView;
    }
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    [_myTableView registerNib:[UINib nibWithNibName:@"KLCityListTableViewCell" bundle:[NSBundle bundleForClass:[self class]]] forCellReuseIdentifier:TZCityListTableViewCellID];
    _myTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 15)];
    return _myTableView;
}

@end
