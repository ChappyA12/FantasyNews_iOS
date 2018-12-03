//
//  FantasyViewController.m
//  FantasyNews
//
//  Created by Chappy Asel on 12/1/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "FantasyViewController.h"
#import "NewsOverviewTableViewCell.h"
#import "ZFModalTransitionAnimator.h"
#import "ESPNLoginViewController.h"
#import "FantasySlidingView.h"

@interface FantasyViewController () <FantasySlidingViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) ZFModalTransitionAnimator *animator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property FantasySlidingView *slidingView;
@property (nonatomic) CGFloat deltaOffset;
@property (nonatomic) CGFloat lastOffset;
@end

@implementation FantasyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.title = @"My Fantasy";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadSlidingView];
}

- (IBAction)loginPressed:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ESPNLoginViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"espnlogin"];
    vc.originPoint = sender.center;
    self.animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:vc];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    self.animator.bounces = NO;
    self.animator.dragable = NO;
    self.animator.behindViewScale = 1.0;
    self.animator.behindViewAlpha = 1.0;
    self.animator.transitionDuration = 0;
    self.animator.direction = ZFModalTransitonDirectionBottom;
    vc.transitioningDelegate = self.animator;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - slidingView

- (void)loadSlidingView {
    if (!self.slidingView) {
        self.slidingView = [FantasySlidingView loadFromNIB];
        [self.slidingView setWidth:self.view.frame.size.width];
        [self.slidingView setYPos:self.view.frame.size.height - self.slidingView.minHeight];
        self.slidingView.delegate = self;
        [self.view addSubview:self.slidingView];
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, self.slidingView.minHeight + 20, 0);
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, self.slidingView.minHeight, 0);
    }
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsOverviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NewsOverviewTableViewCell" owner:self options:nil].firstObject;
    }
    //cell.news = self.news[indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat d = self.lastOffset - scrollView.contentOffset.y;
    if ((d > 0 && self.deltaOffset < 0) || (d < 0 && self.deltaOffset > 0))
        self.deltaOffset = 0;
    self.deltaOffset += d;
    if ((d > 0 && self.deltaOffset > 50) || scrollView.contentOffset.y + scrollView.frame.size.height >
                                            scrollView.contentSize.height + self.slidingView.minHeight) {
        [self.slidingView collapse:NO animated:YES];
    } else if (d < 0 && self.deltaOffset < -50 && scrollView.contentOffset.y > 0) {
        [self.slidingView collapse:YES animated:YES];
    }
    self.lastOffset = scrollView.contentOffset.y;
}

@end
