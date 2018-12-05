//
//  PSRotoworldPlayer+CoreDataProperties.m
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import "PSRotoworldPlayer+CoreDataProperties.h"

@implementation PSRotoworldPlayer (CoreDataProperties)

+ (NSFetchRequest<PSRotoworldPlayer *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"PSRotoworldPlayer"];
}

@dynamic rotoworldID;
@dynamic espnID;
@dynamic firstName;
@dynamic lastName;
@dynamic position;
@dynamic teamID;
@dynamic birthday;
@dynamic team;
@dynamic news;
@dynamic fantasy;

@end
