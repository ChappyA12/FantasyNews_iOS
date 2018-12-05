//
//  PSRotoworldNews+CoreDataProperties.h
//  
//
//  Created by Chappy Asel on 12/4/18.
//
//

#import "PSRotoworldNews+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PSRotoworldNews (CoreDataProperties)

+ (NSFetchRequest<PSRotoworldNews *> *)fetchRequest;

@property (nonatomic) int32_t articleID;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nonatomic) int32_t playerID;
@property (nullable, nonatomic, copy) NSString *headline;
@property (nullable, nonatomic, copy) NSString *news;
@property (nullable, nonatomic, copy) NSString *analysis;
@property (nullable, nonatomic, copy) NSString *sourceTitle;
@property (nullable, nonatomic, copy) NSString *sourceLink;
@property (nullable, nonatomic, copy) NSString *status;
@property (nonatomic) BOOL injured;
@property (nonatomic) BOOL active;
@property (nullable, nonatomic, retain) PSRotoworldPlayer *player;

@end

NS_ASSUME_NONNULL_END
