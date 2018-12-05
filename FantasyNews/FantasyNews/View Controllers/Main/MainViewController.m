//
//  MainViewController.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "MainViewController.h"
#import "PlayerSearchTableViewController.h"
#import "NewsOverviewTableViewCell.h"
#import "ZFModalTransitionAnimator.h"
#import "PlayerViewController.h"
#import "PSRotoworldTeam+CoreDataClass.h"
#import "PSRotoworldPlayer+CoreDataClass.h"
#import "PSRotoworldNews+CoreDataClass.h"
#import "FNCoreData.h"
#import "FNAPI.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) UISearchController *searchController;
@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) ZFModalTransitionAnimator *animator;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.context = FNCoreData.sharedInstance.context;
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error])
        NSLog(@"Main fetch error: %@, %@", error, [error userInfo]);
    [self setUpTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshNews];
    [PSRotoworldTeam saveAllTeams:^(BOOL success) {
        [PSRotoworldPlayer saveAllPlayers:^(BOOL success) {
            [PSRotoworldNews saveRecentNews:^(BOOL success) {
                
            }];
        }];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateSearchButtons];
}

- (void)refreshNews {
    if ([self.mode isEqualToString:MODE_RECENT]) {
        [PSRotoworldNews saveRecentNews:^(BOOL success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.refreshControl endRefreshing];
            });
        }];
    } else {
        [PSRotoworldNews saveRecentNews:^(BOOL success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.refreshControl endRefreshing];
            });
        }];
    }
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchedResultsController.fetchedObjects.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsOverviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NewsOverviewTableViewCell" owner:self options:nil].firstObject;
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(NewsOverviewTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.news = [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PlayerViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"player"];
    vc.news = [self.fetchedResultsController objectAtIndexPath:indexPath];
    self.animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:vc];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    self.animator.bounces = NO;
    self.animator.dragable = YES;
    self.animator.behindViewScale = 1.0;
    self.animator.behindViewAlpha = 0.8;
    self.animator.transitionDuration = 0.5;
    self.animator.direction = ZFModalTransitonDirectionRight;
    vc.transitioningDelegate = self.animator;
    [self presentViewController:vc animated:YES completion:nil];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)setUpTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.extendedLayoutIncludesOpaqueBars = YES;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PlayerSearchTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"playersearch"];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:vc];
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.tintColor = UIColor.FNBarColor;
    [UITextField appearanceWhenContainedInInstancesOfClasses:@[UISearchBar.class]].defaultTextAttributes =
        @{NSForegroundColorAttributeName: UIColor.darkGrayColor};
    UITextField *field = [self.searchController.searchBar valueForKey:@"searchField"];
    UIView *bg = field.subviews.firstObject;
    bg.backgroundColor = UIColor.whiteColor;
    bg.layer.cornerRadius = 10;
    bg.clipsToBounds = true;
    [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[UISearchBar.class]].tintColor = UIColor.whiteColor;
    self.definesPresentationContext = YES;
    self.navigationItem.searchController = self.searchController;
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = UIColor.FNWhiteTextColor;
    [self.refreshControl addTarget:self action:@selector(refreshNews) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = self.refreshControl;
}

#pragma mark - fetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) return _fetchedResultsController;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"PSRotoworldNews" inManagedObjectContext:self.context];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO]];
    fetchRequest.fetchBatchSize = 50;
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                          managedObjectContext:self.context
                                                                            sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController = frc;
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
}

#pragma mark - searchController

- (void)willPresentSearchController:(UISearchController *)searchController {
    NSLog(@"present");
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"change");
    [self updateSearchButtons];
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    NSLog(@"dismiss");
}

- (void)updateSearchButtons {
    UITextField *field = [self.searchController.searchBar valueForKey:@"searchField"];
    field.attributedPlaceholder = [[NSAttributedString alloc]
        initWithString:@"Search Players" attributes:@{NSForegroundColorAttributeName: UIColor.lightGrayColor}];
    UIImageView *left = (UIImageView *)field.leftView;
    left.image = [left.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    left.tintColor = UIColor.darkGrayColor;
    UIButton *right = (UIButton *)[field valueForKey:@"clearButton"];
    [right setImage:[right.currentImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
           forState:UIControlStateNormal];
    right.tintColor = UIColor.lightGrayColor;
}

#pragma mark - fetchedResultsController delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
