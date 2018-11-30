//
//  NewsDetailTableViewCell.h
//  FantasyNews
//
//  Created by Chappy Asel on 11/29/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsDetailTableViewCell;

@protocol NewsDetailTableViewCellDelegate <NSObject>
- (void)newsDetailTableViewCell:(NewsDetailTableViewCell *)cell tappedURL:(NSURL *)url;
@end

@class RotoworldNews;

@interface NewsDetailTableViewCell : UITableViewCell

@property (nonatomic) id<NewsDetailTableViewCellDelegate> delegate;

@property (nonatomic) RotoworldNews *news;

@end
