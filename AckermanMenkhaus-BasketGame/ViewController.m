//
//  ViewController.m
//  AckermanMenkhaus-BasketGame
//
//  Created by Chad Ackerman on 4/2/14.
//  Copyright (c) 2014 UC. All rights reserved.
//

#import "ViewController.h"
#import "BasketSetupViewController.h"
#import "UIColor+BasketColors.h"

@interface ViewController ()
@property (nonatomic) NSInteger playerCount;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.btnFourPlayer.backgroundColor = [UIColor teal];
    self.btnSixPlayer.backgroundColor = [UIColor red];
    self.btnShare.backgroundColor = [UIColor purple];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)fourPlayers:(id)sender {
    self.playerCount = 4;
    [self performSegueWithIdentifier:@"beginGame" sender:self];
}

-(IBAction)sixPlayers:(id)sender {
    self.playerCount = 6;
    [self performSegueWithIdentifier:@"beginGame" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"beginGame"]){
        BasketSetupViewController *destination = [segue destinationViewController];
        destination.playerCount = self.playerCount;
    }
}

@end
