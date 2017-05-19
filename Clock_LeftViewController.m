//
//  Clock_LeftViewController.m
//  TitanEyePlus
//
//  Created by Admin on 10/9/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import "Clock_LeftViewController.h"
#import "Duo_RightViewController.h"
#import "AppDelegate.h"
#import "Clock_RightViewController.h"
#import "TransitionViewController.h"

@interface Clock_LeftViewController ()

@end

@implementation Clock_LeftViewController
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
-(void)callDuoRightView
{
    [self removeDistanceNotification];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate.transAudioFile = @"duo_left_eye.wav";
    appDelegate.transNib = @"Duo_LeftViewController";
    appDelegate.transTitle = @"DUOCHROME LEFT EYE";
    appDelegate.transPara1 = @"TO TAKE THIS TEST IDEALLY SWITCH OFF THE ROOM LIGHTS. \n\n \
    Cover your Right Eye and please tell us, in which color (Red/ Green) do you find letters are sharper and clearer?\
    \n\n Don’t forget to maintain a distance of 60 cm from the device.";
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
    tvc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
/*
    Duo_RightViewController *controller;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        controller=[[Duo_RightViewController alloc]initWithNibName:@"Duo_RightViewController" bundle:nil];
    } else {
        controller=[[Duo_RightViewController alloc]initWithNibName:@"Duo_RightViewController_iPad" bundle:nil];
    }
    [self presentViewController:controller animated:YES completion:Nil];
 */
    
}
-(IBAction)yes:(id)sender
{
    [self callDuoRightView];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate.leftEyeResult setValue:@"No Astigmatism" forKey:@"clockdial"];

}
-(IBAction)no:(id)sender
{
    [self callDuoRightView];
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

@end
