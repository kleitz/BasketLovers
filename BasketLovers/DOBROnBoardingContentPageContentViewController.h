//
//  PageContentViewController.h
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOBROnBoardingContentPageContentViewController : UIViewController

// UIPAgeViewController index
@property NSUInteger pageIndex;

// Customization Of View Controller
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property NSString *titleText;
@property NSString *imageFile;

@end
