//
//  SideMenuTableViewCell.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/29/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "SideMenuTableViewCell.h"

@interface SideMenuTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation SideMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleImageView.tintColor = UIColor.FNBarColor;
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    switch (index) {
        case 0:
            self.titleLabel.text = @"Recent News";
            self.titleImageView.image = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            break;
        case 1:
            self.titleLabel.text = @"Headlines";
            self.titleImageView.image = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            break;
        case 2:
            self.titleLabel.text = @"My News";
            self.titleImageView.image = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            break;
        case 3:
            self.titleLabel.text = @"My Fantasy";
            self.titleImageView.image = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            break;
        case 4:
            self.titleLabel.text = @"Settings";
            self.titleImageView.image = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            break;
        case 5:
            self.titleLabel.text = @"About";
            self.titleImageView.image = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            break;
        default:
            self.titleLabel.text = @"";
            self.titleImageView.image = nil;
            break;
    }
}

@end
