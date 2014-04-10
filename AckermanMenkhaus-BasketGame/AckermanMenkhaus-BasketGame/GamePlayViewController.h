//
//  GamePlayViewController.h
//  AckermanMenkhaus-BasketGame
//
//  Created by Chad Ackerman on 4/3/14.
//  Copyright (c) 2014 UC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GamePlayViewController : UIViewController

@property (nonatomic) NSMutableArray *basket;
@property (nonatomic) NSString *teamNumber; 
@property (weak, nonatomic) IBOutlet UILabel *activeWord;
@property (nonatomic) NSMutableArray *teamOneCorrectAnswers;
@property (nonatomic) NSMutableArray *teamTwoCorrectAnswers;
@property (weak, nonatomic) IBOutlet UIProgressView *gameTimer;




@end
