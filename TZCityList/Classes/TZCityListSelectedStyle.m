//
//  TZSelectedStyle.m
//  FMDB
//
//  Created by kinglian on 2018/5/14.
//

#import "TZCityListSelectedStyle.h"



#define SelectedDefulColor [UIColor colorWithRed:28/255.0 green:163/255.0 blue:228/255.0 alpha:1]

@implementation TZCityListSelectedStyle

+ (instancetype)selectedStyle{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *selectedStylePath = [docPath stringByAppendingString:@"TZCityListSelectedStyle.selectedStyle"];
    TZCityListSelectedStyle *style = [NSKeyedUnarchiver unarchiveObjectWithFile:selectedStylePath];
    
    
    NSBundle *podBundle = [NSBundle bundleForClass:[self class]];
    NSString *TZCityListResourcesBundlePath = [podBundle pathForResource:@"TZCityListResources" ofType:@"bundle"];
    NSBundle *TZCityListResourcesBundle = [NSBundle bundleWithPath:TZCityListResourcesBundlePath];
    NSString *imagePath = [TZCityListResourcesBundle pathForResource:@"ic_blueTick@3x" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    if (!style) {
        style = [[self alloc] init];
        style.selectedColor = SelectedDefulColor;
        style.selectedCellSignImage = image;
    }
    if (!style.selectedColor) {
        style.selectedColor = SelectedDefulColor;
    }
    if (!style.selectedCellSignImage) {
        style.selectedCellSignImage = image;
    }
    return style;
}
- (void)saveSelectedStyle{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *selectedStylePath = [docPath stringByAppendingString:@"TZCityListSelectedStyle.selectedStyle"];
    [NSKeyedArchiver archiveRootObject:self toFile:selectedStylePath];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.selectedColor = [aDecoder decodeObjectForKey:@"TZCityListSelectedColorKey"];
        self.selectedCellSignImage = [aDecoder decodeObjectForKey:@"TZCityListSelectedCellSignImageKey"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.selectedColor forKey:@"TZCityListSelectedColorKey"];
    [aCoder encodeObject:self.selectedCellSignImage forKey:@"TZCityListSelectedCellSignImageKey"];
}
@end
