//
//  DOBRFirstViewController.m
//  BasketLovers
//
//  Created by David Oliver Barreto Rodríguez on 01/07/14.
//  Copyright (c) 2014 David Oliver Barreto Rodríguez. All rights reserved.
//

#import "DOBRFirstViewController.h"
#import "DOBRGameModel.h"
#import <QuartzCore/QuartzCore.h>
#import "constants.h"


@interface DOBRFirstViewController () <UIAlertViewDelegate, UIActionSheetDelegate, UIDocumentInteractionControllerDelegate>

//Outlets
@property (weak, nonatomic) IBOutlet UILabel *visitorTeamFoulsLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamFoulsLabel;

@property (weak, nonatomic) IBOutlet UILabel *periodsLabel;

@property (weak, nonatomic) IBOutlet UILabel *homeTeamScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *visitorTeamScoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *myplayerTeamScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *myplayerTeamFoulsLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIView *homeScoreView;
@property (weak, nonatomic) IBOutlet UIView *visitorScoreView;
@property (weak, nonatomic) IBOutlet UIView *myplayerScoreView;

@property (weak, nonatomic) IBOutlet UIView *homeTeamFoulsView;
@property (weak, nonatomic) IBOutlet UIView *visitorTeamFoulsView;
@property (weak, nonatomic) IBOutlet UIView *myplayerFlousView;

@property (weak, nonatomic) IBOutlet UIView *periodsView;
@property (weak, nonatomic) IBOutlet UIView *timeView;

@property (weak, nonatomic) IBOutlet UILabel *homeTeamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *visitorTeamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *myplayerNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *gameActionImageViewHomeTeam;
@property (weak, nonatomic) IBOutlet UIImageView *gameActionImageViewVisitorTeam;

@property (weak, nonatomic) IBOutlet UIImageView *homeTeamFoulsBonusFlag;
@property (weak, nonatomic) IBOutlet UIImageView *visitorTeamFoulsBonusFlag;


//Properties
@property (strong, nonatomic) DOBRGameModel *game;
@property (strong, nonatomic) NSDictionary *gameCurrentGameStatus;
@property (nonatomic) NSInteger gameState;

@property (strong, nonatomic) NSTimer *clockTimer;
@property (strong, nonatomic) NSDate *initialTime;
@property (strong, nonatomic) NSDate *finalTime;
@property (nonatomic) NSInteger elapsedMins;
@property (nonatomic) NSInteger elapsedSecs;
@property (nonatomic) NSInteger elapsedTimeDifference;

//@property (nonatomic) BOOL timerPaused;


//For WhatsApp sharing purposes
@property (strong, nonatomic) UIDocumentInteractionController * documentInteractionController;


@end



@implementation DOBRFirstViewController

#pragma mark - Custom Initializers

-(DOBRGameModel *)game {
    if (!_game) {
        _game = [[DOBRGameModel alloc] init];
        [_game resetGame];
    }
    
    return _game;
}



#pragma mark - custom view controller status bar

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


#pragma mark - View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // Setup gesture recognizers of IBOutlets
    [self setupGestureRecognizers];
    
    // Setup Fonts on UI labels
    [self setupFonts];
    
    // Create Game Model if it doesn't exits
    [self.game resetGame];
    
    // Get Initial Status
    self.gameCurrentGameStatus = [self.game gameStatus];

    // Initial UI
    [self updateUI];
    
    // Start game
    self.gameState = kGameStateInitiated;
    self.elapsedSecs = 0;
    self.elapsedMins = 0;
    NSLog(@"Game Initiated");

}

-(void)viewWillAppear:(BOOL)animated {

}


-(void)viewDidAppear:(BOOL)animated {

    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    //remove views and timers before we go

    [self.clockTimer invalidate];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gesture Recognizers

-(void)setupFonts {

    NSMutableSet *labelsArray = [[NSMutableSet alloc] init];
    
    [labelsArray addObject:self.homeTeamScoreLabel];
    [labelsArray addObject:self.visitorTeamScoreLabel];

   //Added Fonts:  KongtextRegular  &   LetsgoDigital-Regular
    UIFont *customFont = [UIFont fontWithName:@"LetsgoDigital-Regular" size:80];
    
    for(UILabel *label in labelsArray) {
        label.font = customFont;
    }
    
    [labelsArray removeAllObjects];
    [labelsArray addObject:self.timeLabel];
    
    customFont = [UIFont fontWithName:@"LetsgoDigital-Regular" size:60];
    
    for(UILabel *label in labelsArray) {
        label.font = customFont;
    }

    [labelsArray removeAllObjects];
    [labelsArray addObject:self.periodsLabel];
    [labelsArray addObject:self.homeTeamFoulsLabel];
    [labelsArray addObject:self.visitorTeamFoulsLabel];
    [labelsArray addObject:self.myplayerTeamScoreLabel];
    [labelsArray addObject:self.myplayerTeamFoulsLabel];
    
    //Added Fonts:  KongtextRegular  &   LetsgoDigital-Regular
    customFont = [UIFont fontWithName:@"LetsgoDigital-Regular" size:60];
    
    for(UILabel *label in labelsArray) {
        label.font = customFont;
    }
    
    
}

-(void)setupGestureRecognizers {

    NSMutableSet *buttonsArray = [[NSMutableSet alloc] init];

    [buttonsArray addObject:self.homeScoreView];
    [buttonsArray addObject:self.visitorScoreView];
    [buttonsArray addObject:self.myplayerScoreView];
    
    for(UIButton *button in buttonsArray)
    {
        // Triple Tap = 3 POINTS
        UITapGestureRecognizer *tripleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(tripleButtonTouched:)];
        tripleTapGesture.numberOfTapsRequired = 3;
        tripleTapGesture.numberOfTouchesRequired = 1;
        [button addGestureRecognizer:tripleTapGesture];
        
        
        // Double Tap = 2 POINTS
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(doubleButtonTouched:)];
        [doubleTapGesture requireGestureRecognizerToFail: tripleTapGesture];
        doubleTapGesture.numberOfTapsRequired = 2;
        doubleTapGesture.numberOfTouchesRequired = 1;
        [button addGestureRecognizer:doubleTapGesture];
        
        // Single Tap  = 1 POINT
        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(singleButtonTouched:)];
        
        [singleTapGesture requireGestureRecognizerToFail: doubleTapGesture];
        [singleTapGesture setDelaysTouchesBegan: NO];
        [singleTapGesture setNumberOfTapsRequired: 1];
        
        [button addGestureRecognizer:singleTapGesture];
        
        // SwipeDown Gesture  = -1
        UISwipeGestureRecognizer *swipeDownGesture;
        
        swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(minusButtonTouched:)];
        [swipeDownGesture setDirection:(UISwipeGestureRecognizerDirectionDown)];
        
        [button addGestureRecognizer:swipeDownGesture];
    }

    [buttonsArray removeAllObjects];
    
    [buttonsArray addObject:self.homeTeamFoulsView];
    [buttonsArray addObject:self.visitorTeamFoulsView];
    [buttonsArray addObject:self.myplayerFlousView];
    [buttonsArray addObject:self.periodsView];
    [buttonsArray addObject:self.timeView];
    
    for(UIButton *button in buttonsArray)
    {
        // Single Tap  = +1
        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(singleButtonTouched:)];
        
        [singleTapGesture setDelaysTouchesBegan: NO];
        [singleTapGesture setNumberOfTapsRequired: 1];
        
        [button addGestureRecognizer:singleTapGesture];
        
        // SwipeDown Gesture  = -1
        UISwipeGestureRecognizer *swipeDownGesture;
        
        swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(minusButtonTouched:)];
        [swipeDownGesture setDirection:(UISwipeGestureRecognizerDirectionDown)];
        
        [button addGestureRecognizer:swipeDownGesture];
    }
    
/*
     // set TapGesture to Scrollview: Hide/Show Navigation Bar Top Bar
     UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
     action:@selector(longPressAction:)];
     [self.periodsOutlet addGestureRecognizer:longPressGesture];
*/
    
}


-(void)tripleButtonTouched:(UITapGestureRecognizer *)sender {

    NSLog([NSString stringWithFormat:@"Triple Tap - Sender: %ld", (long)sender.view.tag]);
    
    BOOL isHomeTeam = NO;

    if (sender.view.tag == kGameActionHomeTeamScoreButton) {
        [self.game addPoints:3 forEntity:kGameEntityHomeTeam];
        isHomeTeam = YES;
        
    } else if (sender.view.tag == kGameActionVisitorTeamScoreButton) {
        [self.game addPoints:3 forEntity:kGameEntityVisitorTeam];
        isHomeTeam = NO;
        
    } else if (sender.view.tag == kGameActionMyPlayerPointsButton) {
        [self.game addPoints:3 forEntity:kGameEntityMyplayer];
        isHomeTeam = YES;
        
    }


    //Show animation according to scoring team
    if (isHomeTeam) {
        self.gameActionImageViewHomeTeam.image = [UIImage imageNamed:@"3PointsSelected"];
        [self hidegameActionImageView:kGameEntityHomeTeam];
        
    } else {
        self.gameActionImageViewVisitorTeam.image = [UIImage imageNamed:@"3PointsSelected"];
        [self hidegameActionImageView:kGameEntityVisitorTeam];
    }
    
    self.gameCurrentGameStatus = [_game gameStatus];
    [self updateUI];

}

-(void)doubleButtonTouched:(UITapGestureRecognizer *)sender {
    
    NSLog([NSString stringWithFormat:@"Double Tap - Sender: %ld", (long)sender.view.tag]);
    
    BOOL isHomeTeam = NO;

    if (sender.view.tag == kGameActionHomeTeamScoreButton) {
        [self.game addPoints:2 forEntity:kGameEntityHomeTeam];
        isHomeTeam = YES;
        
    } else if (sender.view.tag == kGameActionVisitorTeamScoreButton) {
        [self.game addPoints:2 forEntity:kGameEntityVisitorTeam];
        isHomeTeam = NO;
        
    } else if (sender.view.tag == kGameActionMyPlayerPointsButton) {
        [self.game addPoints:2 forEntity:kGameEntityMyplayer];
        isHomeTeam = YES;
        
    }
    

    //Show animation according to scoring team
    if (isHomeTeam) {
        self.gameActionImageViewHomeTeam.image = [UIImage imageNamed:@"2PointsSelected"];
        [self hidegameActionImageView:kGameEntityHomeTeam];
        
    } else {
        self.gameActionImageViewVisitorTeam.image = [UIImage imageNamed:@"2PointsSelected"];
        [self hidegameActionImageView:kGameEntityVisitorTeam];
    }
    
    self.gameCurrentGameStatus = [_game gameStatus];
    [self updateUI];

}

-(void)singleButtonTouched:(UITapGestureRecognizer *)sender {
    
    NSLog([NSString stringWithFormat:@"Single Tap - Sender: %ld", (long)sender.view.tag]);

    BOOL isHomeTeam = NO;

    if (sender.view.tag == kGameActionPeriodButton) {
        
        if ([self.gameCurrentGameStatus[@"kGamePeriod"] intValue] < kGameLogicMaxNumberOfPeriods ) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Advance to Next Period"
                                                                message:@"Are you really sure you want to advance to the next period. Fouls will be set back to zero."
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alertView show];
            
        } else {
            // TODO: EndGame  & OverTime Logic
            
            if ([self.gameCurrentGameStatus[@"kGameHomeTeamScore"] intValue] != [self.gameCurrentGameStatus[@"kGameVisitorTeamScore"] intValue]) {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"End game ???"
                                                                    message:@"Are you really sure you want to end the game and show final stats."
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                [alertView show];
                
            } else {
            
                // TODO Over-Time Logic
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Overtime"
                                                                    message:@"Game needs Overtime."
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                [alertView show];
            }
            
        }
        
        return;
        
    } else if (sender.view.tag == kGameActionHomeTeamScoreButton) {
        [self.game addPoints:1 forEntity:kGameEntityHomeTeam];
        isHomeTeam = YES;

    } else if (sender.view.tag == kGameActionVisitorTeamScoreButton) {
        [self.game addPoints:1 forEntity:kGameEntityVisitorTeam];
        isHomeTeam = NO;
        
    } else if (sender.view.tag == kGameActionMyPlayerPointsButton) {
        [self.game addPoints:1 forEntity:kGameEntityMyplayer];
        isHomeTeam = YES;
        
    } else if (sender.view.tag == kGameActionHomeTeamFoulsButton) {
        [self.game addFouls:1 forEntity:kGameEntityHomeTeam];
        isHomeTeam = YES;
        
    }  else if (sender.view.tag == kGameActionVisitorTeamFoulsButton) {
        [self.game addFouls:1 forEntity:kGameEntityVisitorTeam];
        isHomeTeam = NO;
        
    }  else if (sender.view.tag == kGameActionMyPlayerFoulsButton) {
        [self.game addFouls:1 forEntity:kGameEntityMyplayer];
        isHomeTeam = YES;
        
    } else if (sender.view.tag == kGameActionTimeButton) {
        [self clockTimerAction];
        return;
    } 

    
    //Show animation according to scoring team
    if (isHomeTeam) {
        self.gameActionImageViewHomeTeam.image = [UIImage imageNamed:@"1PointsSelected"];
        [self hidegameActionImageView:kGameEntityHomeTeam];
        
    } else {
        self.gameActionImageViewVisitorTeam.image = [UIImage imageNamed:@"1PointsSelected"];
        [self hidegameActionImageView:kGameEntityVisitorTeam];
    }

    
    // TODO don't execute these commands when alert is displayed... but execute on button pressed...
    self.gameCurrentGameStatus = [_game gameStatus];
    [self updateUI];

}

-(void)minusButtonTouched:(UISwipeGestureRecognizer *)sender {
    
    NSLog([NSString stringWithFormat:@"SwipeDown Gesture - Sender: %ld", (long)sender.view.tag]);
    
    if (sender.view.tag == kGameActionPeriodButton) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Return to Previous Period"
                                                            message:@"Are you really sure you want to return to previous period. Fouls will be set back to zero."
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alertView show];

        
    } else if (sender.view.tag == kGameActionHomeTeamScoreButton) {
        [self.game removePoints:1 forEntity:kGameEntityHomeTeam];
        
    } else if (sender.view.tag == kGameActionVisitorTeamScoreButton) {
        [self.game removePoints:1 forEntity:kGameEntityVisitorTeam];
        
    } else if (sender.view.tag == kGameActionMyPlayerPointsButton) {
        [self.game removePoints:1 forEntity:kGameEntityMyplayer];
        
    } else if (sender.view.tag == kGameActionHomeTeamFoulsButton) {
        [self.game removeFouls:1 forEntity:kGameEntityHomeTeam];
        
    }  else if (sender.view.tag == kGameActionVisitorTeamFoulsButton) {
        [self.game removeFouls:1 forEntity:kGameEntityVisitorTeam];
        
    }  else if (sender.view.tag == kGameActionMyPlayerFoulsButton) {
        [self.game removeFouls:1 forEntity:kGameEntityMyplayer];
        
    }  else if (sender.view.tag == kGameActionTimeButton) {
        // RESET Clock [self clockTimerAction];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Reset Time"
                                                            message:@"Do your really want to reset time to zero?"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alertView show];
        
        
        
        return;
    }

//    self.gameActionImageView.image = [UIImage imageNamed:@"minus1PointsSelected"];
//    [self hidegameActionImageView];
    
    self.gameCurrentGameStatus = [_game gameStatus];
    [self updateUI];
}


#pragma mark - IBAction Methods
- (IBAction)actionButton:(UIBarButtonItem *)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Game Score Actions"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Start New Game",
                                                                      @"Share Game Score",
                                                                      @"WhatsApp",
                                                                      @"Save to Photo Album", nil];
    
    [actionSheet showInView:self.view];
}


- (IBAction)backButton:(UIBarButtonItem *)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Exit Game"
                                                        message:@"Do your really want to exit the game? Current score data will be lost."
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alertView show];
}



#pragma mark - Helper Methods

-(void)updateUI {
  
    // Update UI
    self.periodsLabel.text = [NSString stringWithFormat:@"%d", [self.gameCurrentGameStatus[@"kGamePeriod"] intValue]];
    //self.timeLabel.text = self.gameCurrentGameStatus[@"kGameTimeInString"];

    self.homeTeamNameLabel.text = self.gameCurrentGameStatus[@"kGameHomeTeamName"];
    self.homeTeamScoreLabel.text = [NSString stringWithFormat:@"%d", [self.gameCurrentGameStatus[@"kGameHomeTeamScore"] intValue]];
    
    self.visitorTeamNameLabel.text = self.gameCurrentGameStatus[@"kGameVisitorTeamName"];
    self.visitorTeamScoreLabel.text = [NSString stringWithFormat:@"%d", [self.gameCurrentGameStatus[@"kGameVisitorTeamScore"] intValue]];
    
    self.myplayerNameLabel.text = self.gameCurrentGameStatus[@"kGameMyplayerName"];
    self.myplayerTeamScoreLabel.text = [NSString stringWithFormat:@"%d", [self.gameCurrentGameStatus[@"kGameMyplayerScore"] intValue]];
    self.myplayerTeamFoulsLabel.text = [NSString stringWithFormat:@"%d", [self.gameCurrentGameStatus[@"kGameMyplayerFouls"] intValue]];

    // When game ends, displays each team total fouls 
    if (self.gameState != kGameStateFinalized) {
        self.homeTeamFoulsLabel.text = [NSString stringWithFormat:@"%d", [self.gameCurrentGameStatus[@"kGameHomeTeamFouls"] intValue]];
        self.visitorTeamFoulsLabel.text = [NSString stringWithFormat:@"%d", [self.gameCurrentGameStatus[@"kGameVisitorTeamFouls"] intValue]];
        
    } else {
        self.homeTeamFoulsLabel.text = [NSString stringWithFormat:@"%d", [self.gameCurrentGameStatus[@"kGameHomeTeamTotalFouls"] intValue]];
        self.visitorTeamFoulsLabel.text = [NSString stringWithFormat:@"%d", [self.gameCurrentGameStatus[@"kGameVisitorTeamTotalFouls"] intValue]];
    }

    /*
     @"kGameDate":@"",
     @"kGameTimeInSeconds":[NSNumber numberWithInteger:_timeInSeconds],
     @"kGameTimeInString":_timeInTextString,
    */

    
    //Fouls Bonus
    if ([self.gameCurrentGameStatus[@"kGameHomeTeamFouls"] intValue] >= kGameLogicMaxNumberOfBonusFouls) {
        self.homeTeamFoulsLabel.textColor = [UIColor redColor];
        self.homeTeamFoulsBonusFlag.hidden = NO;
        
    } else {
        self.homeTeamFoulsLabel.textColor = [UIColor colorWithRed:1.000 green:0.502 blue:0.000 alpha:1.000];
        self.homeTeamFoulsBonusFlag.hidden = YES;
    }

    if ([self.gameCurrentGameStatus[@"kGameVisitorTeamFouls"] intValue] >= kGameLogicMaxNumberOfBonusFouls) {
        self.visitorTeamFoulsLabel.textColor = [UIColor redColor];
        self.visitorTeamFoulsBonusFlag.hidden = NO;
    
    } else {
        self.visitorTeamFoulsLabel.textColor = [UIColor colorWithRed:1.000 green:0.502 blue:0.000 alpha:1.000];
        self.visitorTeamFoulsBonusFlag.hidden = YES;
    }
    
    
    // My Player Fouls
    if ([self.gameCurrentGameStatus[@"kGameMyplayerFouls"] intValue] == (kGameLogicMaxNumberOfPersonalFouls - 1)) {
        self.myplayerScoreView.hidden = NO;
    }
    if ([self.gameCurrentGameStatus[@"kGameMyplayerFouls"] intValue] == (kGameLogicMaxNumberOfPersonalFouls - 1)) {
        self.myplayerTeamFoulsLabel.textColor = [UIColor orangeColor];
        
    } else if ([self.gameCurrentGameStatus[@"kGameMyplayerFouls"] intValue] == kGameLogicMaxNumberOfPersonalFouls) {
        self.myplayerTeamFoulsLabel.textColor = [UIColor redColor];
        self.myplayerScoreView.hidden = YES;
    }
    
}

-(void)hidegameActionImageView:(int)entity {
    
    if (entity == kGameEntityHomeTeam) {
        self.gameActionImageViewHomeTeam.hidden = NO;
        self.gameActionImageViewHomeTeam.alpha = 1.0f;
        
        // Then fades it away after 2 seconds (the cross-fade animation will take 0.5s)
        [UIView animateWithDuration:1.0 delay:0.0 options:nil animations:^{
            // Animate the alpha value of your imageView from 1.0 to 0.0 here
            self.gameActionImageViewHomeTeam.alpha = 0.0f;
        } completion:^(BOOL finished) {
            // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
            self.gameActionImageViewHomeTeam.hidden = YES;
        }];
    } else {
        self.gameActionImageViewVisitorTeam.hidden = NO;
        self.gameActionImageViewVisitorTeam.alpha = 1.0f;
        
        // Then fades it away after 2 seconds (the cross-fade animation will take 0.5s)
        [UIView animateWithDuration:1.0 delay:0.0 options:nil animations:^{
            // Animate the alpha value of your imageView from 1.0 to 0.0 here
            self.gameActionImageViewVisitorTeam.alpha = 0.0f;
        } completion:^(BOOL finished) {
            // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
            self.gameActionImageViewVisitorTeam.hidden = YES;
        }];
    }
}


-(UIImage *)takeScreenshotWithView:(UIView *)view {
/*

 Well, there are few ways of capturing the iPhone screen programmatically. Out of these 5 methods, I found the first option very convenient for copy-pasting and for applying level of compression as 1st method gives the image with true pixel data.
 
 
 Using UIKIT http://developer.apple.com/library/ios/#qa/qa1703/_index.html
 
 Using AVFoundation framework http://developer.apple.com/library/ios/#qa/qa1702/_index.html
 
 Using OpenGL ES http://developer.apple.com/library/ios/#qa/qa1704/_index.html
 
 Using view:
 
 CGRect screenRect = [[UIScreen mainScreen] bounds];
 UIGraphicsBeginImageContext(screenRect.size);
 CGContextRef ctx = UIGraphicsGetCurrentContext();
 [[UIColor blackColor] set];
 CGContextFillRect(ctx, screenRect);
 [self.window.layer renderInContext:ctx];
 UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();

 Using Window:
 
 UIGraphicsBeginImageContext(self.view.frame.size);
 [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
 UIImage *viImage=UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 Out of these 5 methods, I found the first option very convenient for copy-pasting and for applying level of compression as 1st method gives the image with true pixel data.
 
*/

    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(self.view.bounds.size);
/*
    UIView *tempView;
    for (UIView *view in self.view.subviews) {
        if (view.tag == 100) {
            tempView = view;
            tempView.hidden = NO;
        }
    }
*/
    UIView *tempView = view;
    //UIImageView *tempImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BasketLoversUVP640x2200"]];

    UIImageView *tempImageView= [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 80)];
    tempImageView.image = [UIImage imageNamed:@"BasketLoversUVP640x2200"];
    tempImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [tempView addSubview:tempImageView];
    
    [tempView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //tempView.hidden = YES;
    
    //NSData * data = UIImagePNGRepresentation(image);
    //[data writeToFile:@"foo.png" atomically:YES];

    [tempImageView removeFromSuperview];
    return image;
}



-(void)shareAction:(UIImage *)image {
 
 NSString *textToShare = @"Basket Lovers wants to share the Game Score Status";
 NSURL *myWebsite = [NSURL URLWithString:@"http://www.oliverbarreto.com/"];
 
 NSArray *objectsToShare = @[textToShare, myWebsite, image];
 
 UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
 
 NSArray *excludeActivities = @[UIActivityTypeAirDrop,
 UIActivityTypePrint,
 UIActivityTypeAssignToContact,
 UIActivityTypeAddToReadingList];
 
 activityVC.excludedActivityTypes = excludeActivities;
 
 [self presentViewController:activityVC
 animated:YES
 completion:nil];
 
}
 

-(void)savePhotoToAlbums:(UIImage *)image;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    });
}


-(void)sendWhastApp {
    
    // Always Give Credit to Source:
    // http://www.whatsapp.com/faq/en/iphone/23559013
    // http://stackoverflow.com/questions/8354417/share-image-text-through-whatsapp-in-an-ios-app
    
    //NSURL *whatsappURL = [NSURL URLWithString:@"whatsapp://send?text=Share%20%20Something%20Beautiful%20!"];
    
    //    NSString * msg = @"Share Something Beautiful !";
    //    NSString * urlWhats = [NSString stringWithFormat:@"whatsapp://send?text=%@", msg];
    //    NSURL * whatsappURL = [NSURL URLWithString:[urlWhats stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //
    //    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
    //        [[UIApplication sharedApplication] openURL: whatsappURL];
    //    }
    
    if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:@"whatsapp://app"]]){
        
        UIImage *iconImage = [self takeScreenshotWithView:self.view];
        NSString *savePath  = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/whatsAppTmp.wai"];
        
        [UIImageJPEGRepresentation(iconImage, 1.0) writeToFile:savePath atomically:YES];
        
        _documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]];
        _documentInteractionController.UTI = @"net.whatsapp.image";
        _documentInteractionController.delegate = self;
        
        [_documentInteractionController presentOpenInMenuFromRect:CGRectMake(0, 0, 0, 0) inView:self.view animated: YES];
    }
}



    /*
    //Get current time & Set View's properties to act as a Clock.
    //It is Important to set seconds View's property the last one, because its the one who calls layer redraw methods
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *now = [NSDate date];
    NSInteger hours = [[cal components:NSHourCalendarUnit fromDate:now] hour];
    BOOL isAM = (hours < 12) ? YES : NO;
    NSInteger minutes = [[cal components:NSMinuteCalendarUnit fromDate:now] minute];
    NSInteger seconds = [[cal components:NSSecondCalendarUnit fromDate:now] second];
    NSInteger stepSeconds = 0;
    NSInteger day = [[cal components:NSDayCalendarUnit fromDate:now] day];
*/
    //how to get NSDate's Components
    //    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //    [df setDateFormat:@"dd"];
    //    NSString *myDayString = [NSString stringWithFormat:@"%@",
    //                   [df stringFromDate:cal]];
    //
    //    [df setDateFormat:@"MMM"];
    //
    //    NSString *myMonthString = [NSString stringWithFormat:@"%@",
    //                     [df stringFromDate:[NSDate date]]];
    //
    //    [df setDateFormat:@"yy"];
    //
    //    NSString *myYearString = [NSString stringWithFormat:@"%@",
    //                    [df stringFromDate:[NSDate date]]];
    //
    //    [df release];
    //If you wish to get month's number instead of abbreviation, use "MM". If you wish to get integers, use [myDayString intValue];


-(void)clockTimerAction {
    
    switch (self.gameState) {
            
        case kGameStateInitiated:
            // Start Game
            if (!self.clockTimer) {
                
                [self startTimer];
                
                //self.timerPaused = NO;
                self.gameState = kGameStatePlaying;
                
                NSLog(@"Game State: Playing");
            }
            break;
            
        case kGameStatePlaying:
            [self stopTimer];

            self.gameState = kGameStatePaused;

/*            UIImage *pausedImage = [UIImage imageNamed:@"paused_buton.png"];
            UIImageView *pausedImageView = [[UIImageView alloc] initWithImage:pausedImage];
            [self.timeView addSubview:pausedImageView];

            NSLog(@"Game State: Paused");
*/

            break;
            
        case kGameStatePaused:
            [self startTimer];
            
            self.gameState = kGameStatePlaying;
//            [[[self.timeView subviews] lastObject] removeFromSuperview];

            NSLog(@"Game State: Playing");
            
            break;
            
        default:
            break;
    }

}

-(void)startTimer {

    // Start with Now
    self.initialTime = [NSDate date];
    self.finalTime =  [NSDate date];
    
    self.clockTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                       target:self
                                                     selector:@selector(clockTic)
                                                     userInfo:nil
                                                      repeats:YES];
    self.timeLabel.textColor = [UIColor blackColor];
    NSLog(@"Timer: Started");
}

-(void)stopTimer {
    
    if ([self.clockTimer isValid]) {
        
        // Stops with Now
        self.finalTime = [NSDate date];
        
        // Save current difference as offset
        self.elapsedTimeDifference += [self.finalTime timeIntervalSinceDate:self.initialTime];
        
        // invalidate and nil out timer
        [self.clockTimer invalidate];
        self.clockTimer = nil;
        
        self.timeLabel.textColor = [UIColor grayColor];

        NSLog(@"Timer: Stopped");
    }
}

-(void)clockTic {
    
    // Update UI Time only
    [self updateUITime];

}

-(void)printTimeStatus {

    NSLog(@"-----------------------------------------");
    NSLog(@"Initial Time: %@", self.initialTime);
    NSLog(@"Final Time: %@", self.finalTime);
    NSLog(@"Elapsed Diff: %ld", (long)self.elapsedTimeDifference);
    NSLog(@"elapsedMins: %ld", (long)self.elapsedMins);
    NSLog(@"elapsedSecs: %ld", (long)self.elapsedSecs);
    NSLog(@"Game State: %ld", (long)self.gameState);
}


-(void)updateUITime {
    
    // Checks Difference from initialTime until Now
    self.finalTime = [NSDate date];

    
    NSInteger dateDifference = [self.finalTime timeIntervalSinceDate:self.initialTime];
    
    
    // mins
    self.elapsedMins = (self.elapsedTimeDifference + dateDifference) / 60;
    
    // secs
    self.elapsedSecs =  (self.elapsedTimeDifference + dateDifference) % 60;
    
    
    NSString *minsString = @"";
    NSString *secsString = @"";
    
    // Convert to strings
    if (self.elapsedMins < 10) {
        minsString = [NSString stringWithFormat:@"0%ld", (long)self.elapsedMins];
    } else {
        minsString = [NSString stringWithFormat:@"%ld", (long)self.elapsedMins];
    }

    if (self.elapsedSecs < 10) {
        secsString = [NSString stringWithFormat:@"0%ld", (long)self.elapsedSecs];
    } else {
        secsString = [NSString stringWithFormat:@"%ld", (long)self.elapsedSecs];
    }

    // Create final time string
    self.timeLabel.text = [NSString stringWithFormat:@"%@:%@", minsString, secsString];
    
    NSLog([NSString stringWithFormat:@"Minutoes: %d", (kGameLocigSecondsToFlashTimer / 60)]);
    NSLog([NSString stringWithFormat:@"Seconds: %d", (kGameLocigSecondsToFlashTimer % 60)]);
    
    if ((self.elapsedMins >= (kGameLocigSecondsToFlashTimer / 60)) && (self.elapsedSecs >= kGameLocigSecondsToFlashTimer % 60)) {
        // Show red Timer in Last Minute (TODO: Flash)
        self.timeLabel.textColor = self.timeLabel.textColor == [UIColor redColor] ? [UIColor colorWithRed:1.000 green:0.362 blue:0.323 alpha:1.000] : [UIColor redColor];
    }
}

-(void)resetTimer {

    // Reset Timer
    self.elapsedMins = 0;
    self.elapsedMins = 0;
    self.elapsedTimeDifference = 0;

    self.timeLabel.text = @"00:00";
    self.timeLabel.textColor = [UIColor blackColor];
}

-(void)disableAllButtons {
    
    NSMutableSet *buttonsArray = [[NSMutableSet alloc] init];

    [buttonsArray addObject:self.homeScoreView];
    [buttonsArray addObject:self.homeTeamFoulsView];

    [buttonsArray addObject:self.visitorScoreView];
    [buttonsArray addObject:self.visitorTeamFoulsView];
    
    [buttonsArray addObject:self.myplayerFlousView];
    [buttonsArray addObject:self.myplayerScoreView];
    
    [buttonsArray addObject:self.periodsView];
    [buttonsArray addObject:self.timeView];
    
    for(UIButton *button in buttonsArray)
    {
        button.enabled = NO;
    }
}


#pragma mark - UIActionSheet Delegate Protocol

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    NSLog(@"You have pressed the %@ button", [alertView buttonTitleAtIndex:buttonIndex]);
    
    if ([alertView.title isEqualToString:@"Advance to Next Period"]) {
        // 0 = cancel ; 1 = Ok
        if (buttonIndex == 1) {
            [self.game changePeriod:@"kIncrease"];

            // Reset Team Fouls for next period
            [self.game resetTeamFouls];
            
            // Reset Timer
            [self stopTimer];
            [self resetTimer];
            
            self.gameState = kGameStatePaused;
            
        }
        
    } else if ([alertView.title isEqualToString:@"Return to Previous Period"]) {
        // 0 = cancel ; 1 = Ok
        if (buttonIndex == 1) {
            [self.game changePeriod:@"kDecrease"];
            [self.game resetTeamFouls];
        }
        
    } else if ([alertView.title isEqualToString:@"Exit Game"]) {
        // 0 = cancel ; 1 = Ok
        if (buttonIndex == 1) {
            [self dismissViewControllerAnimated:YES completion:nil];
            return;
        }
        
    } else if ([alertView.title isEqualToString:@"Overtime"]) {
        // 0 = cancel ; 1 = Ok
        if (buttonIndex == 1) {
            
            [self stopTimer];
            
            [self.game changePeriod:@"KOverTime"];
            
            // Reset Team Fouls for next period
            [self.game resetTeamFouls];
            
            // Reset Timer
            [self stopTimer];
            [self resetTimer];
            
            self.gameState = kGameStatePaused;
            
            // End Game & Disable all buttons except NavBar Action Button
            //self.navigationItem.title = @"Overtime";
            
        }
    } else if ([alertView.title isEqualToString:@"Reset Time"]) {

        // 0 = cancel ; 1 = Ok
        if (buttonIndex == 1) {

            // Stop & Reset Timer
            [self stopTimer];
            [self resetTimer];
            
            self.gameState = kGameStatePaused;

        }
        
    }  else if ([alertView.title isEqualToString:@"End game ???"]) {
        // 0 = cancel ; 1 = Ok
        if (buttonIndex == 1) {

            [self stopTimer];
            self.gameState = kGameStateFinalized;

            // End Game & Disable all buttons except NavBar Action Button
            self.navigationItem.title = @"Game Ended";
            [self disableAllButtons];
            
            // Present ActionSheet
            [self actionButton:nil];
        }
        
    }
    
    self.gameCurrentGameStatus = [_game gameStatus];
    [self updateUI];

}

#pragma mark - UIActionSheet Delegate Protocol

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"You have pressed the %@ button", [actionSheet buttonTitleAtIndex:buttonIndex]);
    
    //@"Start New Game", @"Share Game Score", @"WhatsApp", @"Save to Photo Album", nil
    //@"Start New Game" = 0 ; @"Share Game Score" = 1 ; @"WhatsApp" = 2; @"Save to Photo Album" =3 ; @"Cancel" = 4
    
    // 0= save to photo album; 1 = cancel
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
        //[self.navigationController popToRootViewControllerAnimated:YES];
        return;
        
    } else if (buttonIndex == 1) {
        [self shareAction:[self takeScreenshotWithView:self.view]];
        
    }  else if (buttonIndex == 2) {
        //TODO: preview what's going to be sended instead of composing the uidocument
        [self sendWhastApp];
        
    }  else if (buttonIndex == 3) {
        [self savePhotoToAlbums:[self takeScreenshotWithView:self.view]];
        
    } else if (buttonIndex == 4) {
        return;
    }
}

/*
-(void)preloadUserDefaults {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // MY TEAM
    self.myteamNameText.text = [defaults objectForKey:@"BL_UserConfig_myteamName"];
    self.myteamTournamentText.text = [defaults objectForKey:@"BL_UserConfig_myteamTournament"];
    
    
    // MY PLAYER
    self.myplayerNameText.text = [defaults objectForKey:@"BL_UserConfig_myplayerName"];
    self.myplayerScoreIsActivatedSwitch.selected = [defaults boolForKey:@"BL_UserConfig_myplayerScoreIsActivated"];
    
    // GAME
    self.gameNumberOfPeriodsSegmentedControl.selectedSegmentIndex = [defaults integerForKey:@"BL_UserConfig_gameNumberOfPeriods"];
    self.gamePeriodTimeSegmentedControl.selectedSegmentIndex = [defaults integerForKey:@"BL_UserConfig_gamePeriodTime"];
    self.gameFoulsToBonusSegmentedControl.selectedSegmentIndex = [defaults integerForKey:@"BL_UserConfig_gameFoulsToBonus"];
    
    
    // Images
    // self.myplayerImageView.image = [UIImage imageNamed:@"player_small"];
    // self.myteamImageView.image = [UIImage imageNamed:@"team_hat_red_small"];
    
    self.myteamImageView.image = [self makeRoundedImage:[UIImage imageNamed:@"team_hat_red_small"]
                                                 radius:(self.myteamImageView.frame.size.width / 2)];
    
    
    self.myplayerImageView.image = [self makeRoundedImage:[UIImage imageNamed:@"player_small"]
                                                   radius:(self.myplayerImageView.frame.size.width / 2)];
    
    NSLog(@"Initial Config Data Loaded from User Defaults");
    
}

*/


/*

 NSDate and the timeIntervalSince* methods will return a NSTimeInterval which is a double with sub-millisecond accuracy. NSTimeInterval is in seconds, but it uses the double to give you greater precision.
 
 In order to calculate millisecond time accuracy, you can do:
 
 // Get a current time for where you want to start measuring from
 NSDate *date = [NSDate date];
 
 // do work...
 
 // Find elapsed time and convert to milliseconds
 // Use (-) modifier to conversion since receiver is earlier than now
 double timePassed_ms = [date timeIntervalSinceNow] * -1000.0;
 Documentation on timeIntervalSinceNow.
 
 There are many other ways to calculate this interval using NSDate, and I would recommend looking at the class documentation for NSDate which is found in NSDate Class Reference.
 
 https://developer.apple.com/library/mac/qa/qa1398/_index.html
 
 //This will get the time interval between the 2
 dates in seconds as a double/NSTimeInterval.
double seconds = [date1 timeIntervalSinceDate:date2];

// *This will drop the whole part and give you the
 fractional part which you can multiply by 1000 and
 cast to an integer to get a whole milliseconds
 representation.
double milliSecondsPartOfCurrentSecond = seconds - (int)seconds;

// *This will give you the number of milliseconds accumulated
 so far before the next elapsed second. /
int wholeMilliSeconds = (int)(milliSecondsPartOfCurrentSecond * 1000.0);


*/

@end
