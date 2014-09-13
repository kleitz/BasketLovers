//
//  DOBRSharedStoreCoordinator.m
//  BasketLovers
//
//  Created by David Oliver Barreto Rodríguez on 09/09/14.
//  Copyright (c) 2014 David Oliver Barreto Rodríguez. All rights reserved.
//

#import "DOBRSharedStoreCoordinator.h"

@interface DOBRSharedStoreCoordinator()

// NSUserDefaults User Configuration
@property (strong, nonatomic) NSDictionary *userDefaultsConfigDictionary;

// TODO Game History

@end

@implementation DOBRSharedStoreCoordinator


+ (DOBRSharedStoreCoordinator *)sharedStoreCoordinator
{
    static DOBRSharedStoreCoordinator *_sharedStore = nil;
    
    /*
     if (!_sharedStore)
     _sharedStore = [[super allocWithZone:nil] init];
     
     return _sharedStore;
     */
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedStore = [[DOBRSharedStoreCoordinator alloc] init];
    });
    
    return _sharedStore;
}

- (id)init {
    if (self = [super init]) {
        
        // Initialize with Default Values
        self.userDefaultsConfigDictionary = [[NSDictionary alloc] init];
        
        
    }
    
    return self;
}


#pragma mark - public methods


-(void)saveUserDefaultsConfig:(NSDictionary *)configInfo {
    
    
}

-(NSDictionary *)loadUserDefaultsConfig {
    
    return _userDefaultsConfigDictionary;
}


/*
 
 #pragma mark - NSUserDefaults
 
 
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
 self.gamePlayerFoulsSegmentedControl.selectedSegmentIndex = [defaults integerForKey:@"BL_UserConfig_gamePlayerFouls"];
 
 
 // Images
 // self.myplayerImageView.image = [UIImage imageNamed:@"player_small"];
 // self.myteamImageView.image = [UIImage imageNamed:@"team_hat_red_small"];
 
 self.myteamImageView.image = [self makeRoundedImage:[UIImage imageNamed:@"team_hat_red_small"]
 radius:(self.myteamImageView.frame.size.width / 2)];
 
 
 self.myplayerImageView.image = [self makeRoundedImage:[UIImage imageNamed:@"player_small"]
 radius:(self.myplayerImageView.frame.size.width / 2)];
 
 NSLog(@"Initial Config Data Loaded from User Defaults");
 
 }
 
 -(void)saveConfig{
 
 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
 
 // MY TEAM
 [defaults setObject:self.myteamNameText.text
 forKey:@"BL_UserConfig_myteamName"];
 [defaults setObject:self.myteamTournamentText.text
 forKey:@"BL_UserConfig_myteamTournament"];
 
 // MY PLAYER
 [defaults setObject:self.myplayerNameText.text
 forKey:@"BL_UserConfig_myplayerName"];
 [defaults setBool:self.myplayerScoreIsActivatedSwitch.state
 forKey:@"BL_UserConfig_myplayerScoreIsActivated"];
 
 // GAME
 [defaults setInteger:self.gameNumberOfPeriodsSegmentedControl.selectedSegmentIndex
 forKey:@"BL_UserConfig_gameNumberOfPeriods"];
 [defaults setInteger:self.gamePeriodTimeSegmentedControl.selectedSegmentIndex
 forKey:@"BL_UserConfig_gamePeriodTime"];
 [defaults setInteger:self.gameFoulsToBonusSegmentedControl.selectedSegmentIndex
 forKey:@"BL_UserConfig_gameFoulsToBonus"];
 
 
 
 // NSData *imageData = UIImagePNGRepresentation(image);
 
 // UIImage *image=[UIImage imageWithData:data];
 
 
 // SAVE Image in NSUserDefaults NOT RECOMMENDED... instead go with file paths
 
 
 // MYPLAYER IMAGE
 // Get image data. Here you can use UIImagePNGRepresentation if you need transparency
 NSData *imageData = UIImagePNGRepresentation(self.myplayerImageView.image);
 
 // Get image path in user's folder and store file with name image_CurrentTimestamp.jpg (see documentsPathForFileName below)
 
 //TODO: save image on user folder on uiimagepicker saving
 NSString *imagePath = [self documentsPathForFileName:[NSString stringWithFormat:@"image_myplayerConfigImage_%f.png", [NSDate timeIntervalSinceReferenceDate]]];
 
 // Write image data to user's folder
 [imageData writeToFile:imagePath atomically:YES];
 
 // Store path in NSUserDefaults
 [defaults setObject:imagePath
 forKey:kPLDefaultsAvatarUrl];
 
 // Sync user defaults
 [[NSUserDefaults standardUserDefaults] synchronize];
 
 
 
 Read data:
 
 NSString *imagePath = [[NSUserDefaults standardUserDefaults] objectForKey:kPLDefaultsAvatarUrl];
 if (imagePath) {
 self.avatarImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
 }
 documentsPathForFileName
 
 - (NSString *)documentsPathForFileName:(NSString *)name {
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 NSString *documentsPath = [paths objectAtIndex:0];
 
 return [documentsPath stringByAppendingPathComponent:name];
 }
 
 
 // Sync
 [defaults synchronize];
 
 
 NSLog(@"Configuration Saved to User Defaults");
 
 }
 
 */

@end
