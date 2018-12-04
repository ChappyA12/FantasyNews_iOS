//
//  FantasySlidingView.m
//  FantasyNews
//
//  Created by Chappy Asel on 12/2/18.
//  Copyright © 2018 CD. All rights reserved.
//

#import "FantasySlidingView.h"
#import "FantasyTeamTableViewCell.h"

@interface FantasySlidingView() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) FantasyTeamTableViewCell *topCell;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) UISelectionFeedbackGenerator *feedback;
@end

@implementation FantasySlidingView

+ (instancetype)loadFromNIB {
    FantasySlidingView *navBar = [[NSBundle mainBundle] loadNibNamed:@"FantasySlidingView" owner:self options:nil].firstObject;
    [navBar load];
    navBar.feedback = [[UISelectionFeedbackGenerator alloc] init];
    navBar.notchAdjustment = 10;
    navBar.minHeight = 95;
    navBar.maxHeight = 95 + 15 + 80*2;
    navBar.bottomContainerViewHeightConstraint.constant = 85*2;
    [navBar loadTopCell];
    [navBar loadTableView];
    return navBar;
}

- (void)setWidth:(float)width {
    [super setWidth:width];
}

- (void)loadTopCell {
    self.topCell = [NSBundle.mainBundle loadNibNamed:@"FantasyTeamTableViewCell" owner:self options:nil].firstObject;
    self.topCell.frame = self.topContainerView.bounds;
    self.topCell.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.topContainerView addSubview:self.topCell];
}

- (void)loadTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = UIColor.clearColor;
    self.tableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bottomContainerView.bounds;
    gradientLayer.colors = @[(id)UIColor.clearColor.CGColor, (id)UIColor.whiteColor.CGColor];
    CGFloat end = 10 / self.bottomContainerView.frame.size.height;
    gradientLayer.startPoint = CGPointMake(1, 0);
    gradientLayer.endPoint = CGPointMake(1, end);
    self.bottomContainerView.layer.mask = gradientLayer;
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FantasyTeamTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [NSBundle.mainBundle loadNibNamed:@"FantasyTeamTableViewCell" owner:self options:nil].firstObject;
    }
    return cell;
}

@end
