//
//  PSRotoworldTeam+CoreDataProperties.m
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import "PSRotoworldTeam+CoreDataProperties.h"

@implementation PSRotoworldTeam (CoreDataProperties)

+ (NSFetchRequest<PSRotoworldTeam *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"PSRotoworldTeam"];
}

@dynamic teamID;
@dynamic city;
@dynamic name;
@dynamic rawColor;
@dynamic conference;
@dynamic division;
@dynamic official;
@dynamic players;

@end
