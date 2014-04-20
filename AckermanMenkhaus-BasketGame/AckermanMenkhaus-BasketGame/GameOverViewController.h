//
//  GameOverViewController.h
//  AckermanMenkhaus-BasketGame
//
//  Created by Chad Ackerman on 4/18/14.
//  Copyright (c) 2014 UC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameOverViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *teamOneFinalScore;
@property (weak, nonatomic) IBOutlet UILabel *teamTwoFinalScore;

@property (nonatomic) NSString *teamOneScore;
@property (nonatomic) NSString *teamTwoScore;

@property (weak, nonatomic) IBOutlet UILabel *winningTeamName;
@property (weak, nonatomic) IBOutlet UIButton *playAgain;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;

@end
