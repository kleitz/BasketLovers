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
    

    // IMAGES !!! gets and returns NSString with URL of the file in User's Document Folder
    if ([defaults objectForKey:@"BL_UserConfig_myplayerImageView"]) {
        [userDefaultsConfigDictionary setObject:[defaults objectForKey:@"BL_UserConfig_myplayerImageView"]
                                         forKey:@"BL_UserConfig_myplayerImageView"];
    } else {
        [userDefaultsConfigDictionary setObject:[self documentsPathForFileName:@"myplayer_defaultimage.png"]
                                         forKey:@"BL_UserConfig_myplayerImageView"];
    }
    
    if ([defaults objectForKey:@"BL_UserConfig_myteamImageView"]) {
        [userDefaultsConfigDictionary setObject:[defaults objectForKey:@"BL_UserConfig_myteamImageView"]
                                         forKey:@"BL_UserConfig_myteamImageView"];
    } else {
        [userDefaultsConfigDictionary setObject:[self documentsPathForFileName:@"myteam_defaultimage.png"]
                                         forKey:@"BL_UserConfig_myteamImageView"];
    }
    

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

    
    // IMAGES !!! gets and returns NSString with URL of the file in User's Document Folder
    [defaults setObject:[configInfo objectForKey:@"BL_UserConfig_myplayerImageView"]
                 forKey:@"BL_UserConfig_myplayerImageView"];
    
    [defaults setObject:[configInfo objectForKey:@"BL_UserConfig_myteamImageView"]
                 forKey:@"BL_UserConfig_myteamImageView"];
    

    // Sync User Defaults
    [defaults synchronize];
 
    NSLog(@"SHAREDSTORE SAVED Dictionary %@", configInfo);
    NSLog(@"Configuration Saved to User Defaults");
 
 }


#pragma mark - Helper Methods

- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}




@end
