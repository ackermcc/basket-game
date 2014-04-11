//
//  RoundViewController.m
//  AckermanMenkhaus-BasketGame
//
//  Created by Chad Ackerman on 4/3/14.
//  Copyright (c) 2014 UC. All rights reserved.
//

#import "RoundViewController.h"
#import "GamePlayViewController.h"
@interface RoundViewController ()
@property (nonatomic) NSUInteger roundNumber;
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
    if (self.roundOver == YES) {
        self.gamePlayBasket = [self.basket mutableCopy];
        
        if (self.roundNumber == 1) {
            self.roundNumber ++;
            self.navigationItem.title = [NSString stringWithFormat:@"Round %d", self.roundNumber];
        }
        
        self.wordsRemaining.text = [NSString stringWithFormat:@"Words remaining: %d", self.gamePlayBasket.count];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];
    
    self.gamePlayBasket = [self.basket mutableCopy];
    self.roundNumber = 1;
    self.navigationItem.title = [NSString stringWithFormat:@"Round %d", self.roundNumber];
    
#warning Remove before deployment
    self.replaceArray = [[NSMutableArray alloc] initWithObjects:@"phone", @"kate", @"fire", @"chad", @"table", @"couch", @"tv", @"computer", @"twelve", @"eleven", @"kate is dumb", @"who brought her here", nil];
    
    self.wordsRemaining.text = [NSString stringWithFormat:@"Words remaining: %d", self.gamePlayBasket.count];
}

- (IBAction)unwindToRound:(UIStoryboardSegue *)unwindSegue {}

-(IBAction)startGame:(id)sender {
    [self performSegueWithIdentifier:@"startGame" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    GamePlayViewController *destination = [segue destinationViewController];
    destination.basket = self.gamePlayBasket;
    destination.teamNumber = self.teamNumber.text;
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
