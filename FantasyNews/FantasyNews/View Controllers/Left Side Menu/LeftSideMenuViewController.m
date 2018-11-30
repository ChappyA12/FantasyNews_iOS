//
//  LeftSideMenuViewController.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/29/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "LeftSideMenuViewController.h"
#import "SideMenuTableViewCell.h"
#import "MainViewController.h"

@interface LeftSideMenuViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LeftSideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = UIColor.clearColor;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SideMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SideMenuTableViewCell" owner:self options:nil].firstObject;
    }
    cell.index = indexPath.row;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc;
    switch (indexPath.row) {
        case 0:
            vc = [storyboard instantiateViewControllerWithIdentifier:@"main"];
            ((MainViewController *)vc).mode = MODE_RECENT;
            break;
        case 1:
            vc = [storyboard instantiateViewControllerWithIdentifier:@"main"];
            ((MainViewController *)vc).mode = MODE_HEADLINES;
            break;
        case 2:
            vc = [storyboard instantiateViewControllerWithIdentifier:@"main"];
            break;
        case 3:
            vc = [storyboard instantiateViewControllerWithIdentifier:@"main"];
            break;
        case 4:
            vc = [storyboard instantiateViewControllerWithIdentifier:@"settings"];
            break;
        case 5:
            vc = [storyboard instantiateViewControllerWithIdentifier:@"about"];
            break;
        default:
            break;
    }
    self.sideMenuController.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.sideMenuController hideLeftViewAnimated];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
