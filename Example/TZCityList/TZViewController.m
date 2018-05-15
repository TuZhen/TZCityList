//
//  TZViewController.m
//  TZCityList
//
//  Created by TuZhen on 05/09/2018.
//  Copyright (c) 2018 TuZhen. All rights reserved.
//

#import "TZViewController.h"
#import "TZCityList.h"
@interface TZViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@end

@implementation TZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnDIdClickAction:(id)sender {
    __weak typeof(self) weakSelf = self;
    TZCityListSelectedStyle *style = [[TZCityListSelectedStyle alloc] init];
    style.selectedColor = [UIColor colorWithRed:96/255.0 green:136/255.0 blue:246/255.0 alpha:1];
    TZCityListMainView *cityView = [[TZCityListMainView alloc] initWithSelectedStyle:style];
    [cityView show];
    cityView.finishBlock = ^(NSArray *cityArr) {
        weakSelf.cityLabel.text = [cityArr componentsJoinedByString:@"\t"];
    };
}

@end
