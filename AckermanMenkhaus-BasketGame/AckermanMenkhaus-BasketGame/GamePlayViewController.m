//
//  GamePlayViewController.m
//  AckermanMenkhaus-BasketGame
//
//  Created by Chad Ackerman on 4/3/14.
//  Copyright (c) 2014 UC. All rights reserved.
//

#import "GamePlayViewController.h"
#import "RoundViewController.h"
#import "UIColor+BasketColors.h"

@interface GamePlayViewController ()
@property (nonatomic) NSUInteger activeWordIndex;
@property (nonatomic) NSTimer *gameClock;
@end

@implementation GamePlayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.btnSkipWord.backgroundColor = [UIColor red];
    self.btnCorrectWord.backgroundColor = [UIColor teal];
   
    
    self.correctAnswers = [[NSMutableArray alloc] init];

    [self shuffle:self.basket];
    
    self.activeWordIndex = 0;
    
    self.activeWord.text = [self.basket objectAtIndex:self.activeWordIndex];
    
    self.gameClock = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    
    self.roundOver = NO;
}

- (void)shuffle:(NSMutableArray *)shuffleArray
{
    NSUInteger count = [shuffleArray count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSUInteger nElements = count - i;
        NSUInteger n = arc4random_uniform(nElements) + i;
        [shuffleArray exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

- (IBAction)correctWord:(id)sender {
    if (self.basket.count > 1) {
        //Move correct word from basket to team array
        [self.correctAnswers addObject:[self.basket objectAtIndex:0]];
        
        [self.basket removeObjectAtIndex:self.activeWordIndex];
        
        //Choose next word
        self.activeWord.text = [self.basket objectAtIndex:self.activeWordIndex];
    } else if (self.basket.count == 1 && self.roundNumber == 3){
        [self performSegueWithIdentifier:@"gameOver" sender:self];
        [self.gameClock invalidate];
    } else {
        [self.correctAnswers addObject:[self.basket objectAtIndex:0]];
        [self.basket removeObjectAtIndex:self.activeWordIndex];
        
        NSLog(@"correct answers: %@", self.correctAnswers);
        
        UIAlertView *emptyBasket = [[UIAlertView alloc] initWithTitle:@"The basket is empty!" message:[NSString stringWithFormat:@"You got %lu correct!", (unsigned long)[self.correctAnswers count]] delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        
        self.roundOver = YES;
        
        [self.gameClock invalidate];
        [emptyBasket show];
    }
}

-(void) updateTimer {
    float newProgress = [self.gameTimer progress] + 0.00825;
    [self.gameTimer setProgress:newProgress animated:YES];
    
    if (newProgress >= 1.0) {
        [self.gameClock invalidate];
        [self endTurn];
    }
    
}

-(void)endTurn {
    UIAlertView *scoreAlert = [[UIAlertView alloc] initWithTitle:@"Time is up!" message:[NSString stringWithFormat:@"You got %lu correct!", (unsigned long)[self.correctAnswers count]] delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    
    [scoreAlert show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self performSegueWithIdentifier:@"returnToRound" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"returnToRound"]) {
        RoundViewController *destination = [segue destinationViewController];
        destination.gamePlayBasket = self.basket;
        destination.wordsRemaining.text = [NSString stringWithFormat:@"Words remaining: %lu",(unsigned long)[self.basket count]];
        
        if ([self.teamNumber isEqualToString:@"Blue Team"]) {
            if ([self.correctAnswers count] == 0) {
                destination.teamOneScore.text = @"00";
            } else {
                destination.teamOneScore.text = [NSString stringWithFormat:@"%lu", [self.correctAnswers count] + [destination.teamOneScore.text integerValue]];
            }
            destination.teamNumber.text = @"Orange Team";
        } else if ([self.teamNumber isEqualToString:@"Orange Team"]) {
            if ([self.correctAnswers count] == 0) {
                destination.teamTwoScore.text = @"00";
            } else {
                destination.teamTwoScore.text = [NSString stringWithFormat:@"%lu", [self.correctAnswers count] + [destination.teamTwoScore.text integerValue]];
            }
            destination.teamNumber.text = @"Blue Team";
        }
        
        if (self.roundOver == YES) {
            destination.roundOver = self.roundOver;
        }
    }
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
