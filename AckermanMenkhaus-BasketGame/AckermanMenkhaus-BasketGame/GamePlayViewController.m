//
//  GamePlayViewController.m
//  AckermanMenkhaus-BasketGame
//
//  Created by Chad Ackerman on 4/3/14.
//  Copyright (c) 2014 UC. All rights reserved.
//

#import "GamePlayViewController.h"
#import "RoundViewController.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.correctAnswers = [[NSMutableArray alloc] init];

    [self shuffle:self.basket];
    
    self.activeWordIndex = 0;
    
    self.activeWord.text = [self.basket objectAtIndex:self.activeWordIndex];
    
    self.gameClock = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}

- (void)shuffle:(NSMutableArray *)shuffleArray
{
    NSUInteger count = [shuffleArray count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = arc4random_uniform(nElements) + i;
        [shuffleArray exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    NSLog(@"new order: %@", shuffleArray);
}

- (IBAction)correctWord:(id)sender {
    //Move correct word from basket to team array
    [self.correctAnswers addObject:[self.basket objectAtIndex:0]];
    
    [self.basket removeObjectAtIndex:self.activeWordIndex];
    
    //Choose next word
    self.activeWord.text = [self.basket objectAtIndex:self.activeWordIndex];
    
    NSLog(@"next word: %@", self.correctAnswers);
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
    UIAlertView *scoreAlert = [[UIAlertView alloc] initWithTitle:@"Time is up!" message:[NSString stringWithFormat:@"You got %d correct!", [self.correctAnswers count]] delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    
    [scoreAlert show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self performSegueWithIdentifier:@"returnToRound" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"returnToRound"]) {
        RoundViewController *destination = [segue destinationViewController];
        destination.replaceArray = self.basket;
        destination.wordsRemaining.text = [NSString stringWithFormat:@"%d",[self.basket count]];
        if ([self.teamNumber isEqualToString:@"Team 1"]) {
            destination.teamOneScore.text = [NSString stringWithFormat:@"%d", [self.correctAnswers count]];
            destination.teamNumber.text = @"Team 2";
        } else if ([self.teamNumber isEqualToString:@"Team 2"]) {
            destination.teamTwoScore.text = [NSString stringWithFormat:@"%d", [self.correctAnswers count]];
            destination.teamNumber.text = @"Team 1";
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
