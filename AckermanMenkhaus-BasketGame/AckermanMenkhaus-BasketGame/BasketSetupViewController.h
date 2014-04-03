//
//  BasketSetupViewController.h
//  AckermanMenkhaus-BasketGame
//
//  Created by Chad Ackerman on 4/3/14.
//  Copyright (c) 2014 UC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasketSetupViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputOne;
@property (weak, nonatomic) IBOutlet UITextField *inputTwo;
@property (weak, nonatomic) IBOutlet UITextField *inputThree;

@property (nonatomic) NSInteger playerCount;
@property (nonatomic) NSMutableArray *basket;

@end
