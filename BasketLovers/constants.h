//
//  constants.h
//  BasketLovers
//
//  Created by David Oliver Barreto Rodríguez on 06/09/14.
//  Copyright (c) 2014 David Oliver Barreto Rodríguez. All rights reserved.
//

#ifndef BasketLovers_constants_h
#define BasketLovers_constants_h

// Config GAME
#define kGameLogicMaxNumberOfPeriods 4
#define kGameLogicPeriodTime 10
#define kGameLogicMaxNumberOfBonusFouls 5
#define kGameLogicMaxNumberOfPersonalFouls 5

//Last minute
#define kGameLocigSecondsToFlashTimer ((kGameLogicPeriodTime*60)-60)



/* Game In Memory */
typedef enum {
    
    kGameDate = 0,
    kGameTime,
    kGamePeriod,
    kGameHomeTeamName,
    kGameVisitorTeamName,
    kGameHomeTeamScore,
    kGameHomeTeamTotalFouls,
    kGameVisitorTeamScore,
    kGameVisitorTeamTotalFouls,
    kGameMyplayerName,
    kGameMyplayerScore,
    kGameMyplayerFouls,
    
} Game;


/* Game Entities */
typedef enum {
    
    kGameEntityHomeTeam = 0,
    kGameEntityVisitorTeam,
    kGameEntityMyplayer,
    
} GameEntities;



/* Game SEttings Options  */
typedef enum {
    
    kGameSettingsMyPlayerTeam = 0,
    kGameSettingsMyPlayerName,
    
} GameSettings;


/* Game State   */
typedef enum {
    
    kGameStateInitiated = 0,
    kGameStatePlaying,
    kGameStatePaused,
    kGameStateResumed,
    kGameStateFinalized,
    
} GameState;


/* GameScoreButtonType Tag list */
typedef enum {
    
    kGameActionTimeButton = 0,
    kGameActionPeriodButton,
    kGameActionHomeTeamScoreButton,
    kGameActionVisitorTeamScoreButton,
    kGameActionHomeTeamFoulsButton,
    kGameActionVisitorTeamFoulsButton,
    kGameActionMyPlayerPointsButton,
    kGameActionMyPlayerFoulsButton,
    
} GameScoreButtonType;


/* Config UI Tag list */
typedef enum {
    
    kUIStaticConfig_myteamNameText = 0,
    kUIStaticConfig_myteamTournamentText,
    kUIStaticConfig_myplayerNameText,
    kUIStaticConfig_myplayerIsHomeSegmentedControl,
    kUIStaticConfig_myplayerScoreIsActivatedSwitch,
    kUIStaticConfig_gameNumberOfPeriodsSegmentedControl,
    kUIStaticConfig_gamePeriodTimeSegmentedControl,
    kUIStaticConfig_gameFoulsToBonusSegmentedControl,
    kUIStaticConfig_myplayerImageView,
    kUIStaticConfig_myteamImageView,
    
} GameUITags;


/* Config UIImagePickerSelection Tag list */
typedef enum {
    
    kUIImagePickerSelection_TakePhotoFromCamera = 0,
    kUIImagePickerSelection_PickPhotoFromLibrary,
    
} ImagePickerSelection;



#endif
