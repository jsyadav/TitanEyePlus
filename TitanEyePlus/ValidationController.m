//
//  ViewController.m
//  imageBounds
//
//  Created by Lion User on 07/10/2013.
//  Copyright (c) 2013 3edge. All rights reserved.
//

#import "ValidationController.h"
#import <QuartzCore/QuartzCore.h>
#import "DBController.h"
#import  "AppDelegate.h"
#import "TransitionViewController.h"
@interface ValidationController ()

@end

@implementation ValidationController
@synthesize cityField;
@synthesize popover;
@synthesize entercode;
@synthesize selectcity;
@synthesize forcode;
@synthesize actionSheet;
@synthesize cities;
@synthesize cd;
@synthesize sample;


- (void)viewDidLoad
{
    //entercode.text=forcode;
    [self.entercode setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.cityField setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    [super viewDidLoad];
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"Back-image_new.jpg"]];

        
    }
        
    
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
     self.cities = [[DBController alloc]retriveCity];
     NSLog(@"%@",self.cities);
     entercode.delegate=self;

    
}

-(void)orientationChanged:(NSNotification *)notification
{

        [entercode becomeFirstResponder];
        [entercode resignFirstResponder];
  
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [entercode resignFirstResponder];
       return  YES	;
}
-(IBAction)submit:(id)sender{
  
/*
    //production
 
   
    cd=[NSString stringWithFormat:@"%@",entercode.text];
    
    if([entercode.text length]==0)
    {
        UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter the Code"
                                                       delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    //FOR VALIDATING SMS API CODE
   
    else if(![cd compare:forcode options:NSCaseInsensitiveSearch]== NSOrderedSame)
   {
       NSLog(@"THE LATEST :%@",forcode);
        UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter the correct Code"
                                                       delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
       
    }
        else if([cityField.text length ]==0)
        {
            UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"" message:@"SELECT CITY"
                                                           delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
    
        }
    else
    {
        
     appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
     
     [appDelegate.userInfo setValue: self.cityField.text forKey:@"city"];
     InstructionViewController *ivcontroller;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            ivcontroller =[[InstructionViewController alloc]initWithNibName:@"InstructionViewController" bundle:nil];
        }
        else{
            
            ivcontroller=[[InstructionViewController alloc]initWithNibName:@"InstructionViewController_iPad" bundle:nil];
            
        }
        
        [self presentViewController:ivcontroller animated:YES completion:nil];
        ivcontroller.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
        
        
        
    }
    //for production
    
*/
    //testing
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [appDelegate.userInfo setValue: self.cityField.text forKey:@"city"];
    
    /*
    InstructionViewController *ivcontroller;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        ivcontroller =[[InstructionViewController alloc]initWithNibName:@"InstructionViewController" bundle:nil];
    }
    else{
        
        ivcontroller=[[InstructionViewController alloc]initWithNibName:@"InstructionViewController_iPad" bundle:nil];
        
    }
     */
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate.transAudioFile = @"disclaimer.wav";
    appDelegate.transNib = @"DisclaimerViewController";
    appDelegate.transTitle = @"DISCLAIMER";
    appDelegate.transPara1 = @"EYE SCREENING WARNING \n\n \
    The following application is not intended to replace a \
    regular full eye examination performed by a registered optician. \n \
    We recommend you get a full eye test after using this application.";
    appDelegate.transPara2 = @"";
    
    
    TransitionViewController *tvc;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        tvc = [[TransitionViewController alloc] initWithNibName:@"TransitionViewController" bundle:nil];
        NSLog(@"Using transtion mobile ");
    } else {
        tvc = [[TransitionViewController alloc] initWithNibName:@"TransitionViewController_iPad" bundle:nil];
        NSLog(@"Using transtion tablet");
    }
    
    [self presentViewController:tvc animated:YES completion:nil];
    //tvc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;


    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *) textField
{
//   if(textField==entercode)
//   {
//       entercode.text=forcode;
//   }
    if([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone){//ipad
        //[self.view endEditing:YES];
           if (textField==cityField) {
        
        
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.barStyle = UIBarStyleDefault;
    
   
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneButtonPressed:)];
               
   [[UIBarButtonItem appearance] setTintColor:[UIColor orangeColor]];
               
    UIBarButtonItem *fixed1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *fixed2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [toolbar setItems:[NSArray arrayWithObjects: fixed1,  fixed2, nextButton, nil]];
    
    UIPickerView    *thePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,43, 320, 216)];
    CGRect thePickerFrame = thePickerView.frame;
    thePickerFrame.origin.y = toolbar.frame.size.height;
    [thePickerView setFrame:thePickerFrame];
    
    
   // UIView *view = [[UIView alloc] init];
               CGRect  viewRect = CGRectMake(100, 500, 320, 260);
               UIView* myView = [[UIView alloc] initWithFrame:viewRect];
    [myView addSubview:thePickerView];
    [myView addSubview:toolbar];
    
    UIViewController *vc = [[UIViewController alloc] init];
    [vc setView:myView];
    [vc setContentSizeForViewInPopover:CGSizeMake(320, 260)];
    
    popover = [[UIPopoverController alloc] initWithContentViewController:vc];
              
              
    
    
    thePickerView.showsSelectionIndicator = YES;
    thePickerView.dataSource = self;
    thePickerView.delegate = self;
    
    [thePickerView selectRow:0 inComponent:0 animated:NO];
    if (self.view.window != nil){
        [self.popover presentPopoverFromRect:cityField.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    }
    return NO;
    }
    else{
        [self animateTextField:textField up:YES];
        return YES;
    }
    }
    else{//mobile
        if (textField==cityField) {
           
            [entercode resignFirstResponder];
           

            
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"" destructiveButtonTitle:nil otherButtonTitles:nil]; //as we want to display a subview we won't be using the default buttons but rather we're need to create a toolbar to display the buttons on
        
        [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
        CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
        
        
        selectcity = [[UIPickerView alloc] initWithFrame:pickerFrame];
        selectcity.showsSelectionIndicator = YES;
        selectcity.dataSource = self;
        selectcity.delegate = self;
            //[selectcity setBackgroundColor:[UIColor orangeColor]];
        [actionSheet addSubview:selectcity];
        
        UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        pickerToolbar.barStyle = UIBarStyleBlackOpaque;
        [pickerToolbar sizeToFit];
        
        NSMutableArray *barItems = [[NSMutableArray alloc] init];
        
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [barItems addObject:flexSpace];
        
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
        [barItems addObject:doneBtn];
             [[UIBarButtonItem appearance] setTintColor:[UIColor orangeColor]];
        
        
        //    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)];
        //    [barItems addObject:cancelBtn];
        
        [pickerToolbar setItems:barItems animated:YES];
        
        [actionSheet addSubview:pickerToolbar];
        
        [actionSheet addSubview:selectcity];
        
        [actionSheet showInView:self.view];
        
        [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
            return NO;
        }
        else {
             [self animateTextField:textField up:YES];
            
            return YES;
        }
    }
    }

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(textField    ==  entercode && cityField){
        
       [self animateTextField:textField up:NO];
        return YES;
    }
    else        return NO;
        
}
//for iphone actionsheet
-(void)doneButtonPressed:(id)sender
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    else
        [popover dismissPopoverAnimated:YES];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
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
    [UIView commitAnimations];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return[cities count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return[cities objectAtIndex:row];
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    cityField.text=[cities objectAtIndex:row];
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    [self.popover dismissPopoverAnimated:NO];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
