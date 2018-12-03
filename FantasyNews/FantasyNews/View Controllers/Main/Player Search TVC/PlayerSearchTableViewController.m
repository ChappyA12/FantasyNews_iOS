//
//  PlayerSearchTableViewController.m
//  FantasyNews
//
//  Created by Chappy Asel on 12/2/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "PlayerSearchTableViewController.h"
#import "NewsOverviewTableViewCell.h"
#import "FNAPI.h"

@interface PlayerSearchTableViewController ()
@property (nonatomic) NSArray <RotoworldPlayer *> *players;
@end

@implementation PlayerSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [FNAPI.rotoworld players:^(NSArray<RotoworldPlayer *> *players) {
        self.players = players;
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsOverviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NewsOverviewTableViewCell" owner:self options:nil].firstObject;
    }
    return cell;
}

@end
