//
//  PSRotoworldNews+CoreDataClass.m
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import "PSRotoworldNews+CoreDataClass.h"
#import "PSRotoworldPlayer+CoreDataClass.h"
#import "FNCoreData.h"
#import "FNAPI.h"

@implementation PSRotoworldNews

+ (void)saveRecentNews:(void(^)(BOOL success))completion {
    [FNAPI.rotoworld newsWithStartingArticleID:0 completion:^(NSArray<RotoworldNews *> *articles) {
        [self saveNews:articles];
        completion(YES);
    }];
}

+ (void)saveRecentNewsForPlayerID:(NSInteger)playerID
                       completion:(void(^)(BOOL success))completion {
    [FNAPI.rotoworld newsForPlayerID:playerID completion:^(NSArray<RotoworldNews *> *articles) {
        [self saveNews:articles];
        completion(YES);
    }];
}

+ (NSArray<PSRotoworldNews *> *)newsForQuery:(NSString *)searchString {
    NSFetchRequest *request = [PSRotoworldNews fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"headline OR news OR analysis CONTAINS[cd] %@", searchString];
    return [FNCoreData.sharedInstance.context executeFetchRequest:request error:nil];
}

+ (PSRotoworldNews *)newsForArticleID:(NSInteger)articleID {
    NSFetchRequest *request = [PSRotoworldNews fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"articleID = %ld", articleID];
    NSArray *result = [FNCoreData.sharedInstance.context executeFetchRequest:request error:nil];
    return (result.count) ? result.firstObject : nil;
}

#pragma mark - private helper methods

+ (PSRotoworldNews *)persistentNewsforNews:(RotoworldNews *)news {
    NSManagedObjectContext *context = FNCoreData.sharedInstance.context;
    PSRotoworldNews *psNews =
        [NSEntityDescription insertNewObjectForEntityForName:@"PSRotoworldNews"
                                      inManagedObjectContext:context];
    psNews.articleID = (int32_t)news.articleID;
    psNews.date = news.date;
    psNews.playerID = (int32_t)news.playerID;
    psNews.headline = news.headline;
    psNews.news = news.news;
    psNews.analysis = news.analysis;
    psNews.sourceTitle = news.sourceTitle;
    psNews.sourceLink = news.sourceLink;
    psNews.status = news.status;
    psNews.injured = news.injured;
    psNews.active = news.active;
    PSRotoworldPlayer *player = [PSRotoworldPlayer playerForRotoworldID:news.playerID];
    if (!player) {
        RotoworldPlayer *tempPlayer = [[RotoworldPlayer alloc] init];
        tempPlayer.playerID = news.playerID;
        tempPlayer.firstName = news.firstName;
        tempPlayer.lastName = news.lastName;
        tempPlayer.position = news.position;
        tempPlayer.team = news.team;
        player = [PSRotoworldPlayer persistentPlayerforPlayer:tempPlayer];
    }
    psNews.player = player;
    [player addNewsObject:psNews];
    return psNews;
}

#pragma mark - private helper methods

+ (void)saveNews:(NSArray<RotoworldNews *> *)articles {
    for (RotoworldNews *news in articles) {
        if (![self newsForArticleID:news.articleID]) {
            [self persistentNewsforNews:news];
            NSLog(@"Added %ld", news.articleID);
        }
    }
    [FNCoreData.sharedInstance save];
}

@end
