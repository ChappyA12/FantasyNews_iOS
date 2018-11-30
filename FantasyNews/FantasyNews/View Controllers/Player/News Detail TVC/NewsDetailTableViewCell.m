//
//  NewsDetailTableViewCell.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/29/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "NewsDetailTableViewCell.h"
#import "RotoworldNews.h"
#import "TimeAgo.h"

@interface NewsDetailTableViewCell ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation NewsDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setNews:(RotoworldNews *)news {
    _news = news;
    NSMutableAttributedString *boldNews = [[NSMutableAttributedString alloc]
       initWithString:[news.news stringByAppendingString:@"\n"] attributes:
           @{NSFontAttributeName: [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold]}];
    NSAttributedString *regAnalysis = [[NSAttributedString alloc]
       initWithString:news.analysis attributes:
           @{NSFontAttributeName: [UIFont systemFontOfSize:16 weight:UIFontWeightRegular]}];
    [boldNews appendAttributedString:regAnalysis];
    self.textView.attributedText = boldNews;
    self.dateLabel.text = [TimeAgo extendedDate:news.date];
}

@end
