//
//  GamePlayViewController.h
//  AckermanMenkhaus-BasketGame
//
//  Created by Chad Ackerman on 4/3/14.
//  Copyright (c) 2014 UC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GamePlayViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic) NSMutableArray *basket;
@property (nonatomic) NSString *teamNumber; 
@property (weak, nonatomic) IBOutlet UILabel *activeWord;
@property (nonatomic) NSMutableArray *correctAnswers;
@property (weak, nonatomic) IBOutlet UIProgressView *gameTimer;

@property (weak, nonatomic) IBOutlet UIButton *btnCorrectWord;
@property (weak, nonatomic) IBOutlet UIButton *btnSkipWord;


@property (nonatomic) BOOL roundOver;
@property (nonatomic) NSUInteger roundNumber;


@end
