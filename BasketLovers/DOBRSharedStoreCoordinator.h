//
//  DOBRSharedStoreCoordinator.h
//  BasketLovers
//
//  Created by David Oliver Barreto Rodríguez on 09/09/14.
//  Copyright (c) 2014 David Oliver Barreto Rodríguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOBRSharedStoreCoordinator : NSObject

// Singleton
+(DOBRSharedStoreCoordinator *)sharedStoreCoordinator;

// NSUserDefaults User Configuration
-(void)saveUserDefaultsConfig:(NSDictionary *)configInfo;
-(NSDictionary *)loadUserDefaultsConfig;

// TODO Game History

@end
