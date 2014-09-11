//
//  DOBRMainTabbarViewController.m
//  BasketLovers
//
//  Created by David Oliver Barreto Rodríguez on 11/09/14.
//  Copyright (c) 2014 David Oliver Barreto Rodríguez. All rights reserved.
//

#import "DOBRMainTabbarViewController.h"

@interface DOBRMainTabbarViewController ()

@end

@implementation DOBRMainTabbarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    BOOL ranBefore = [[NSUserDefaults standardUserDefaults] boolForKey:@"kDOBRBasketLoversApp_IsNotFirstRun"];
    
    if (!ranBefore) {
        [self performSegueWithIdentifier:@"appOnBoardingTutorialSegue" sender:self];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kDOBRBasketLoversApp_IsNotFirstRun"];
        [[NSUserDefaults standardUserDefaults] synchronize];
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
