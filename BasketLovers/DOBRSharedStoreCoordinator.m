//
//  DOBRSharedStoreCoordinator.m
//  BasketLovers
//
//  Created by David Oliver Barreto Rodríguez on 09/09/14.
//  Copyright (c) 2014 David Oliver Barreto Rodríguez. All rights reserved.
//

#import "DOBRSharedStoreCoordinator.h"
#import "constants.h"


@interface DOBRSharedStoreCoordinator()


// TODO Game History

@end

@implementation DOBRSharedStoreCoordinator


+ (DOBRSharedStoreCoordinator *)sharedStoreCoordinator
{
    static DOBRSharedStoreCoordinator *_sharedStoreCoordinator = nil;
    
    /*
     if (!_sharedStore)
     _sharedStore = [[super allocWithZone:nil] init];
     
     return _sharedStore;
     */
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedStoreCoordinator = [[DOBRSharedStoreCoordinator alloc] init];
    });
    
    return _sharedStoreCoordinator;
}

- (id)init {
    if (self = [super init]) {
        
        // Initialize with Default Values
        
        
    }
    
    return self;
}


#pragma mark - public methods

-(NSDictionary *)loadUserDefaultsConfig {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // NSUserDefaults User Configuration
    NSMutableDictionary *userDefaultsConfigDictionary = [[NSMutableDictionary alloc] init];
    
    // MY TEAM
    if ([defaults objectForKey:@"BL_UserConfig_myteamName"]) {
        [userDefaultsConfigDictionary setObject:[defaults objectForKey:@"BL_UserConfig_myteamName"]
                                         forKey:@"BL_UserConfig_myteamName"];
    } else {
        [userDefaultsConfigDictionary setObject:@""
                                         forKey:@"BL_UserConfig_myteamName"];
    }
    
    if ([defaults objectForKey:@"BL_UserConfig_myteamTournament"]) {
        [userDefaultsConfigDictionary setObject:[defaults objectForKey:@"BL_UserConfig_myteamTournament"]
                                         forKey:@"BL_UserConfig_myteamTournament"];
    } else {
        [userDefaultsConfigDictionary setObject:@""
                                         forKey:@"BL_UserConfig_myteamTournament"];
    }
    
    // MY PLAYER
    
    if ([defaults objectForKey:@"BL_UserConfig_myplayerName"]) {
        [userDefaultsConfigDictionary setObject:[defaults objectForKey:@"BL_UserConfig_myplayerName"]
                                         forKey:@"BL_UserConfig_myplayerName"];
    } else {
        [userDefaultsConfigDictionary setObject:@""
                                         forKey:@"BL_UserConfig_myplayerName"];
    }
    
    if ([defaults objectForKey:@"BL_UserConfig_myplayerScoreIsActivated"]) {
        [userDefaultsConfigDictionary setObject:[defaults objectForKey:@"BL_UserConfig_myplayerScoreIsActivated"]
                                         forKey:@"BL_UserConfig_myplayerScoreIsActivated"];
        
    } else {
        [userDefaultsConfigDictionary setObject:@YES
                                         forKey:@"BL_UserConfig_myplayerScoreIsActivated"];
        
    }
    
    
    // GAME
    if ([defaults objectForKey:@"BL_UserConfig_gameNumberOfPeriods"]) {
        [userDefaultsConfigDictionary setObject:[defaults objectForKey:@"BL_UserConfig_gameNumberOfPeriods"]
                                         forKey:@"BL_UserConfig_gameNumberOfPeriods"];
    } else {
        [userDefaultsConfigDictionary setObject:@kGameLogicMaxNumberOfPeriods
                                         forKey:@"BL_UserConfig_gameNumberOfPeriods"];
    }
    
    if ([defaults objectForKey:@"BL_UserConfig_gamePeriodTime"]) {
        [userDefaultsConfigDictionary setObject:[defaults objectForKey:@"BL_UserConfig_gamePeriodTime"]
                                         forKey:@"BL_UserConfig_gamePeriodTime"];
    } else {
        [userDefaultsConfigDictionary setObject:@kGameLogicPeriodTime
                                         forKey:@"BL_UserConfig_gamePeriodTime"];
    
    }
    
    if ([defaults objectForKey:@"BL_UserConfig_gameFoulsToBonus"]) {
        [userDefaultsConfigDictionary setObject:[defaults objectForKey:@"BL_UserConfig_gameFoulsToBonus"]
                                         forKey:@"BL_UserConfig_gameFoulsToBonus"];
    } else {
        [userDefaultsConfigDictionary setObject:@kGameLogicMaxNumberOfBonusFouls
                                         forKey:@"BL_UserConfig_gameFoulsToBonus"];
    }

    if ([defaults objectForKey:@"BL_UserConfig_gamePlayerFouls"]) {
        [userDefaultsConfigDictionary setObject:[defaults objectForKey:@"BL_UserConfig_gamePlayerFouls"]
                                         forKey:@"BL_UserConfig_gamePlayerFouls"];
    } else {
        [userDefaultsConfigDictionary setObject:@kGameLogicMaxNumberOfPersonalFouls
                                         forKey:@"BL_UserConfig_gamePlayerFouls"];
    }

    
    // TODO: IMAGES !!!
    
    NSLog(@"SHAREDSTORE LOADED Dictionary %@", userDefaultsConfigDictionary);
    return userDefaultsConfigDictionary;
}


-(void)userDefaultsConfig:(NSDictionary *)configInfo {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     
    // MY TEAM
    [defaults setObject:[configInfo objectForKey:@"BL_UserConfig_myteamName"]
                  forKey:@"BL_UserConfig_myteamName"];
    [defaults setObject:[configInfo objectForKey:@"BL_UserConfig_myteamTournament"]
                  forKey:@"BL_UserConfig_myteamTournament"];
     
    // MY PLAYER
    [defaults setObject:[configInfo objectForKey:@"BL_UserConfig_myplayerName"]
                  forKey:@"BL_UserConfig_myplayerName"];
    [defaults setObject:[configInfo objectForKey:@"BL_UserConfig_myplayerScoreIsActivated"]
                forKey:@"BL_UserConfig_myplayerScoreIsActivated"];
     
    // GAME
    [defaults setObject:[configInfo objectForKey:@"BL_UserConfig_gameNumberOfPeriods"]
               forKey:@"BL_UserConfig_gameNumberOfPeriods"];
    [defaults setObject:[configInfo objectForKey:@"BL_UserConfig_gamePeriodTime"]
               forKey:@"BL_UserConfig_gamePeriodTime"];
    [defaults setObject:[configInfo objectForKey:@"BL_UserConfig_gameFoulsToBonus"]
               forKey:@"BL_UserConfig_gameFoulsToBonus"];
    [defaults setObject:[configInfo objectForKey:@"BL_UserConfig_gamePlayerFouls"]
               forKey:@"BL_UserConfig_gamePlayerFouls"];

    
    // TODO: IMAGES !!!
    

    // Sync User Defaults
    [defaults synchronize];
 
    NSLog(@"SHAREDSTORE SAVED Dictionary %@", configInfo);
    NSLog(@"Configuration Saved to User Defaults");
 
 }
 
/*
 
 TODO: iMAGES !!!
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
 
 */



/*
 
 #pragma mark - NSUserDefaults
 
 -(NSDictionary *)loadUserDefaultsConfig {
 
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
 */

@end
