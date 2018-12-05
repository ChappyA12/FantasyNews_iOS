//
//  PSRotoworldNews+CoreDataProperties.m
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import "PSRotoworldNews+CoreDataProperties.h"

@implementation PSRotoworldNews (CoreDataProperties)

+ (NSFetchRequest<PSRotoworldNews *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"PSRotoworldNews"];
}

@dynamic articleID;
@dynamic date;
@dynamic playerID;
@dynamic headline;
@dynamic news;
@dynamic analysis;
@dynamic sourceTitle;
@dynamic sourceLink;
@dynamic status;
@dynamic injured;
@dynamic active;
@dynamic player;

@end
