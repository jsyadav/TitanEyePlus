//
//  GreetingViewController.m
//  TitanEyePlus
//
//  Created by Admin on 10/9/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import "GreetingViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "DBController.h"
#import "TestAgainViewController.h"

@interface GreetingViewController ()


@end

@implementation GreetingViewController
@synthesize thanks;
@synthesize ratingField;
@synthesize popover;
@synthesize rating;
@synthesize userFeedback;
@synthesize actionSheet;
@synthesize picker;
@synthesize alert1;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)thanks:(id)sender
{
    
    if (ratingField.text.length<=0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Please Select Your Rating" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else if(userFeedback.text.length <= 0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Enter Your Feedback" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else if(userFeedback.text.length>=1)
    {
       alert1 = [[UIAlertView alloc]initWithTitle:@"Thanks for your Feedback" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert1.tag=1;
        [alert1 show];
        
        if([[DBController alloc]saveFeedback:userFeedback.text AndRating:ratingField.text]){
            NSLog(@"user feedback saved successully");
    }
    else{
        
        }
    }

    //exit(1);
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alert1.tag == 1) {
        
   
        
    
    
    if ( buttonIndex == [alert1 cancelButtonIndex])
        
    {
        
        TestAgainViewController  *controller;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            
            controller=[[TestAgainViewController alloc]initWithNibName:@"TestAgainViewController-Iphone" bundle:nil];
        } else {
            controller=[[TestAgainViewController alloc]initWithNibName:@"TestAgainViewController_ipad" bundle:nil];
        }
        [self presentViewController:controller animated:YES completion:Nil];

        
    }else{
        //reset clicked
    }
    }
    
    }


-(IBAction)shareOnFacebook:(id)sender
{
    FBShareDialogParams *checkParam = [[FBShareDialogParams alloc]init];
    NSDictionary* params = @{@"name": @"Titan Eye+",
                             @"caption": @"Online Eye Test",
                             @"description": @"Get Your eyes tested online @www.titaneyeplus.net/",
                             @"link": @"http://www.titaneyeplus.net",
                             @"image": @"http://image6.buzzintown.com/files/venue/upload_8000/upload_original/379427-all-titan-eye-plus-stores.gif"};
    //FBshare native is available
    if([FBDialogs canPresentShareDialogWithParams:checkParam])
    {
        [FBDialogs presentShareDialogWithLink:[NSURL URLWithString:[params valueForKey:@"link"]] name:[params valueForKey:@"name"] caption:[params valueForKey:@"caption"] description:[params valueForKey:@"description"] picture:[NSURL URLWithString:[params valueForKey:@"image"]] clientState:nil handler:^(FBAppCall *call, NSDictionary *results, NSError *error)
         {
            if(error)
            {
                NSLog(@"Error: %@", error.description);
            } else
            {
                NSLog(@"Success!");
            }
        }];
    }
    else
    {
        [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                               parameters:params
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error)
        {
                                                      if(error)
                                                      {
                                                          NSLog(@"Error: %@", error.description);
                                                      } else
                                                      {
                                                          NSLog(@"Success!");
                                                     
                                                      }
            
        }];
    }
        
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (void)viewDidLoad
{
    
   
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"IMAGE-RESULT-PAGE.jpg"]];
        
    }

   


    rating=[[NSArray alloc]initWithObjects:@"Select Your Rating",@"Very Good",@"Good",@"Average",@"Poor",@"Disappointed" ,nil];
    ratingField.text=[rating objectAtIndex:2];
    userFeedback.layer.borderWidth = 1.0f;
    userFeedback.layer.borderColor = [[UIColor blackColor] CGColor];
//    [self.ratingField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
   //For Hiding StatusBar.
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    else
    {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *) textField
{
    if([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone){//ipad
        if (textField==ratingField)
        {
            
            UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            toolbar.barStyle = UIBarStyleDefault;
            
            
            UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneButtonPressed:)];
            UIBarButtonItem *fixed1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            UIBarButtonItem *fixed2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            
            [toolbar setItems:[NSArray arrayWithObjects: fixed1,  fixed2, nextButton, nil]];
            
            UIPickerView    *thePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 320, 216)];
            CGRect thePickerFrame = thePickerView.frame;
            thePickerFrame.origin.y = toolbar.frame.size.height;
            [thePickerView setFrame:thePickerFrame];
            
            
            UIView *view = [[UIView alloc] init];
            [view addSubview:thePickerView];
            [view addSubview:toolbar];
            
            UIViewController *vc = [[UIViewController alloc] init];
            [vc setView:view];
            [vc setContentSizeForViewInPopover:CGSizeMake(320, 260)];
            
            popover = [[UIPopoverController alloc] initWithContentViewController:vc];
            
            
            
            
            thePickerView.showsSelectionIndicator = YES;
            thePickerView.dataSource = self;
            thePickerView.delegate = self;
            
            [thePickerView selectRow:0 inComponent:0 animated:NO];
            if (self.view.window != nil){
                [self.popover presentPopoverFromRect:ratingField.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
            }
            return NO;
        }
        
    }
    else
    {
        if (textField==ratingField)
        {
            actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"" destructiveButtonTitle:nil otherButtonTitles:nil]; //as we want to display a subview we won't be using the default buttons but rather we're need to create a toolbar to display the buttons on
            
            [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
            CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
            
            
            picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
            picker.showsSelectionIndicator = YES;
            picker.dataSource = self;
            picker.delegate = self;
            [actionSheet addSubview:picker];
            
            UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            pickerToolbar.barStyle = UIBarStyleBlackOpaque;
            [pickerToolbar sizeToFit];
            
            NSMutableArray *barItems = [[NSMutableArray alloc] init];
            
            UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            [barItems addObject:flexSpace];
            
            UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
            [barItems addObject:doneBtn];
                      [pickerToolbar setItems:barItems animated:YES];
            
            [actionSheet addSubview:pickerToolbar];
            [actionSheet addSubview:picker];
            [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
            //[actionSheet showInView:self.view];
            [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
            return NO;
        }

        
    }
    
    
    return  NO;
}


-(void)animateTextView:(UITextView*)textView up:(BOOL)up
{
    int movement;
    NSLog(@"orientation-%d",[[UIDevice currentDevice]orientation]);
    const int movementDistance = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone?-130:-264; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        movement = (up ? movementDistance : -movementDistance);
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
   }
//    else{
////        if([[UIDevice currentDevice]orientation]==UIDeviceOrientationLandscapeLeft)
////            movement = (up ? movementDistance : -movementDistance) * -1;
////        else
////            movement =(up ? -movementDistance : movementDistance)* -1;
//        movement = (up ? movementDistance : -movementDistance);
//        self.view.frame = CGRectOffset(self.view.frame,movement, 0);
//    }
    [UIView commitAnimations];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan:withEvent:");
    
    /*--
     * Override UIResponder touchesBegan:withEvent: to resign the textView when the user taps the background
     * Use fast enumeration to go through the subview property of UIView
     * Any object that is the current first repsonder will resign that status
     * Make a call to super to take care of any unknown behavior that touchesBegan:withEvent: needs to do behind the scenes
     --*/
    
    for (UITextView *textView in self.view.subviews) {
        if ([textView isFirstResponder]) {
            [textView resignFirstResponder];
        }
    }
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"textView:shouldChangeTextInRange:replacementText:");
    
    NSLog(@"textView.text.length -- %i",textView.text.length);
    NSLog(@"text.length         -- %i",text.length);
    //NSLog(@"textView.text.length + text.length-- %i",textView.text.length + text.length);
    
    /*--
     * This method is called just before text in the textView is displayed
     * This is a good place to disallow certain characters
     * Limit textView to 140 characters
     * Resign keypad if done button pressed comparing the incoming text against the newlineCharacterSet
     * Return YES to update the textView otherwise return NO
     --*/
    
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    
    if (textView.text.length + text.length > 140){//140 characters are in the textView
        if (location != NSNotFound){ //Did not find any newline characters
            [textView resignFirstResponder];
        }
        return NO;
    }
    else if (location != NSNotFound){ //Did not find any newline characters
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
    
}


- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    
    [self animateTextView:textView up:NO];
    return YES;
    
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if(textView==userFeedback){
        [self animateTextView:textView up:YES];
        return YES;
    }
    else
        return NO;
    
}


-(void)doneButtonPressed:(id)sender
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    else
        [popover dismissPopoverAnimated:YES];
}

-(IBAction)exit:(id)sender
{

    TestAgainViewController  *controller;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        controller=[[TestAgainViewController alloc]initWithNibName:@"TestAgainViewController-Iphone" bundle:nil];
    } else {
        controller=[[TestAgainViewController alloc]initWithNibName:@"TestAgainViewController_ipad" bundle:nil];
    }
    [self presentViewController:controller animated:YES completion:Nil];
}
    //For Pickerview
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return[rating count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return[rating objectAtIndex:row];
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    ratingField.text=[rating objectAtIndex:row];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
