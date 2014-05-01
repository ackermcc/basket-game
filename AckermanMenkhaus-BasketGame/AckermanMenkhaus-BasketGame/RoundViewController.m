//
//  RoundViewController.m
//  AckermanMenkhaus-BasketGame
//
//  Created by Chad Ackerman on 4/3/14.
//  Copyright (c) 2014 UC. All rights reserved.
//

#import "RoundViewController.h"
#import "GamePlayViewController.h"
#import "UIColor+BasketColors.h"

@interface RoundViewController ()
@property (nonatomic) BOOL firstOpen;
@end

@implementation RoundViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if (self.roundOver == YES) {
        self.gamePlayBasket = [self.basket mutableCopy];
        self.roundNumber ++;
        if (self.roundNumber == 2) {
            self.navigationItem.title = @"Charades";
        } else if (self.roundNumber == 3) {
            self.navigationItem.title = @"Password";
        }
        
        
        self.wordsRemaining.text = [NSString stringWithFormat:@"Words remaining: %lu", (unsigned long)self.gamePlayBasket.count];
        if (self.roundNumber == 2) {
            self.roundDescription.text = @"Describe the word or phrase using GESTURES";
        } else if (self.roundNumber == 3) {
            self.roundDescription.text = @"Describe the word or phrase using ONE WORD";
        }
        self.roundOver = NO;
    }
}

-(void)viewDidAppear:(BOOL)animated {
    if (self.firstOpen == NO) {
        if ([self.view.backgroundColor isEqual:[UIColor teal]]) {
            [UIView animateWithDuration:0.5 animations:^(void){
                self.view.backgroundColor = [UIColor red];
                [self.btnStartGame setTitleColor:[UIColor red] forState:UIControlStateNormal];
            }];
        } else {
            [UIView animateWithDuration:0.5 animations:^(void){
                self.view.backgroundColor = [UIColor teal];
                [self.btnStartGame setTitleColor:[UIColor teal] forState:UIControlStateNormal];
            }];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];
    
    self.gamePlayBasket = [self.basket mutableCopy];
    self.roundNumber = 1;
    self.teamTwoScore.backgroundColor = [UIColor red];
    self.teamOneScore.backgroundColor = [UIColor teal];
    
    [self.btnStartGame setTitleColor:[UIColor teal] forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor teal];
    
    self.firstOpen = YES;
    
    self.wordsRemaining.text = [NSString stringWithFormat:@"Words remaining: %lu", (unsigned long)self.gamePlayBasket.count];
}

- (IBAction)unwindToRound:(UIStoryboardSegue *)unwindSegue {}

-(IBAction)startGame:(id)sender {
    [self performSegueWithIdentifier:@"startGame" sender:self];
    self.firstOpen = NO;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    GamePlayViewController *destination = [segue destinationViewController];
    destination.basket = self.gamePlayBasket;
    destination.teamNumber = self.teamNumber.text;
    destination.roundNumber = self.roundNumber;
    destination.teamOneScore = self.teamOneScore;
    destination.teamTwoScore = self.teamTwoScore;
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
