//
//  ViewController.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "ViewController.h"
#import "FNAPI.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [FNAPI.rotoworld newsWithStartingArticleID:0 completion:^(NSArray<NSObject *> *articles) {
        
    }];
}


@end
