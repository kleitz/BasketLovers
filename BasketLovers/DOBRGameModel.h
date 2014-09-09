//
//  DOBRGameModel.h
//  BasketLovers
//
//  Created by David Oliver Barreto Rodríguez on 26/08/14.
//  Copyright (c) 2014 David Oliver Barreto Rodríguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "constants.h"



@interface DOBRGameModel : NSObject

//Entity = kHomeTeam; kVisitorTeam; kMyPlayer
-(void)addPoints:(int)points forEntity:(int)entity;
-(void)removePoints:(int)points forEntity:(int)entity;

-(void)addFouls:(int)fouls forEntity:(int)entity;
-(void)removeFouls:(int)fouls forEntity:(int)entity;

-(void)resetTeamFouls;

// Action = kIncrease; kDecrease
-(void)changePeriod:(NSString *)action;

// Returns current game status
-(NSDictionary *)gameStatus;

-(void)resetGame;

@end
