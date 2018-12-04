//
//  FantasyTeamTableViewCell.m
//  FantasyNews
//
//  Created by Chappy Asel on 12/4/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "FantasyTeamTableViewCell.h"

@implementation FantasyTeamTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.clearColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
