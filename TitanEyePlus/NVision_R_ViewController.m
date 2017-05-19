//
//  NVision_R_ViewController.m
//  TitanEyePlus
//
//  Created by Admin on 10/9/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import "NVision_R_ViewController.h"
#import "Nvision_L_ViewController.h"
#import "AppDelegate.h"
#import "TransitionViewController.h"

@interface NVision_R_ViewController ()

@end

@implementation NVision_R_ViewController
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
-(IBAction)N1:(id)sender
{
    [self callNVisionLeftView];
    
}
-(void)callNVisionLeftView
{
    [self removeDistanceNotification];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate.transAudioFile = @"Near_left.wav";
    appDelegate.transNib = @"Nvision_L_ViewController";
    appDelegate.transTitle = @"NEAR VISION LEFT EYE";
    appDelegate.transPara1 = @"Cover your Right Eye and read with your Left Eye. \
    Then click on the size of the text which you cannot read.\n\n \
    Be at a distance of 40 cm from the device while taking this test.";
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

    Nvision_L_ViewController  *controller;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        controller=[[Nvision_L_ViewController alloc]initWithNibName:@"Nvision_L_ViewController" bundle:nil];
    } else {
        controller=[[Nvision_L_ViewController alloc]initWithNibName:@"Nvision_L_ViewController_ipad" bundle:nil];
    }
    [self presentViewController:controller animated:YES completion:Nil];
     */
    
}

-(IBAction)N2:(id)sender
{
    [self callNVisionLeftView];

}
-(IBAction)N3:(id)sender
{
    [self callNVisionLeftView];
    

}
-(IBAction)N4:(id)sender
{
    [self callNVisionLeftView];
    
}
-(IBAction)N5:(id)sender
{
    [self callNVisionLeftView];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate.rightEyeResult setValue:@"Normal" forKey:@"nearvision"];
    NSLog(@"answer is %@", [appDelegate.rightEyeResult valueForKey:@"nearvision"]);


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
        bulb.image =  [[userInfo valueForKey:@"textcolor"]isEqualToString:@"green"]?[UIImage imageNamed:@"bulb_g.jpg"]:[UIImage imageNamed:@"bulb_s.jpg"];
        [dlabel setText:[notification.userInfo valueForKey:@"distance"]];
        
        
    }
    else{
        bulb.image = [UIImage imageNamed:@"bulb_s.jpg"];
        [dlabel setText:@"Look The Device"];
    }
    
}

@end
