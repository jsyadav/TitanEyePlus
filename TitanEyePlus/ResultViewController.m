//
//  ResultViewController.m
//  TitanEyePlus
//
//  Created by Admin on 10/9/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import "ResultViewController.h"
#import "GreetingViewController.h"
#import "DBController.h"
#import "AppDelegate.h"

@interface ResultViewController ()

@end

@implementation ResultViewController
@synthesize next;
@synthesize nearBy;
@synthesize selectNearBy;
@synthesize actionSheet;
@synthesize popover;
@synthesize nearLocation;
@synthesize cities_nearBy;
@synthesize lr,rr;
@synthesize table;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad
{
   
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone)
        self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"IMAGE-RESULT-PAGE.jpg"]];
    
    @try {
         appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSArray *keys = [[NSArray alloc]initWithObjects:@"etest",@"clockdial",@"duochrome",@"nearvision", nil];
    s1 = [[NSArray alloc]initWithObjects:@"Distance Vision",@"ClockDial",@"Duochrome",@"Near Vision",nil];
    s2 = [[NSArray alloc]initWithObjects:@"Distance  Vision",@"ClockDial",@"Duochrome",@"Near Vision",nil];
    s3=[[NSArray alloc]initWithObjects:@"Select NearBy City", nil];
    lr = [[NSMutableArray alloc]init];
    rr = [[NSMutableArray alloc]init];
    
    
    
    NSLog(@"etest is %@",[appDelegate.leftEyeResult valueForKey:@"etest"]);
    
    
    NSLog(@"clockdial is %@",[appDelegate.leftEyeResult valueForKey:@"clockdial"]);

    
    //for lr
    for(int i=0;i<keys.count;i++){
        
        [lr insertObject:[appDelegate.leftEyeResult objectForKey:[keys objectAtIndex:i]] atIndex:i];
        NSLog(@"%@",[appDelegate.leftEyeResult objectForKey:[keys objectAtIndex:i]]);
    }
    //for rr
    for(int j=0;j<keys.count;j++){
        
        [rr insertObject:[appDelegate.rightEyeResult objectForKey:[keys objectAtIndex:j]] atIndex:j];
         NSLog(@"%@",[appDelegate.rightEyeResult objectForKey:[keys objectAtIndex:j]]);
    }
    
    NSLog(@"left eye answer%@",lr);
    NSLog(@"right eye answer%@",rr);
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad)
    {
    
    [self.selectNearBy setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    else
    {
        
        [self.selectNearBy setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
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
    @try{
    nearBy = [[DBController alloc]retriveNearByLocation:[appDelegate.userInfo valueForKey:@"city"]];
    
    
        
        selectNearBy.text=[nearBy objectAtIndex:0];
    }
    @catch(NSException *e){
        NSLog(@"Nearby city selection exception");
    }
    }@catch(NSException *e){
        NSLog(@"resultview exception");
 
    }
    //for hiding the empty lines in table view
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,1)];
    v.backgroundColor = [UIColor clearColor];
    [self.table setTableFooterView:v];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)next:(id)sender
{
    if (selectNearBy.text<=0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please select nearby location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        [self callGreetingView];
        if ([[DBController alloc]saveUserInfo:appDelegate.userInfo]) {
            NSLog(@"Inserted userinfo successfully");
        }

        
    }
}
-(void)callGreetingView
{
    GreetingViewController  *controller;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        controller=[[GreetingViewController alloc]initWithNibName:@"GreetingViewController" bundle:nil];
    } else {
        controller=[[GreetingViewController alloc]initWithNibName:@"GreetingViewController_ipad" bundle:nil];
    }
    [self presentViewController:controller animated:YES completion:Nil];
    
}

//For selecting nearBy location
- (BOOL)textFieldShouldBeginEditing:(UITextField *) textField
{
    if([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone){//ipad
        if (textField==selectNearBy) {
            
            UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            toolbar.barStyle = UIBarStyleDefault;
            
            
            UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneButtonPressed:)];
            UIBarButtonItem *fixed1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            UIBarButtonItem *fixed2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            
            [[UIBarButtonItem appearance] setTintColor:[UIColor orangeColor]];
            
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
                [self.popover presentPopoverFromRect:selectNearBy.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
            }
            return NO;
        }
        else{
            [self animateTextField:textField up:YES];
            return YES;
        }
    }
    else{//mobile
        if (textField==selectNearBy) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"" destructiveButtonTitle:nil otherButtonTitles:nil]; //as we want to display a subview we won't be using the default buttons but rather we're need to create a toolbar to display the buttons on
            
            [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
            CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
            
            
            nearLocation = [[UIPickerView alloc] initWithFrame:pickerFrame];
            nearLocation.showsSelectionIndicator = YES;
            nearLocation.dataSource = self;
            nearLocation.delegate = self;
            [actionSheet addSubview:nearLocation];
            
            UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            pickerToolbar.barStyle = UIBarStyleBlackOpaque;
            [pickerToolbar sizeToFit];
            
            NSMutableArray *barItems = [[NSMutableArray alloc] init];
            
            UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            [barItems addObject:flexSpace];
            
            UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
            
             [[UIBarButtonItem appearance] setTintColor:[UIColor orangeColor]];
            
            [barItems addObject:doneBtn];
            
            [pickerToolbar setItems:barItems animated:YES];
            
            [actionSheet addSubview:pickerToolbar];
            
            [actionSheet addSubview:nearLocation];
            
            [actionSheet showInView:self.view];
            
            [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
            return NO;
        }
        else{
            [self animateTextField:textField up:YES];
            return YES;
        }
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(textField    == selectNearBy ){
        [self animateTextField:textField up:NO];
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
-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone?-130:-264; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    }else{
        self.view.frame = CGRectOffset(self.view.frame,movement, 0);
    }
    [UIView commitAnimations];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return[nearBy count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return[nearBy objectAtIndex:row];
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    selectNearBy.text=[nearBy objectAtIndex:row];
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    [self.popover dismissPopoverAnimated:NO];
    return YES;
}


//for Tableview


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return [s1 count];
        
    }
    else if(section==1)
    {
        
        return [s1 count];
    }
    else if(section==2)
    {
        return 0;
    }
    
    return YES;
}
//
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,200,300,244)];
    tempView.backgroundColor=[UIColor clearColor];
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,300,34)];
    tempLabel.backgroundColor=[UIColor clearColor];
  
    tempLabel.textColor = [UIColor orangeColor]; //here you can change the text color of header.
    tempLabel.font = [UIFont fontWithName:@"Helvetica" size:15.5];
      self.edgesForExtendedLayout = UIRectEdgeNone;
    if (section ==0) {
        tempLabel.text=@"RIGHT EYE";

    }
    else if (section == 1)
    {
          tempLabel.text=@"LEFT EYE";
    }
    
    [tempView addSubview:tempLabel];
    return tempView;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tvc =[table dequeueReusableCellWithIdentifier:nil];
    if(tvc ==nil)
    {
        tvc = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad){
        
        tvc.detailTextLabel.textColor=[UIColor whiteColor];
        tvc.textLabel.textColor=[UIColor whiteColor];
        }
        else{
            tvc.detailTextLabel.textColor=[UIColor blackColor];
            tvc.textLabel.textColor=[UIColor blackColor];
            
        }
        
        tvc.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        tvc.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12];

        
        if (indexPath.section==0)
        {            tvc.textLabel.text=[s1 objectAtIndex: indexPath.row];
            tvc.detailTextLabel.text=[rr objectAtIndex:indexPath.row];
        }
        else if(indexPath.section ==1)
        {
            
            tvc.textLabel.text=[s2 objectAtIndex: indexPath.row];
            tvc.detailTextLabel.text=[lr objectAtIndex:indexPath.row];
            
        }
    }
    else
    {
     
        
    }
    return  tvc;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
    return 30;
    }
    else
        return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    return 30;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad)
    {
    [cell setBackgroundColor:[UIColor darkGrayColor]];
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
