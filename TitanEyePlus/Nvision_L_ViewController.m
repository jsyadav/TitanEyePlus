//
//  Nvision_L_ViewController.m
//  TitanEyePlus
//
//  Created by Admin on 10/9/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import "Nvision_L_ViewController.h"
#import "ResultViewController.h"
#import "AppDelegate.h"

@interface Nvision_L_ViewController ()

@end

@implementation Nvision_L_ViewController
@synthesize dlabel;
@synthesize bulb;
@synthesize slider;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)N1:(id)sender
{
    [self callResultView];
    
    
}
-(IBAction)N2:(id)sender
{
    [self callResultView];
    
}
-(IBAction)N3:(id)sender
{
    [self callResultView];
    
}
-(IBAction)N4:(id)sender
{
    [self callResultView];
    
}
-(IBAction)N5:(id)sender
{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate.leftEyeResult setValue:@"Normal" forKey:@"nearvision"];
    NSLog(@"lefteye nearvision:%@",[appDelegate.leftEyeResult valueForKey:@"nearvision"]);
    [self callResultView];
    
}
-(void)callResultView
{
    [self removeDistanceNotification];

    ResultViewController  *controller;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if([ [ UIScreen mainScreen ] bounds ].size.height == 568){
          controller=[[ResultViewController alloc]initWithNibName:@"ResultViewController_4inch" bundle:nil];
        }
        else
        controller=[[ResultViewController alloc]initWithNibName:@"ResultViewController_3inch" bundle:nil];
    } else {
        controller=[[ResultViewController alloc]initWithNibName:@"ResultviewController_ipad" bundle:nil];
    }
    [self presentViewController:controller animated:YES completion:Nil];
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
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

    [super viewDidLoad];
    [self observeDistanceNotification];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark DistanceMeter
-(void)observeDistanceNotification{
    [[NSNotificationCenter defaultCenter]
     
     addObserver:self
     
     selector:@selector(distanceMeterNotificationHandler:)
     
     name:@"DistanceMeterNotification"
     
     object:nil];
}
-(void)removeDistanceNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DistanceMeterNotification" object:nil];
    [self stopSession];
    
    
}
-(void)distanceMeterNotificationHandler:(NSNotification*)notification{
    NSLog(@"DistanceMeterNotificationreceived:%@",[notification.userInfo valueForKey:@"distance"]);
    NSDictionary *userInfo = [notification userInfo];
    if([userInfo valueForKey:@"distance"]){
       // bulb.image =  [[userInfo valueForKey:@"textcolor"]isEqualToString:@"green"]?[UIImage imageNamed:@"bulb_g.jpg"]:[UIImage imageNamed:@"bulb_s.jpg"];
        //[dlabel setText:[notification.userInfo valueForKey:@"distance"]];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        float dist = appDelegate.distance;
        [slider setValue:dist*48/48];
        if (dist == 24){
            [dlabel setText:@"Perfect Distance"];
        }else {
            [dlabel setText:@"Look AT Device"];
        }
 
        
    }
    else{
        bulb.image = [UIImage imageNamed:@"bulb_s.jpg"];
        [dlabel setText:@"Look The Device"];
    }
    
}

#pragma - mark StopSession
-(void)stopSession{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DistanceCalculationFinishedNotification"
                                                       object:nil
                                                     userInfo:nil];
}
@end
