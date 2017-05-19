//
//  TestAgainViewController.m
//  TitanEyePlus
//
//  Created by Admin on 11/13/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import "TestAgainViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface TestAgainViewController ()

@end

@implementation TestAgainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
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

    
       if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")) {
            greetings.textAlignment=NSTextAlignmentJustified;
    
      }
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone)
        self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"Back-image_new.jpg"]];
    
    
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    name.text=appDelegate.passingName;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(IBAction)website:(id)sender
{
    NSURL *url = [ [ NSURL alloc ] initWithString: @"http://titaneyeplus.com/product_services.aspx"];
    
    [[UIApplication sharedApplication] openURL:url];
}
-(IBAction)exit:(id)sender
{
       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Double-click the Home button. Swipe left or right until you have located the app you wish to close. Swipe the app's preview up to close it." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
       [alert show];
}

-(IBAction)takeTestAgain:(id)sender
{
    ViewController *controller;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        controller=[[ViewController alloc]initWithNibName:@"ViewController_iPhone" bundle:nil];
    }
    else{
      controller=[[ViewController alloc]initWithNibName:@"ViewController_iPad" bundle:nil];
    }
    [self presentViewController:controller animated:NO completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
