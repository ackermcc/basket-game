//
//  BasketSetupViewController.m
//  AckermanMenkhaus-BasketGame
//
//  Created by Chad Ackerman on 4/3/14.
//  Copyright (c) 2014 UC. All rights reserved.
//

#import "BasketSetupViewController.h"

@interface BasketSetupViewController ()
@property (nonatomic) NSInteger playerNumber;
@end

@implementation BasketSetupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Player Count: %d", self.playerCount);
    self.basket = [NSMutableArray new];
    
    self.inputOne.delegate = self;
    self.inputTwo.delegate = self;
    self.inputThree.delegate = self;
    
    self.playerNumber = 1;
    self.navigationItem.title = [NSString stringWithFormat:@"Player %d", self.playerNumber];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    textField.delegate = self;
    if (textField == self.inputOne) {
        [textField resignFirstResponder];
        [self.inputTwo becomeFirstResponder];
    }
    else if (textField == self.inputTwo) {
        [textField resignFirstResponder];
        [self.inputThree becomeFirstResponder];
    }
    else if (textField == self.inputThree) {
        [textField resignFirstResponder];
        [self nextPlayer:self];
    }
    return YES;
}

-(IBAction)nextPlayer:(id)sender{
    [self.basket addObject:self.inputOne.text];
    [self.basket addObject:self.inputTwo.text];
    [self.basket addObject:self.inputThree.text];
    
    self.inputOne.text = @"";
    self.inputTwo.text = @"";
    self.inputThree.text = @"";
    
    if (self.playerCount == 4) {
        if (self.playerNumber < self.playerCount) {
            self.playerNumber = self.playerNumber + 1;
            self.navigationItem.title = [NSString stringWithFormat:@"Player %d", self.playerNumber];
        } else {
            NSLog(@"Done!");
        }
    } else {
        if (self.playerNumber < self.playerCount) {
            self.playerNumber = self.playerNumber + 1;
            self.navigationItem.title = [NSString stringWithFormat:@"Player %d", self.playerNumber];
        } else {
            NSLog(@"Done!");
        }
    }
    
    NSLog(@"This is the basket: %@", self.basket);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end