//
//  PSFantasyPlayer+CoreDataProperties.h
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import "PSFantasyPlayer+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PSFantasyPlayer (CoreDataProperties)

+ (NSFetchRequest<PSFantasyPlayer *> *)fetchRequest;

@property (nonatomic) int32_t rotoworldID;
@property (nonatomic) int32_t espnID;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nonatomic) int32_t jerseyNumber;
@property (nullable, nonatomic, retain) PSFantasyTeam *team;
@property (nullable, nonatomic, retain) PSRotoworldPlayer *rotoworld;

@end

NS_ASSUME_NONNULL_END
