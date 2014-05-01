//
//  BasketSetupViewController.h
//  AckermanMenkhaus-BasketGame
//
//  Created by Chad Ackerman on 4/3/14.
//  Copyright (c) 2014 UC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface BasketSetupViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic) IBOutlet UITextField *inputOne;
@property (nonatomic) IBOutlet UITextField *inputTwo;
@property (nonatomic) IBOutlet UITextField *inputThree;

@property (nonatomic) NSInteger playerCount;
@property (nonatomic) NSMutableArray *basket;
@property (weak, nonatomic) IBOutlet UIButton *btnNextPlayer;

@end
