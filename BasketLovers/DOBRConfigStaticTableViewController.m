//
//  DOBRConfigStaticTableViewController.m
//  BasketLovers
//
//  Created by David Oliver Barreto Rodríguez on 08/09/14.
//  Copyright (c) 2014 David Oliver Barreto Rodríguez. All rights reserved.
//

#import "DOBRConfigStaticTableViewController.h"
#import "constants.h"
#import <QuartzCore/QuartzCore.h>
#import "DOBRSharedStoreCoordinator.h"


@interface DOBRConfigStaticTableViewController ()<UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

// MY TEAM
@property (weak, nonatomic) IBOutlet UITextField *myteamNameText;
@property (weak, nonatomic) IBOutlet UITextField *myteamTournamentText;
@property (weak, nonatomic) IBOutlet UIImageView *myteamImageView;

// MY PLAYER
@property (weak, nonatomic) IBOutlet UITextField *myplayerNameText;
@property (weak, nonatomic) IBOutlet UIImageView *myplayerImageView;
@property (weak, nonatomic) IBOutlet UISwitch *myplayerScoreIsActivatedSwitch;

//GAME
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameNumberOfPeriodsSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gamePeriodTimeSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameFoulsToBonusSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gamePlayerFoulsSegmentedControl;

// UIImagePickerController
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic)  UIImageView *imageSelected;


// Properties

// NSUserDefaults User Configuration
@property (strong, nonatomic) NSMutableDictionary *configDictionary;



@end

@implementation DOBRConfigStaticTableViewController



#pragma mark - Custom Initializers

-(NSMutableDictionary *)configDictionary {
    
    if (!_configDictionary) {
        
        _configDictionary = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                        
          // MY TEAM
            @"BL_UserConfig_myteamName" : @"",
            @"BL_UserConfig_myteamTournament" : @"",
          
          // MY PLAYER
            @"BL_UserConfig_myplayerName" : @"",
            @"BL_UserConfig_myplayerScoreIsActivated" : @YES,
          
          // GAME
            @"BL_UserConfig_gameNumberOfPeriods" : @4,
            @"BL_UserConfig_gamePeriodTime": @10,
            @"BL_UserConfig_gameFoulsToBonus" : @5,
            @"BL_UserConfig_gamePlayerFouls" : @5,
        }];
    }
        
    return _configDictionary;
    
}


-(UIImagePickerController *)imagePicker {

    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
    
    return _imagePicker;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}



#pragma mark - View Livecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Configure Look of controls
    [self configureTextFields];
    [self configureControls];
    
    [self setupGestureRecognizers];

}


-(void)viewWillAppear:(BOOL)animated {
    
    // Preload User Defaults
    self.configDictionary = [[DOBRSharedStoreCoordinator sharedStoreCoordinator] loadUserDefaultsConfig];
    
    [self preloadUserDefaults];
    
}


-(void)viewWillDisappear:(BOOL)animated {
    
    // Save on exit
    [self saveConfig];
    
    [[DOBRSharedStoreCoordinator sharedStoreCoordinator] userDefaultsConfig:self.configDictionary];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}
*/
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    // MY TEAM
    if ((indexPath.section == 0) && (indexPath.row == 0)){
        [self.myteamNameText becomeFirstResponder];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

        cell.tintColor = [UIColor redColor
                          ];
//        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds] ;
//        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:1.000] ;
        
    } else if ((indexPath.section == 0) && (indexPath.row == 1)) {
        [self.myteamTournamentText becomeFirstResponder];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        cell.tintColor = [UIColor redColor];
    }
    
    // MY PLAYER
    if ((indexPath.section == 1) && (indexPath.row == 0)){
        [self.myplayerNameText becomeFirstResponder];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        cell.tintColor = [UIColor redColor];
        
    } else if ((indexPath.section == 1) && (indexPath.row == 1)) {
        [self.myplayerScoreIsActivatedSwitch becomeFirstResponder];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        cell.tintColor = [UIColor redColor];
    }
    
    // GAME
    if ((indexPath.section == 2) && (indexPath.row == 0)){
        [self.gameNumberOfPeriodsSegmentedControl becomeFirstResponder];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        cell.tintColor = [UIColor redColor];
        
    } else if ((indexPath.section == 2) && (indexPath.row == 1)) {
        [self.gamePeriodTimeSegmentedControl becomeFirstResponder];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        cell.tintColor = [UIColor redColor];
    } else if ((indexPath.section == 2) && (indexPath.row == 2)) {
        [self.gameFoulsToBonusSegmentedControl becomeFirstResponder];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        cell.tintColor = [UIColor redColor];
    }
    

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



#pragma mark - Helper Methods

- (void)configureTextFields {
    
    //MY TEAM
    //self.myteamNametext.placeholder = NSLocalizedString(@"Placeholder text", nil);
    self.myteamNameText.delegate = self;
    self.myteamNameText.autocorrectionType = UITextAutocorrectionTypeYes;
    self.myteamNameText.returnKeyType = UIReturnKeyDone;
    self.myteamNameText.tintColor = [UIColor redColor];
    //self.myteamNameText.clearButtonMode = UITextFieldViewModeNever;

    self.myteamTournamentText.delegate = self;
    self.myteamTournamentText.autocorrectionType = UITextAutocorrectionTypeYes;
    self.myteamTournamentText.returnKeyType = UIReturnKeyDone;
    self.myteamTournamentText.tintColor = [UIColor redColor];
    //self.myteamTournamentText.clearButtonMode = UITextFieldViewModeNever;

    
    //MY PLAYER
    //self.myteamNametext.placeholder = NSLocalizedString(@"Placeholder text", nil);
    self.myplayerNameText.delegate = self;
    self.myplayerNameText.autocorrectionType = UITextAutocorrectionTypeYes;
    self.myplayerNameText.returnKeyType = UIReturnKeyDone;
    self.myplayerNameText.tintColor = [UIColor redColor];
    //self.myplayerNameText.clearButtonMode = UITextFieldViewModeNever;
    
}

-(void)configureControls {
    // MY TEAM
    self.myplayerScoreIsActivatedSwitch.tintColor = [UIColor redColor];
    
    // GAME
    self.gameNumberOfPeriodsSegmentedControl.tintColor = [UIColor redColor];
    self.gamePeriodTimeSegmentedControl.tintColor = [UIColor redColor];
    self.gameFoulsToBonusSegmentedControl.tintColor = [UIColor redColor];
    self.gamePlayerFoulsSegmentedControl.tintColor = [UIColor redColor];
    //self.myplayerNameText.clearButtonMode = UITextFieldViewModeNever;
}

/*
- (void)configureDefaultSegmentedControl {
    self.myplayerIsHomeSegmentedControl.momentary = YES;
    
    [self.myplayerIsHomeSegmentedControl addTarget:self action:@selector(selectedSegmentDidChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.gameNumberOfPeriodsSegmentedControl setTitleTextAttributes:@{
                                                                       NSForegroundColorAttributeName : [UIColor redColor]
                                                                       } forState:UIControlStateNormal];

}
*/

-(void)setupGestureRecognizers {
    
    NSMutableSet *imageViewArray = [[NSMutableSet alloc] init];
    
    [imageViewArray addObject:self.myteamImageView];
    [imageViewArray addObject:self.myplayerImageView];
    
    for(UIImageView *imageView in imageViewArray)
    {
        // Single Tap
        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(didTapOnImageView:)];
        
        [singleTapGesture setDelaysTouchesBegan: NO];
        [singleTapGesture setNumberOfTapsRequired: 1];
        
        [imageView addGestureRecognizer:singleTapGesture];
    }
}



-(UIImage *)makeRoundedImage:(UIImage *)image
                      radius:(float)radius;
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}


/*
-(UIImage *)roundedImage:(UIImage *) image
                      radius: (float) radius;
{
    yourImageView.layer.cornerRadius = yourRadius;
    yourImageView.clipsToBounds = YES;
    
    #define kBoarderWidth 3.0
    #define kCornerRadius 8.0
    CALayer *borderLayer = [CALayer layer];
    CGRect borderFrame = CGRectMake(0, 0, (imageView.frame.size.width), (imageView.frame.size.height));
    [borderLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
    [borderLayer setFrame:borderFrame];
    [borderLayer setCornerRadius:kCornerRadius];
    [borderLayer setBorderWidth:kBorderWidth];
    [borderLayer setBorderColor:[[UIColor redColor] CGColor]];
    [imageView.layer addSublayer:borderLayer];
    
    Just change the frame to whatever amount 'outside' you like: CGRect borderFrame = CGRectMake(-1.0, -1.0, imageView.frame.size.width+2.0, imageView.frame.size.height+2.0); –  Andrew Bennett Mar 3 at 19:09
    
    return roundedImage;
}

 */




#pragma mark - UIIMagePickerController

-(void)pickPhotoFromLibrary {

    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.navigationController presentViewController:self.imagePicker
                                            animated:YES
                                          completion:nil];
}

-(void)takePhotoFromCamera {
    
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self.navigationController presentViewController:self.imagePicker
                                            animated:YES
                                          completion:nil];
}


#pragma mark - Actions

/*
- (void)selectedSegmentDidChange:(UISegmentedControl *)segmentedControl {
    
    switch (segmentedControl.tag) {
        case kUIStaticConfig_gameNumberOfPeriodsSegmentedControl:
            NSLog(@"The selected segment changed for: %@.", segmentedControl);
            break;
            
        default:
            break;
    }
}
*/

-(void)didTapOnImageView:(UITapGestureRecognizer *)senderGesture {

    NSLog(@"ImageView Tapped");
    NSLog(@"%@", senderGesture);
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        #warning - uncomment the follwoing for physical device
        // return;
    }
    
    
    self.imageSelected = (UIImageView *)senderGesture.view;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Pick Photo Source"
                                                             delegate:self
                                                     cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take Photo", @"Use Photo Library", nil];
    [actionSheet showInView:self.view];
}


- (IBAction)backButton:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)preloadUserDefaults {
    
    // MY TEAM
    self.myteamNameText.text = [self.configDictionary objectForKey:@"BL_UserConfig_myteamName"];
    self.myteamTournamentText.text = [self.configDictionary objectForKey:@"BL_UserConfig_myteamTournament"];
    
    
    // MY PLAYER
    self.myplayerNameText.text = [self.configDictionary objectForKey:@"BL_UserConfig_myplayerName"];
    self.myplayerScoreIsActivatedSwitch.on = [[self.configDictionary objectForKey:@"BL_UserConfig_myplayerScoreIsActivated"] boolValue];
    
    // GAME
    for (int segmentIndex = 0; segmentIndex <= self.gameNumberOfPeriodsSegmentedControl.numberOfSegments-1; segmentIndex ++) {
        if ([[self.gameNumberOfPeriodsSegmentedControl titleForSegmentAtIndex:segmentIndex] intValue] == [[self.configDictionary objectForKey:@"BL_UserConfig_gameNumberOfPeriods"] intValue]) {
            self.gameNumberOfPeriodsSegmentedControl.selectedSegmentIndex = segmentIndex;
        }
    }

    for (int segmentIndex = 0; segmentIndex <= self.gamePeriodTimeSegmentedControl.numberOfSegments-1; segmentIndex ++) {
        if ([[self.gamePeriodTimeSegmentedControl titleForSegmentAtIndex:segmentIndex] intValue] == [[self.configDictionary objectForKey:@"BL_UserConfig_gameNumberOfPeriods"] intValue]) {
            self.gamePeriodTimeSegmentedControl.selectedSegmentIndex = segmentIndex;
        }
    }

    for (int segmentIndex = 0; segmentIndex <= self.gameFoulsToBonusSegmentedControl.numberOfSegments-1; segmentIndex ++) {
        if ([[self.gameFoulsToBonusSegmentedControl titleForSegmentAtIndex:segmentIndex] intValue] == [[self.configDictionary objectForKey:@"BL_UserConfig_gameFoulsToBonus"] intValue]) {
            self.gameFoulsToBonusSegmentedControl.selectedSegmentIndex = segmentIndex;
        }
    }
    
    for (int segmentIndex = 0; segmentIndex <= self.gamePlayerFoulsSegmentedControl.numberOfSegments-1; segmentIndex ++) {
        if ([[self.gamePlayerFoulsSegmentedControl titleForSegmentAtIndex:segmentIndex] intValue] == [[self.configDictionary objectForKey:@"BL_UserConfig_gamePlayerFouls"] intValue]) {
            self.gamePlayerFoulsSegmentedControl.selectedSegmentIndex = segmentIndex;
        }
    }
    
    
/*
    self.gameNumberOfPeriodsSegmentedControl.selectedSegmentIndex = [[self.configDictionary objectForKey:@"BL_UserConfig_gameNumberOfPeriods"] intValue];
    self.gamePeriodTimeSegmentedControl.selectedSegmentIndex = [[self.configDictionary objectForKey:@"BL_UserConfig_gamePeriodTime"] intValue];
    self.gameFoulsToBonusSegmentedControl.selectedSegmentIndex = [[self.configDictionary objectForKey:@"BL_UserConfig_gameFoulsToBonus"] intValue];
    self.gamePlayerFoulsSegmentedControl.selectedSegmentIndex = [[self.configDictionary objectForKey:@"BL_UserConfig_gamePlayerFouls"] intValue];
*/
    
    // Images
    // self.myplayerImageView.image = [UIImage imageNamed:@"player_small"];
    // self.myteamImageView.image = [UIImage imageNamed:@"team_hat_red_small"];
    
    self.myteamImageView.image = [self makeRoundedImage:[UIImage imageNamed:@"team_hat_red_small"]
                                                 radius:(self.myteamImageView.frame.size.width / 2)];
    
    
    self.myplayerImageView.image = [self makeRoundedImage:[UIImage imageNamed:@"player_small"]
                                                   radius:(self.myplayerImageView.frame.size.width / 2)];
    
    NSLog(@"Config Table LOADED Dictionary %@", self.configDictionary);
    NSLog(@"Initial Config Data Loaded from User Defaults");
    
}



-(void)saveConfig{
    
    // MY TEAM
    [self.configDictionary setObject:self.myteamNameText.text
                 forKey:@"BL_UserConfig_myteamName"];
    [self.configDictionary setObject:self.myteamTournamentText.text
                 forKey:@"BL_UserConfig_myteamTournament"];
    
    // MY PLAYER
    [self.configDictionary setObject:self.myplayerNameText.text
                 forKey:@"BL_UserConfig_myplayerName"];
    [self.configDictionary setObject:[NSNumber numberWithBool:self.myplayerScoreIsActivatedSwitch.on] forKey:@"BL_UserConfig_myplayerScoreIsActivated"];
    
    // GAME
    [self.configDictionary setObject:[NSNumber numberWithInteger:[[self.gameNumberOfPeriodsSegmentedControl titleForSegmentAtIndex:self.gameNumberOfPeriodsSegmentedControl.selectedSegmentIndex] integerValue]]
                             forKey:@"BL_UserConfig_gameNumberOfPeriods"];

    [self.configDictionary setObject:[NSNumber numberWithInteger:[[self.gamePeriodTimeSegmentedControl titleForSegmentAtIndex:self.gamePeriodTimeSegmentedControl.selectedSegmentIndex] integerValue]]
                             forKey:@"BL_UserConfig_gamePeriodTime"];
    
    [self.configDictionary setObject:[NSNumber numberWithInteger:[[self.gameFoulsToBonusSegmentedControl titleForSegmentAtIndex:self.gameFoulsToBonusSegmentedControl.selectedSegmentIndex] integerValue]] forKey:@"BL_UserConfig_gameFoulsToBonus"];
    
    [self.configDictionary setObject:[NSNumber numberWithInteger:[[self.gameFoulsToBonusSegmentedControl titleForSegmentAtIndex:self.gamePlayerFoulsSegmentedControl.selectedSegmentIndex] integerValue]] forKey:@"BL_UserConfig_gamePlayerFouls"];
    ;
    
    NSLog(@"Config Table SAVED Dictionary %@", self.configDictionary);

    /*
     NSData *imageData = UIImagePNGRepresentation(image);
     
     UIImage *image=[UIImage imageWithData:data];

 
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
    
    */
    
    
    //NSLog(@"Configuration Saved to User Defaults");
    
}



#pragma mark - UITextFieldDelegate (set in Interface Builder)

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    

    return YES;
}


#pragma mark - ActionSheet Deletgate Methods

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {

    if (buttonIndex == actionSheet.cancelButtonIndex) return;
    
    switch (buttonIndex) {
        case kUIImagePickerSelection_TakePhotoFromCamera:
            [self takePhotoFromCamera];
            break;
            
        case kUIImagePickerSelection_PickPhotoFromLibrary:
            [self pickPhotoFromLibrary];
            break;
            
        default:
            break;
    }
}


#pragma mark - UIImagePickerContrller Delegate Methods


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.imageSelected.image = image;
    
    /*
     NSData *imageData = UIImagePNGRepresentation(image);
     
     UIImage *image=[UIImage imageWithData:data];
     */
    
// SAVE Image in NSUserDefaults NOT RECOMMENDED... instead go with file paths
/*
 
 Save:
 
 [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image)            forKey:key];

 Read:
 
 NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
 UIImage* image = [UIImage imageWithData:imageData];

 HOWEVERRRR !!!!
 
 
 For those who still looking for answer here is code of "advisable" way to save image in NSUserDefaults. You SHOULD NOT save image data directly into NSUserDefaults!
        
        Write data:
        
        // Get image data. Here you can use UIImagePNGRepresentation if you need transparency
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
    
    // Get image path in user's folder and store file with name image_CurrentTimestamp.jpg (see documentsPathForFileName below)
    NSString *imagePath = [self documentsPathForFileName:[NSString stringWithFormat:@"image_%f.jpg", [NSDate timeIntervalSinceReferenceDate]]];
    
    // Write image data to user's folder
    [imageData writeToFile:imagePath atomically:YES];
    
    // Store path in NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:imagePath forKey:kPLDefaultsAvatarUrl];
    
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
*/

}

@end



