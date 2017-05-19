//
//  ViewController.m
//  TitanEyePlus
//
//  Created by Admin on 9/4/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import "ViewController.h"
#import "InstructionViewController.h"
#import"AppDelegate.h"
#import "ValidationController.h"
#import "ResultViewController.h"
#define contains(str1, str2) ([str1 rangeOfString: str2 ].location != NSNotFound)
@class AppDelegate;


@interface ViewController ()

@end

@implementation ViewController
@synthesize label,label1,label2,label3;
@synthesize name,age,mobile,email;
@synthesize logo,fblogin;
//@synthesize smscode;
@synthesize spinner;


- (void)viewDidLoad
{
    
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

    
      appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     //fot textview not to edit
    [message setEditable:NO];
    
    //fblogout button
    
    
        [self.name setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.age setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.email setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.mobile setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];

    
      
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //DEVICE INFORMATION
    CGFloat scale = [[UIScreen mainScreen]scale];
    CGFloat screenWidth=self.view.bounds.size.width*scale;
    CGFloat screenHeight=self.view.bounds.size.height*scale;
    
    NSLog(@"%f,%f,%f",screenWidth,screenHeight,scale);

    
    NSLog(@" Model is %@",[UIDevice currentDevice].model);
    NSLog(@" description is %@",[UIDevice currentDevice].description);
    NSLog(@" LM is %@",[UIDevice currentDevice].localizedModel);
    NSLog(@" Name is %@",[UIDevice currentDevice].name);
    NSLog(@" System version is %@",[UIDevice currentDevice].systemVersion);
    NSLog(@" sys Name is %@",[UIDevice currentDevice].systemName);
    NSLog(@" Battery level is %f",[UIDevice currentDevice].batteryLevel);
    NSLog(@"vendor is  %@",[UIDevice currentDevice].identifierForVendor);
    
}

-(void)orientationChanged:(NSNotification *)notification
{

        [name becomeFirstResponder];
        [name resignFirstResponder];

}


- (BOOL)prefersStatusBarHidden {
    return YES;
}
//#for UItextview kwyboard dismissing


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}

//Hiding status bar



//Dismissing the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
    {
        
    [textField resignFirstResponder];
            return YES;
    }

//Hiding the numeric keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [age resignFirstResponder];
    [mobile resignFirstResponder];
}


//Entering limited characters in UItextfield for Age
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==age) {
        
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength>2) ? NO : YES;
    }
    if (textField==mobile) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength>10) ? NO : YES;
    }
    
    return YES;
    
}


//For moving the view up while keyboard pops up

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
 
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





-(IBAction)starttest:(id)sender
{   //for internet checking

/*
 //for production
    if (  [self networkCheck]) {

    NSString *emailcheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailcheck];
    if ([name.text length] == 0) {
        UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter the name"
                                                       delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([email.text length]==0)
    {
        UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter the Email"
                                                       delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
   else if ([age.text length]==0)
    {
        UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter the Age"
                                                       delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        
        
    }
    else if ([mobile.text length]==0)
    {
        UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter the Mobile No"
                                                       delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];

        
    }
    else if ([mobile.text length]<10)
    {
        UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter a valid Mobile No"
                                                       delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
  
    }
    
    else if ([emailTest evaluateWithObject:email.text] == NO)
        
    {
        UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter a valid Email ID"
                                                       delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        
        
    }

    else
    {
        int randomNumber = (arc4random() % 9000) + 1000;
        NSString *smscode = [NSString stringWithFormat:@"%i",randomNumber];

  appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
  appDelegate.userInfo=[[NSMutableDictionary alloc]init];
  [ appDelegate.userInfo setValue:name.text forKey:@"name"];
  [appDelegate.userInfo setValue:age.text forKey:@"age"];
  [appDelegate.userInfo setValue:mobile.text forKey:@"mobile"];
  [appDelegate.userInfo setValue:email.text forKey:@"email"];
  [appDelegate.userInfo setValue:smscode forKey:@"code"];

        //sending code via sms
        
        NSString *tonumber=mobile.text;
        NSString *greeting=[NSString stringWithFormat:@"http://alerts.sinfini.com/api/web2sms.php?workingkey=502a9219e5a2n9f4da1&sender=TITANE&to=%@&message=Thank%%20you%%20for%%20taking%%20Titan%%20Eye%%20plus%%20Online%%20Eye%%20test.%%20Please%%20enter%%20the%%20verification%%20code:%%20%@%%20.%%20Please%%20retain%%20this%%20authorisation%%20code%%20to%%20avail%%20discounts",tonumber,smscode];
        
        
        NSLog(@"%@",greeting);
        NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:greeting]];
        NSURLResponse * response = nil;
        NSError * error = nil;
        
        //spinner
        spinner = [[UIActivityIndicatorView alloc] init];
        spinner.color = [UIColor orangeColor];
        [spinner setCenter:CGPointMake(self.view.bounds.size.width/2,self.view.bounds.size.height/2)];
        [self.view addSubview:spinner]; // spinner is not visible until started
        // [spinner startAnimating];
        
        
        NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                              returningResponse:&response
                                                          error:&error];
        //[spinner stopAnimating];
        if (error == nil)
        {
            
            NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            //if mobile number is invalid
            if(contains(myString,@"Invalid"))
            {//contains is a macro defined in header
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Invalid Mobile Number" message:@"Please Enter Valid Number" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                NSLog(@"response %@",myString);
            }
            else
            {
                
                //Moving to next view
                ValidationController *controller;
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                    controller =[[ValidationController alloc]initWithNibName:@"ValidationController" bundle:nil];
                }
                else{
                    controller=[[ValidationController alloc]initWithNibName:@"ValidationController_iPad" bundle:nil];
                }
                controller.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
                appDelegate.passingName=name.text;
                appDelegate.passingAge=age.text;
                controller.forcode=[NSString stringWithFormat:@"%@",smscode];
                [self presentViewController:controller animated:YES completion:nil];
            }
            
            
            
        }
        else{
            NSLog(@"ERROR");
        }

       
        
       
       
    }
    }
    else
    {
        UIAlertView *connectionAlert = [[UIAlertView alloc] init];
        [connectionAlert setTitle:@"Error"];
        [connectionAlert setMessage:@"Please check your network conenction."];
        [connectionAlert setDelegate:self];
        [connectionAlert setTag:1];
        [connectionAlert addButtonWithTitle:@"Back"];
        [connectionAlert show];
        
        NSLog(@"NETWORKCHECK: Not Connected");
        
        
    }
  
 
 //for production
 
 */


    //for testing
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate.userInfo=[[NSMutableDictionary alloc]init];
    [ appDelegate.userInfo setValue:name.text forKey:@"name"];
    [appDelegate.userInfo setValue:age.text forKey:@"age"];
    [appDelegate.userInfo setValue:mobile.text forKey:@"mobile"];
    [appDelegate.userInfo setValue:email.text forKey:@"email"];
    
    
//    LE_1_ViewController *controller;
//        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//            controller =[[LE_1_ViewController alloc]initWithNibName:@"LE_1_ViewController" bundle:nil];
//        }
//        else{
//            controller=[[LE_1_ViewController alloc]initWithNibName:@"LE_1_ViewController_iPad" bundle:nil];
//        }
//        controller.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
//        [self presentViewController:controller animated:YES completion:nil];
    
//    ResultViewController *controller;
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        controller =[[ResultViewController alloc]initWithNibName:@"ResultViewController" bundle:nil];
//    }
//    else{
//        controller=[[ResultViewController alloc]initWithNibName:@"ResultViewController_iPad" bundle:nil];
//    }
//    controller.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
//    [self presentViewController:controller animated:YES completion:nil];
 
    
    ValidationController *controller;
    
   if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        controller =[[ValidationController alloc]initWithNibName:@"ValidationController" bundle:nil];
    }
    else{
        controller=[[ValidationController alloc]initWithNibName:@"ValidationController_iPad" bundle:nil];
    }
    
   controller.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];


    
}
 - (BOOL)networkCheck
{
    Reachability *curReach = [Reachability reachabilityForInternetConnection] ;
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (netStatus==NotReachable) {
        return  FALSE;
    }
    else
    {
        return TRUE;
    }
}

//FOR FACEBOOK LOGIN

-(IBAction)fblogin:(id)sender
{
    [self.spinner startAnimating];
    [self openSession];
    
}

-(void)logoutButtonWasPressed:(id)sender {
    [FBSession.activeSession closeAndClearTokenInformation];
}

- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here, but
    // stop the spinner.
    [self.spinner stopAnimating];
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    
    switch (state) {
        case FBSessionStateOpen:
        {
            
            
            [[FBRequest requestForMe] startWithCompletionHandler:
             ^(FBRequestConnection *connection,
               NSDictionary<FBGraphUser> *user,
               NSError *error) {
                 if (error) {
                     //error
                 }else{
                     name.text=user.name;
                     email.text=[user objectForKey:@"email"];
                     age.text = [NSString stringWithFormat:@"%i",[self calculateAge:[user objectForKey:@"birthday"]]];
                     NSLog(@"name :%@",user.name);
                     NSLog(@"email is :%@",[user objectForKey:@"email"]);
                     
                 }
             }];
            
            
        }
            
            break;
        case FBSessionStateClosed:
        {
            
            
            [FBSession.activeSession closeAndClearTokenInformation];
            
            NSLog(@"fblogout");
        }
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            
            [FBSession.activeSession closeAndClearTokenInformation];
          
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }

}




-(NSInteger)calculateAge:(NSString *)dob{
    NSArray *dobArray = [dob componentsSeparatedByString:@"/"];
    NSString *formatedDob = [NSString stringWithFormat:@"%@-%@-%@",[dobArray objectAtIndex:2],[dobArray objectAtIndex:0],[dobArray objectAtIndex:1]];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateOfBirth=[format dateFromString:formatedDob];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponentsNow = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *dateComponentsBirth = [calendar components:unitFlags fromDate:dateOfBirth];
    
    if (([dateComponentsNow month] < [dateComponentsBirth month]) ||
        (([dateComponentsNow month] == [dateComponentsBirth month]) && ([dateComponentsNow day] < [dateComponentsBirth day]))) {
        return [dateComponentsNow year] - [dateComponentsBirth year] - 1;
    } else {
        return [dateComponentsNow year] - [dateComponentsBirth year];
    }
    
}
-(void)fetchUserDetails{
    [[FBRequest requestForMe] startWithCompletionHandler:
     ^(FBRequestConnection *connection,
       NSDictionary<FBGraphUser> *user,
       NSError *error) {
         if (error) {
             //error
         }else{
             name.text=user.name;
             email.text=[user objectForKey:@"email"];
             age.text=[NSString stringWithFormat:@"%i",[self calculateAge:[user objectForKey:@"birthday"]]];
             NSLog(@"name :%@",user.name);
             NSLog(@"email is :%@",[user objectForKey:@"email"]);
         }
     }];
    
}



- (void)openSession
{
   
     if([[FBSession activeSession] isOpen] == NO){
    [FBSession openActiveSessionWithReadPermissions:@[@"basic_info",@"user_birthday",@"email"]
     
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
         
         NSLog(@"fb session opened");
         
         
     }];
     }
         else
         {
             NSLog(@"already session is opened");
             [self fetchUserDetails];
         }
  

    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

