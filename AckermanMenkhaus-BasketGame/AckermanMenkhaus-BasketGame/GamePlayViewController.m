//
//  GamePlayViewController.m
//  AckermanMenkhaus-BasketGame
//
//  Created by Chad Ackerman on 4/3/14.
//  Copyright (c) 2014 UC. All rights reserved.
//

#import "GamePlayViewController.h"

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
    if ([self.teamNumber isEqualToString:@"Team 1"]) {
        //Move correct word from basket to team array
        [self.teamOneCorrectAnswers addObject:[self.basket objectAtIndex:self.activeWordIndex]];
        [self.basket removeObjectAtIndex:self.activeWordIndex];
        
        //Choose next word
        self.activeWord.text = [self.basket objectAtIndex:self.activeWordIndex];
        
        NSLog(@"index: %d, next word: %@", self.activeWordIndex, self.basket);
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
    NSLog(@"time is up!!");
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
