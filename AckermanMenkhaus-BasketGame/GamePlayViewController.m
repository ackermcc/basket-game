//
//  GamePlayViewController.m
//  AckermanMenkhaus-BasketGame
//
//  Created by Chad Ackerman on 4/3/14.
//  Copyright (c) 2014 UC. All rights reserved.
//

#import "GamePlayViewController.h"
#import "RoundViewController.h"
#import "GameOverViewController.h"
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
    self.gameTimer.progressTintColor = [UIColor red];
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 22.5f);
    self.gameTimer.transform = transform;
    
    self.roundOver = NO;
    
    self.roundDescription.text = self.roundDirections;
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

- (IBAction)skip:(id)sender {
    
    [self moveObjectAtIndex:self.activeWordIndex toIndex:self.basket.count - 1];
    self.activeWord.text = [self.basket objectAtIndex:self.activeWordIndex];
    self.btnSkipWord.backgroundColor = [UIColor lightGrayColor];
    self.btnSkipWord.userInteractionEnabled = NO;
    
}

- (void)moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    id object = [self.basket objectAtIndex:fromIndex];
    [self.basket removeObjectAtIndex:fromIndex];
    [self.basket insertObject:object atIndex:toIndex];
}

- (IBAction)correctWord:(id)sender {
    if (self.basket.count > 1) {
        //Move correct word from basket to team array
        [self.correctAnswers addObject:[self.basket objectAtIndex:0]];
        
        [self.basket removeObjectAtIndex:self.activeWordIndex];
        
        //Choose next word
        self.activeWord.text = [self.basket objectAtIndex:self.activeWordIndex];
    } else if (self.basket.count == 1 && self.roundNumber == 3){
        //Move correct word from basket to team array
        [self.correctAnswers addObject:[self.basket objectAtIndex:0]];
        
        [self.basket removeObjectAtIndex:self.activeWordIndex];
        
        UIAlertView *emptyBasket = [[UIAlertView alloc] initWithTitle:@"Password round is over" message:[NSString stringWithFormat:@"You got %lu correct!", (unsigned long)[self.correctAnswers count]] delegate:self cancelButtonTitle:@"Game Over" otherButtonTitles:nil, nil];
        
        [emptyBasket show];
        
        [self performSegueWithIdentifier:@"gameOver" sender:self];
        [self.gameClock invalidate];
    } else {
        [self.correctAnswers addObject:[self.basket objectAtIndex:0]];
        [self.basket removeObjectAtIndex:self.activeWordIndex];
        
        if (self.roundNumber == 1) {
            UIAlertView *emptyBasket = [[UIAlertView alloc] initWithTitle:@"Catch Phrase round is over" message:[NSString stringWithFormat:@"You got %lu correct!", (unsigned long)[self.correctAnswers count]] delegate:self cancelButtonTitle:@"Next Round" otherButtonTitles:nil, nil];
            
            [emptyBasket show];
        } else if (self.roundNumber == 2) {
            UIAlertView *emptyBasket = [[UIAlertView alloc] initWithTitle:@"Charades round is over" message:[NSString stringWithFormat:@"You got %lu correct!", (unsigned long)[self.correctAnswers count]] delegate:self cancelButtonTitle:@"Next Round" otherButtonTitles:nil, nil];
            
            [emptyBasket show];
        }
        
        self.roundOver = YES;
        
        [self.gameClock invalidate];
    }
}

-(void) updateTimer {
    float newProgress = [self.gameTimer progress] + 0.004166667;
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
        
        if ([self.teamNumber isEqualToString:@"Green Envy"]) {
            if ([self.correctAnswers count] == 0) {
                destination.teamOneScore.text = @"00";
            } else {
                destination.teamOneScore.text = [NSString stringWithFormat:@"%lu", [self.correctAnswers count] + [self.teamOneScore.text integerValue]];
            }
            destination.teamNumber.text = @"Infra Red";
        } else if ([self.teamNumber isEqualToString:@"Infra Red"]) {
            if ([self.correctAnswers count] == 0) {
                destination.teamTwoScore.text = @"00";
            } else {
                destination.teamTwoScore.text = [NSString stringWithFormat:@"%lu", [self.correctAnswers count] + [self.teamTwoScore.text integerValue]];
            }
            destination.teamNumber.text = @"Green Envy";
        }
        
        if (self.roundOver == YES) {
            destination.roundOver = self.roundOver;
        }
    } else if ([segue.identifier isEqualToString:@"gameOver"]){
        GameOverViewController *destination = [segue destinationViewController];
        
        if ([self.teamNumber isEqualToString:@"Green Envy"]) {
            NSLog(@"i made it here with a score %lu", [self.correctAnswers count] + [self.teamOneScore.text integerValue]);
            destination.teamOneScore = [NSString stringWithFormat:@"%lu", [self.correctAnswers count] + [self.teamOneScore.text integerValue]];
            destination.teamTwoScore = self.teamTwoScore.text;
        } else {
            NSLog(@"i made it here with a score %lu", [self.correctAnswers count] + [self.teamTwoScore.text integerValue]);
            destination.teamTwoScore = [NSString stringWithFormat:@"%lu", [self.correctAnswers count] + [self.teamTwoScore.text integerValue]];
            destination.teamOneScore = self.teamOneScore.text;
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
