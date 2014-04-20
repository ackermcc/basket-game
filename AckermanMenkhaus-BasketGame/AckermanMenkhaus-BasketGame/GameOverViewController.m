//
//  GameOverViewController.m
//  AckermanMenkhaus-BasketGame
//
//  Created by Chad Ackerman on 4/18/14.
//  Copyright (c) 2014 UC. All rights reserved.
//

#import "GameOverViewController.h"
#import "UIColor+BasketColors.h"

@interface GameOverViewController ()

@end

@implementation GameOverViewController

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
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.teamOneFinalScore.text = self.teamOneScore;
    self.teamTwoFinalScore.text = self.teamTwoScore;
    
    self.teamOneFinalScore.backgroundColor = [UIColor teal];
    self.teamTwoFinalScore.backgroundColor = [UIColor red];
    
    [self.btnShare setBackgroundColor:[UIColor purple]];
    
    if ([self.teamOneScore integerValue] > [self.teamTwoScore integerValue]) {
        self.view.backgroundColor = [UIColor teal];
        [self.playAgain setTitleColor:[UIColor teal] forState:UIControlStateNormal];
        self.winningTeamName.text = @"Green Envy :)";
    } else {
        self.view.backgroundColor = [UIColor red];
        [self.playAgain setTitleColor:[UIColor red] forState:UIControlStateNormal];
        self.winningTeamName.text = @"Infra Red :)";
    }
}

-(IBAction)newGame:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
