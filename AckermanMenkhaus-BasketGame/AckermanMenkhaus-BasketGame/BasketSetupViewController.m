//
//  BasketSetupViewController.m
//  AckermanMenkhaus-BasketGame
//
//  Created by Chad Ackerman on 4/3/14.
//  Copyright (c) 2014 UC. All rights reserved.
//

#import "BasketSetupViewController.h"
#import "RoundViewController.h"
#import "UIColor+BasketColors.h"
#import <UIView+DCAnimationKit.h>

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
    
    NSLog(@"Player Count: %ld", (long)self.playerCount);
    self.basket = [NSMutableArray new];
    
    self.inputOne.delegate = self;
    self.inputTwo.delegate = self;
    self.inputThree.delegate = self;
    
    if (self.playerCount == 4) {
        self.view.backgroundColor = [UIColor teal];
        [self.btnNextPlayer setTitleColor:[UIColor teal] forState:UIControlStateNormal];
    } else {
        self.view.backgroundColor = [UIColor red];
        [self.btnNextPlayer setTitleColor:[UIColor red] forState:UIControlStateNormal];
    }
    
//    self.view.backgroundColor = [UIColor teal];
//    [self.btnNextPlayer setTitleColor:[UIColor teal] forState:UIControlStateNormal];
    
    self.playerNumber = 1;
    self.navigationItem.title = [NSString stringWithFormat:@"Player %ld", (long)self.playerNumber];
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
    
    if ([self.inputOne.text isEqualToString:@""] || [self.inputTwo.text isEqualToString:@""] || [self.inputThree.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You have empty fields" message:@"You must fill in all items to pass to the next player" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];\
        [alert show];
    } else {
        [self.basket addObject:self.inputOne.text];
        [self.basket addObject:self.inputTwo.text];
        [self.basket addObject:self.inputThree.text];
        
        self.inputOne.text = @"";
        self.inputTwo.text = @"";
        self.inputThree.text = @"";
        
        if (self.playerNumber < self.playerCount) {
            self.playerNumber = self.playerNumber + 1;
            self.navigationItem.title = [NSString stringWithFormat:@"Player %ld", (long)self.playerNumber];
            
            if ([self.view.backgroundColor isEqual:[UIColor teal]]) {
                [UIView animateWithDuration:0.5 animations:^(void){
                    self.view.backgroundColor = [UIColor red];
                    [self.btnNextPlayer setTitleColor:[UIColor red] forState:UIControlStateNormal];
                }];
            } else {
                [UIView animateWithDuration:0.5 animations:^(void){
                    self.view.backgroundColor = [UIColor teal];
                    [self.btnNextPlayer setTitleColor:[UIColor teal] forState:UIControlStateNormal];
                }];
            }
            
        } else {
            [self performSegueWithIdentifier:@"beginRound" sender:self];
        }
    }
    
//    [self.inputOne drop:^(void){
//        [self.inputTwo drop:^(void){
//            [self.inputThree drop:^(void){
//                
//            }];
//        }];
//    }];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RoundViewController *destination = [segue destinationViewController];
    destination.basket = self.basket;
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
