//
//  PlayerSearchTableViewController.m
//  FantasyNews
//
//  Created by Chappy Asel on 12/2/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "PlayerSearchTableViewController.h"
#import "PlayerTableViewCell.h"
#import "TeamTableViewCell.h"
#import "NewsOverviewTableViewCell.h"
#import "FNCoreData.h"
#import "FNAPI.h"

@interface PlayerSearchTableViewController () <NSFetchedResultsControllerDelegate>
@property (nonatomic) NSFetchedResultsController *playerFRC;
@property (nonatomic) NSFetchedResultsController *teamFRC;
@property (nonatomic) NSFetchedResultsController *newsFRC;
@property (nonatomic) NSManagedObjectContext *context;
@end

@implementation PlayerSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.context = FNCoreData.sharedInstance.context;
    NSError *error;
    self.playerFRC.delegate = self;
    if (![self.playerFRC performFetch:&error])
        NSLog(@"Player search fetch error: %@, %@", error, [error userInfo]);
    if (![self.teamFRC performFetch:&error])
        NSLog(@"Player search fetch error: %@, %@", error, [error userInfo]);
    if (![self.newsFRC performFetch:&error])
        NSLog(@"Player search fetch error: %@, %@", error, [error userInfo]);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: return @"Players"; break;
        case 1: return @"Teams"; break;
        case 2: return @"News"; break;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return MIN(20, self.playerFRC.fetchedObjects.count); break;
        case 1: return MIN(5, self.teamFRC.fetchedObjects.count); break;
        case 2: return MIN(50, self.newsFRC.fetchedObjects.count); break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: ((PlayerTableViewCell *)cell).player =
            [self.playerFRC objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]]; break;
        case 1: ((TeamTableViewCell *)cell).team =
            [self.teamFRC objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]]; break;
        case 2: ((NewsOverviewTableViewCell *)cell).news =
            [self.newsFRC objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]]; break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"PlayerTableViewCell" owner:self options:nil].firstObject;
        }
    } else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"TeamTableViewCell" owner:self options:nil].firstObject;
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"NewsOverviewTableViewCell" owner:self options:nil].firstObject;
        }
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - fetchedResultsController

- (void)updateFRCsWithSearchText:(NSString *)searchText {
    self.playerFRC.fetchRequest.predicate = [NSPredicate predicateWithFormat:@"lastName CONTAINS %@", searchText];
    self.teamFRC.fetchRequest.predicate = [NSPredicate predicateWithFormat:@"city CONTAINS %@", searchText];
    self.newsFRC.fetchRequest.predicate = [NSPredicate predicateWithFormat:@"analysis CONTAINS %@", searchText];
    NSError *error;
    if (![self.playerFRC performFetch:&error])
        NSLog(@"Player search fetch error %@, %@", error, [error userInfo]);
    if (![self.teamFRC performFetch:&error])
        NSLog(@"Player search fetch error %@, %@", error, [error userInfo]);
    if (![self.newsFRC performFetch:&error])
        NSLog(@"Player search fetch error %@, %@", error, [error userInfo]);
    [self.tableView reloadData];
}

- (NSFetchedResultsController *)playerFRC {
    if (_playerFRC != nil) return _playerFRC;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"PSRotoworldPlayer" inManagedObjectContext:self.context];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:NO]];
    fetchRequest.fetchBatchSize = 20;
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                          managedObjectContext:self.context
                                                                            sectionNameKeyPath:nil cacheName:nil];
    self.playerFRC = frc;
    _playerFRC.delegate = self;
    return _playerFRC;
}

- (NSFetchedResultsController *)teamFRC {
    if (_teamFRC != nil) return _teamFRC;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"PSRotoworldTeam" inManagedObjectContext:self.context];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"city" ascending:NO]];
    fetchRequest.fetchBatchSize = 5;
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                          managedObjectContext:self.context
                                                                            sectionNameKeyPath:nil cacheName:nil];
    self.teamFRC = frc;
    _teamFRC.delegate = self;
    return _teamFRC;
}

- (NSFetchedResultsController *)newsFRC {
    if (_newsFRC != nil) return _newsFRC;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"PSRotoworldNews" inManagedObjectContext:self.context];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO]];
    fetchRequest.fetchBatchSize = 20;
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                          managedObjectContext:self.context
                                                                            sectionNameKeyPath:nil cacheName:nil];
    self.newsFRC = frc;
    _newsFRC.delegate = self;
    return _newsFRC;
}

#pragma mark - searchBar

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self updateFRCsWithSearchText:searchText];
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
