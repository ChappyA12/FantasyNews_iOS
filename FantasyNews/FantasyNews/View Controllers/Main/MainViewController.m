//
//  MainViewController.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "MainViewController.h"
#import "NewsOverviewTableViewCell.h"
#import "FNAPI.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) UISearchController *searchController;
@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) NSArray <RotoworldNews *> *news;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self refreshNews];
}

- (void)refreshNews {
    if ([self.mode isEqualToString:MODE_RECENT]) {
        [FNAPI.rotoworld newsWithStartingArticleID:0 completion:^(NSArray<RotoworldNews *> *articles) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.news = articles;
                [self.refreshControl endRefreshing];
                [self.tableView reloadData];
            });
        }];
    } else {
        [FNAPI.rotoworld newsHeadlines:^(NSArray<RotoworldNews *> *articles) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.news = articles;
                [self.refreshControl endRefreshing];
                [self.tableView reloadData];
            });
        }];
    }
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.news.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsOverviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NewsOverviewTableViewCell" owner:self options:nil].firstObject;
    }
    cell.news = self.news[indexPath.row];
    return cell;
}

- (void)setUpTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchBar.placeholder = @"Search Players";
    self.searchController.searchBar.delegate = self;
    self.navigationItem.searchController = self.searchController;
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = UIColor.FNWhiteTextColor;
    [self.refreshControl addTarget:self action:@selector(refreshNews)
                  forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = self.refreshControl;
    self.extendedLayoutIncludesOpaqueBars = YES;
}

@end