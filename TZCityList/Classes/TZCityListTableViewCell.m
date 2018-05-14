//
//  KLCityListTableViewCell.m
//  KLCityListToolTest
//
//  Created by kinglian on 2018/5/3.
//  Copyright © 2018年 kinglian. All rights reserved.
//

#import "TZCityListTableViewCell.h"
#import "TZCityListSelectedStyle.h"
#import "TZCityListSelectedStyle.h"
#define TextColorNormal [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]
@interface TZCityListTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectedSign;

@end

@implementation TZCityListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.selectedSign setImage:[TZCityListSelectedStyle selectedStyle].selectedCellSignImage forState:UIControlStateNormal];
}
- (void)setCityName:(NSString *)cityName{
    _cityName = cityName;
    self.cityNameLabel.text = cityName;
    
}
- (void)setCityIsSelected:(BOOL)cityIsSelected{
    _cityIsSelected = cityIsSelected;
    if (cityIsSelected) {
        self.cityNameLabel.textColor = [TZCityListSelectedStyle selectedStyle].selectedColor;
        self.selectedSign.hidden = NO;
        NSLog(@"选中City:%@",self.cityName);
    }else{
        self.cityNameLabel.textColor = TextColorNormal;
        self.selectedSign.hidden = YES;
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
