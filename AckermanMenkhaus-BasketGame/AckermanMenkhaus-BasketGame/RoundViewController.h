//
//  RoundViewController.h
//  AckermanMenkhaus-BasketGame
//
//  Created by Chad Ackerman on 4/3/14.
//  Copyright (c) 2014 UC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *wordsRemaining;
@property (weak, nonatomic) IBOutlet UILabel *teamOneScore;
@property (weak, nonatomic) IBOutlet UILabel *teamTwoScore;
@property (weak, nonatomic) IBOutlet UILabel *teamNumber;

@property (nonatomic) NSMutableArray *basket;
@property (nonatomic) NSMutableArray *replaceArray;

@end
