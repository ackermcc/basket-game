//
//  RoundViewController.m
//  AckermanMenkhaus-BasketGame
//
//  Created by Chad Ackerman on 4/3/14.
//  Copyright (c) 2014 UC. All rights reserved.
//

#import "RoundViewController.h"

@interface RoundViewController ()
@property (nonatomic) NSMutableArray *replaceArray;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];
    
    self.replaceArray = [[NSMutableArray alloc] initWithObjects:@"phone", @"kate", @"fire", @"chad", @"table", @"couch", @"tv", @"computer", @"twelve", @"eleven", @"kate is dumb", @"who brought her here", nil];
    self.wordsRemaining.text = [NSString stringWithFormat:@"Words remaining: %d", self.replaceArray.count];
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
