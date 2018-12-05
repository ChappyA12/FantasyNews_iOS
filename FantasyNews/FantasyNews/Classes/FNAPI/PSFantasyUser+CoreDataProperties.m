//
//  PSFantasyUser+CoreDataProperties.m
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import "PSFantasyUser+CoreDataProperties.h"

@implementation PSFantasyUser (CoreDataProperties)

+ (NSFetchRequest<PSFantasyUser *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"PSFantasyUser"];
}

@dynamic userID;
@dynamic teams;

@end
