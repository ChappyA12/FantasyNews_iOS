//
//  PlayerViewController.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/29/18.
//  Copyright © 2018 CA. All rights reserved.
//

#define FlexibleLayoutAttrs BLKFlexibleHeightBarSubviewLayoutAttributes

#import "PlayerViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BLKFlexibleHeightBar.h"
#import "BLKDelegateSplitter.h"
#import "PlayerNavBarBehaviorDefiner.h"
#import "NewsDetailTableViewCell.h"
#import "FNAPI.h"

@interface PlayerViewController ()
@property (nonatomic) NSMutableArray <RotoworldNews *> *allNews;
@property (nonatomic) NSInteger rotoworldPlayerID;
@property (nonatomic) CGFloat statusBarHeight;
@property (nonatomic) BLKFlexibleHeightBar *navBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) BOOL firstLoad;
@property (nonatomic) BLKDelegateSplitter *delegateSplitter;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstLoad = YES;
    self.statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    self.allNews = @[].mutableCopy;
    self.sideMenuController.leftViewEnabled = NO;
    self.tableView.dataSource = self;
    self.tableView.allowsSelection = NO;
    self.tableView.separatorColor = UIColor.clearColor;
    self.tableView.estimatedRowHeight = 280;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.firstLoad) {
        [self setUpNavBar];
        self.firstLoad = NO;
    }
    if (self.rotoworldPlayerID) {
        [self refreshNews];
    }
}

- (void)setNews:(RotoworldNews *)news {
    _news = news;
    self.rotoworldPlayerID = news.playerID;
    [self.allNews addObject:news];
}

- (void)refreshNews {
    [FNAPI.rotoworld newsForPlayerID:self.rotoworldPlayerID completion:^(NSArray<RotoworldNews *> *articles) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.allNews = articles.mutableCopy;
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allNews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NewsDetailTableViewCell" owner:self options:nil].firstObject;
    }
    cell.news = self.allNews[indexPath.row];
    return cell;
}

#pragma mark - scrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.tableView.scrollIndicatorInsets =
        UIEdgeInsetsMake(MAX(self.navBar.minimumBarHeight, -scrollView.contentOffset.y - self.statusBarHeight), 0, 0, 0);
}

- (void)setUpNavBar {
    self.navBar = [[BLKFlexibleHeightBar alloc] initWithFrame:
                        CGRectMake(0, 0, self.view.frame.size.width, 195 + self.statusBarHeight)];
    self.tableView.contentInset = UIEdgeInsetsMake(195, 0, 0, 0);
    self.navBar.minimumBarHeight = 44 + self.statusBarHeight;
    self.navBar.backgroundColor = UIColor.FNBarColor;
    [self setUpNavBarItems];
    [self.view addSubview:self.navBar];
    self.navBar.behaviorDefiner = [PlayerNavBarBehaviorDefiner new];
    self.delegateSplitter = [[BLKDelegateSplitter alloc] initWithFirstDelegate:self.navBar.behaviorDefiner
                                                                secondDelegate:self];
    self.tableView.delegate = self.delegateSplitter;
}

- (void)setUpNavBarItems {
    //IMAGE
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 86, 86)];
    imageView.layer.cornerRadius = 43;
    imageView.clipsToBounds = YES;
    imageView.layer.borderWidth = 2;
    imageView.layer.borderColor = UIColor.FNWhiteTextColor.CGColor;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView sd_setImageWithURL: self.news.imageURL
                 placeholderImage: nil];
    [self.navBar addSubview:imageView];
    
    FlexibleLayoutAttrs *initial = [FlexibleLayoutAttrs new];
    initial.size = imageView.frame.size;
    initial.center = CGPointMake(CGRectGetMidX(self.navBar.bounds), self.statusBarHeight + 43 + 12);
    [imageView addLayoutAttributes:initial forProgress:0];
    
    FlexibleLayoutAttrs *final = [[FlexibleLayoutAttrs alloc] initWithExistingLayoutAttributes:initial];
    CGAffineTransform translation = CGAffineTransformMakeTranslation(self.navBar.bounds.size.width/2.0 - 86 * 0.4,
                                                                     -36);
    CGAffineTransform scale = CGAffineTransformMakeScale(0.4, 0.4);
    final.transform = CGAffineTransformConcat(scale, translation);
    [imageView addLayoutAttributes:final forProgress:1];
    
    //NAME
    UILabel *label = [UILabel new];
    label.text = self.news.fullName;
    label.font = [UIFont boldSystemFontOfSize:28];
    label.textColor = UIColor.FNWhiteTextColor;
    [label sizeToFit];
    [self.navBar addSubview:label];
    
    FlexibleLayoutAttrs *initial2 = [FlexibleLayoutAttrs new];
    initial2.size = label.frame.size;
    initial2.center = CGPointMake(CGRectGetMidX(self.navBar.bounds), self.navBar.bounds.size.height - 76);
    [label addLayoutAttributes:initial2 forProgress:0];
    
    FlexibleLayoutAttrs *final2 = [[FlexibleLayoutAttrs alloc] initWithExistingLayoutAttributes:initial2];
    CGAffineTransform translation2 = CGAffineTransformMakeTranslation(0, -100);
    CGAffineTransform scale2 = CGAffineTransformMakeScale(0.7, 0.7);
    final2.transform = CGAffineTransformConcat(scale2, translation2);
    [label addLayoutAttributes:final2 forProgress:1];
    
    //TEAM
    UILabel *teamLabel = [UILabel new];
    teamLabel.text = self.news.teamPosition;
    teamLabel.font = [UIFont boldSystemFontOfSize:15];
    teamLabel.textColor = UIColor.FNWhiteTextColor;
    [teamLabel sizeToFit];
    [self.navBar addSubview:teamLabel];
    
    FlexibleLayoutAttrs *initial3 = [FlexibleLayoutAttrs new];
    initial3.size = teamLabel.frame.size;
    initial3.center = CGPointMake(CGRectGetMidX(self.navBar.bounds), self.navBar.bounds.size.height - 48);
    [teamLabel addLayoutAttributes:initial3 forProgress:0];
    
    FlexibleLayoutAttrs *final3 = [[FlexibleLayoutAttrs alloc] initWithExistingLayoutAttributes:initial3];
    final3.alpha = 0;
    CGAffineTransform translation3 = CGAffineTransformMakeTranslation(0, -110 * 0.8);
    CGAffineTransform scale3 = CGAffineTransformMakeScale(0.7, 0.7);
    final3.transform = CGAffineTransformConcat(scale3, translation3);
    [teamLabel addLayoutAttributes:final3 forProgress:0.8];
    
    //STATUS
    UILabel *statusLabel = [UILabel new];
    statusLabel.text = self.news.status;
    statusLabel.font = [UIFont boldSystemFontOfSize:15];
    statusLabel.textColor = UIColor.FNWhiteTextColor;
    [statusLabel sizeToFit];
    [self.navBar addSubview:statusLabel];
    
    FlexibleLayoutAttrs *initial4 = [FlexibleLayoutAttrs new];
    initial4.size = statusLabel.frame.size;
    initial4.center = CGPointMake(CGRectGetMidX(self.navBar.bounds), self.navBar.bounds.size.height - 28);
    [statusLabel addLayoutAttributes:initial4 forProgress:0];
    
    FlexibleLayoutAttrs *final4 = [[FlexibleLayoutAttrs alloc] initWithExistingLayoutAttributes:initial4];
    final4.alpha = 0;
    CGAffineTransform translation4 = CGAffineTransformMakeTranslation(0, -114 * 0.8);
    CGAffineTransform scale4 = CGAffineTransformMakeScale(0.7, 0.7);
    final4.transform = CGAffineTransformConcat(scale4, translation4);
    [statusLabel addLayoutAttributes:final4 forProgress:0.8];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIColor.statusBarStyle;
}

@end
