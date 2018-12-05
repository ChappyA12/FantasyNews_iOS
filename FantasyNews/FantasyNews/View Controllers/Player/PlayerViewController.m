//
//  PlayerViewController.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/29/18.
//  Copyright © 2018 CA. All rights reserved.
//

#define FlexibleLayoutAttrs BLKFlexibleHeightBarSubviewLayoutAttributes

#import "PlayerViewController.h"
#import "PSRotoworldNews+CoreDataClass.h"
#import "PSRotoworldPlayer+CoreDataClass.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SafariServices/SafariServices.h>
#import "BLKFlexibleHeightBar.h"
#import "BLKDelegateSplitter.h"
#import "PlayerNavBarBehaviorDefiner.h"
#import "NewsDetailTableViewCell.h"
#import "FNCoreData.h"
#import "FNAPI.h"

@interface PlayerViewController () <UITableViewDelegate, UITableViewDataSource, NewsDetailTableViewCellDelegate, SFSafariViewControllerDelegate, NSFetchedResultsControllerDelegate>
@property (nonatomic) NSInteger rotoworldPlayerID;
@property (nonatomic) CGFloat statusBarHeight;
@property (nonatomic) BLKFlexibleHeightBar *navBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) BOOL firstLoad;
@property (nonatomic) BLKDelegateSplitter *delegateSplitter;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstLoad = YES;
    self.context = FNCoreData.sharedInstance.context;
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error])
        NSLog(@"Main fetch error: %@, %@", error, [error userInfo]);
    self.statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
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

- (void)setNews:(PSRotoworldNews *)news {
    _news = news;
    self.rotoworldPlayerID = news.playerID;
}

- (void)refreshNews {
    [PSRotoworldNews saveRecentNewsForPlayerID:self.rotoworldPlayerID completion:^(BOOL success) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //refresh control
        });
    }];
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchedResultsController.fetchedObjects.count;
}

- (void)configureCell:(NewsDetailTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.news = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.delegate = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NewsDetailTableViewCell" owner:self options:nil].firstObject;
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - scrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.tableView.scrollIndicatorInsets =
        UIEdgeInsetsMake(MAX(self.navBar.minimumBarHeight, -scrollView.contentOffset.y - self.statusBarHeight), 0, 0, 0);
}

#pragma mark - newsDetailTVC

- (void)newsDetailTableViewCell:(NewsDetailTableViewCell *)cell tappedURL:(NSURL *)url {
    SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:url];
    svc.delegate = self;
    [self presentViewController:svc animated:YES completion:nil];
}

#pragma mark - safariVC

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    
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
    [imageView sd_setImageWithURL: self.news.player.imageURL
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
    label.text = self.news.player.fullName;
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
    teamLabel.text = self.news.player.fullTeamPosition;
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

#pragma mark - fetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) return _fetchedResultsController;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"PSRotoworldNews" inManagedObjectContext:self.context];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"playerID = %ld", self.rotoworldPlayerID];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO]];
    fetchRequest.fetchBatchSize = 50;
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                          managedObjectContext:self.context
                                                                            sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController = frc;
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
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
