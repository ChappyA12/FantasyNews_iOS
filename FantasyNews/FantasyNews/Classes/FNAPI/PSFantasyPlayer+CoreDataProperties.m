//
//  PSFantasyPlayer+CoreDataProperties.m
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import "PSFantasyPlayer+CoreDataProperties.h"

@implementation PSFantasyPlayer (CoreDataProperties)

+ (NSFetchRequest<PSFantasyPlayer *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"PSFantasyPlayer"];
}

@dynamic rotoworldID;
@dynamic espnID;
@dynamic firstName;
@dynamic lastName;
@dynamic jerseyNumber;
@dynamic team;
@dynamic rotoworld;

@end
