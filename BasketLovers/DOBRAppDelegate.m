//
//  DOBRAppDelegate.m
//  BasketLovers
//
//  Created by David Oliver Barreto Rodríguez on 01/07/14.
//  Copyright (c) 2014 David Oliver Barreto Rodríguez. All rights reserved.
//

#import "DOBRAppDelegate.h"

@implementation DOBRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [self setupCustomizedAppearanceOptions];
    [self moveInitialImagesFromBundleToDocuments];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Customization

-(void)setupCustomizedAppearanceOptions {
    
    // Title Bar Color
    //[[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    //Red UNELCO #DF1F2C ; RGB(223,31,44)
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xDF1F2C)];
    
    
    //TabBar tint Color
    // 1) this will generate a black tab bar
    [[UITabBar appearance] setBarTintColor:UIColorFromRGB(0xDF1F2C)];
    // this will give selected icons and text your apps tint color
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];

    
    // 2) Set the tabBarItem text appearance for each state that you want to override:
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:10.0f],
                    NSForegroundColorAttributeName:[UIColor whiteColor]}
                                             forState:UIControlStateSelected];
    
    
    // doing this results in an easier to read unselected state then the default iOS 7 one
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:10.0f],
                                                        NSForegroundColorAttributeName:[UIColor colorWithWhite:0.800 alpha:1.000]
                                                        } forState:UIControlStateNormal];
    
    
    
    
    
    

    // Title Font
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName, shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    
     /*
     // Custom color for back button
     [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
     
     // Cutom image for back button
     [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back_btn.png"]];
     [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back_btn.png"]];
     
     // Custom Image for Nav Title 
     self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appcoda-logo.png"]];


     */
    //Added Fonts:  KongtextRegular  &   LetsgoDigital-Regular
    // UIFont *customFont = [UIFont fontWithName:@"JosefinSansStd-Light" size:20];
    
    // log all fonts in system
    /* NSArray *fontFamilies = [UIFont familyNames];
    for (int i = 0; i < [fontFamilies count]; i++)
    {
        NSString *fontFamily = [fontFamilies objectAtIndex:i];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
        NSLog (@"%@: %@", fontFamily, fontNames);
    }
    */
}

-(void) moveInitialImagesFromBundleToDocuments
{
    //move all images and use GCD to do it
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{

        // MYPLAYER IMAGE
        UIImage *image = [UIImage imageNamed:@"player_small"];
        NSData *imageData = UIImagePNGRepresentation(image);
        
        // Destination URL
        NSURL *destinationURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"myplayer_defaultimage.png"];
        
        // Write image data to user's folder
        [imageData writeToURL:destinationURL
                    atomically:YES];
        

        // MYTEAM IMAGE
        image = [UIImage imageNamed:@"team_hat_red_small"];
        imageData = UIImagePNGRepresentation(image);
        
        // Destination URL
        destinationURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"myteam_defaultimage.png"];
        
        // Write image data to user's folder
        [imageData writeToURL:destinationURL
                   atomically:YES];
    });
}


- (NSURL *)applicationDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSURL *applicationDocumentsDirectory = [NSURL fileURLWithPath:documentsPath];
        
    return applicationDocumentsDirectory;
}


@end
