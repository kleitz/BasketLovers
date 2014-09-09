//
//  DOBRGameModel.m
//  BasketLovers
//
//  Created by David Oliver Barreto Rodríguez on 26/08/14.
//  Copyright (c) 2014 David Oliver Barreto Rodríguez. All rights reserved.
//

#import "DOBRGameModel.h"
#import "constants.h"


@interface DOBRGameModel()

// GameModel
@property(strong, nonatomic) NSDictionary *gameModel;

//Teams
@property(nonatomic) NSString *homeTeamName;
@property(nonatomic) NSString *visitorTeamName;

// Score and Fouls
@property(nonatomic) NSInteger homeTeamScore;
@property(nonatomic) NSInteger homeTeamFouls;
@property(nonatomic) NSInteger homeTeamTotalFouls;

@property(nonatomic) NSInteger visitorTeamScore;
@property(nonatomic) NSInteger visitorTeamFouls;
@property(nonatomic) NSInteger visitorTeamTotalFouls;

//My player
@property(nonatomic) NSString *myplayerName;
@property(nonatomic) NSInteger myplayerScore;
@property(nonatomic) NSInteger myplayerFouls;

//Game Properties
@property(strong, nonatomic) NSString *gameState;
@property(nonatomic) NSInteger period;
@property(nonatomic) NSInteger timeInSeconds;
@property(nonatomic) NSString *timeInTextString;
@property (strong, nonatomic) NSDate *date;

@end


@implementation DOBRGameModel

#pragma mark - Custom initialization

-(NSDictionary *)gameModel {
    
    if (!_gameModel) {
        [self resetGameModel];
    }

    [self updateGameModel];

    return _gameModel;
}


#pragma mark - Helper Methods

-(void)resetGameModel {
    _period = 1;
    _timeInSeconds = 0;
    _timeInTextString = @"00:00";
    
    _homeTeamName = @"Home Team";
    _homeTeamFouls = 0;
    _homeTeamScore = 0;
    _homeTeamTotalFouls = 0;
    
    _visitorTeamName = @"Visitor Team";
    _visitorTeamFouls = 0;
    _visitorTeamScore = 0;
    _visitorTeamTotalFouls = 0;
    
    _myplayerName = @"My Player";
    _myplayerScore = 0;
    _myplayerFouls = 0;
    
    [self updateGameModel];
}


-(void)updateGameModel {
    _gameModel = @{@"kGamePeriod":[NSNumber numberWithInteger:_period],
                   @"kGameDate":@"",
                   @"kGameTimeInSeconds":[NSNumber numberWithInteger:_timeInSeconds],
                   @"kGameTimeInString":_timeInTextString,
                  
                   @"kGameHomeTeamName":_homeTeamName,
                   @"kGameHomeTeamScore":[NSNumber numberWithInteger:_homeTeamScore],
                   @"kGameHomeTeamFouls":[NSNumber numberWithInteger:_homeTeamFouls],
                   @"kGameHomeTeamTotalFouls":[NSNumber numberWithInteger:_homeTeamTotalFouls],
                   
                   @"kGameVisitorTeamName":_visitorTeamName,
                   @"kGameVisitorTeamScore":[NSNumber numberWithInteger:_visitorTeamScore],
                   @"kGameVisitorTeamFouls":[NSNumber numberWithInteger:_visitorTeamFouls],
                   @"kGameVisitorTeamTotalFouls":[NSNumber numberWithInteger:_visitorTeamTotalFouls],

                   @"kGameMyplayerName":_myplayerName,
                   @"kGameMyplayerScore":[NSNumber numberWithInteger:_myplayerScore],
                   @"kGameMyplayerFouls":[NSNumber numberWithInteger:_myplayerFouls]};
}



#pragma mark - Publi API MEthods

-(void)resetTeamFouls {
    
    self.homeTeamFouls =0;
    self.visitorTeamFouls = 0;
    [self updateGameModel];
}

-(void)resetGame {
    [self resetGameModel];
}


-(NSDictionary *)gameStatus{

    return self.gameModel;

}


//Entity = kHomeTeam; kVisitorTeam; kMyPlayer
-(void)addPoints:(int)points forEntity:(int)entity {
    
    switch (entity) {
        case kGameEntityHomeTeam:
            _homeTeamScore += points;
            break;

        case kGameEntityVisitorTeam:
            _visitorTeamScore += points;
            break;
            
        case kGameEntityMyplayer:
            _myplayerScore += points;
            [self addPoints:points forEntity:kGameSettingsMyPlayerTeam];
            break;
            
        default:
            break;
    }

}

-(void)removePoints:(int)points forEntity:(int)entity {
    switch (entity) {
        case kGameEntityHomeTeam:
            if (self.homeTeamScore != 0) {
                _homeTeamScore -= points;
            }
            break;
        
        case kGameEntityVisitorTeam:
            if (self.visitorTeamScore != 0) {
                _visitorTeamScore -= points;
            }
            break;

        case kGameEntityMyplayer:
            if (self.myplayerScore != 0) {
                _myplayerScore -= points;
                [self removePoints:points forEntity:kGameSettingsMyPlayerTeam];
            }
            break;
        default:
            break;
    }

}


-(void)addFouls:(int)fouls forEntity:(int)entity {
    switch (entity) {
        case kGameEntityHomeTeam:
            _homeTeamFouls += fouls;
            _homeTeamTotalFouls += fouls;
            break;
        
        case kGameEntityVisitorTeam:
            _visitorTeamFouls += fouls;
            _visitorTeamTotalFouls += fouls;
            break;
        
        case kGameEntityMyplayer:
            if (self.myplayerFouls < kGameLogicMaxNumberOfPersonalFouls ) {
                self.myplayerFouls += fouls;
                [self addFouls:fouls forEntity:kGameSettingsMyPlayerTeam];
            }
            break;

        default:
            break;
    }
}


-(void)removeFouls:(int)fouls forEntity:(int)entity {
    switch (entity) {
        case kGameEntityHomeTeam:
            if (self.homeTeamFouls != 0) {
                _homeTeamFouls -= fouls;
                _homeTeamTotalFouls -= fouls;
            }
            break;
        case kGameEntityVisitorTeam:
            if (self.visitorTeamFouls != 0) {
                _visitorTeamFouls -= fouls;
                _visitorTeamTotalFouls -= fouls;
            }
            break;
        case kGameEntityMyplayer:
            if (self.myplayerFouls != 0) {
                _myplayerFouls -= fouls;
                [self removeFouls:fouls forEntity:kGameSettingsMyPlayerTeam];
            }
            break;
        default:
            break;
    }

}


// Action = kIncrease; kDecrease
-(void)changePeriod:(NSString *)action {
    if ([action isEqualToString:@"kIncrease"]) {
        if (self.period != kGameLogicMaxNumberOfPeriods ) {
            self.period += 1;
        }
    } else if ([action isEqualToString:@"kDecrease"]) {
        if (self.period != 1 ) {
            self.period -= 1;
        }
    } else if ([action isEqualToString:@"KOverTime"]) {
        if (self.period != 1 ) {
            self.period += 1;
        }
    }
    [self updateGameModel];
}






@end
