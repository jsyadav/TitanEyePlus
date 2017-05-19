//
//  Clock_RightViewController.m
//  TitanEyePlus
//
//  Created by Admin on 10/9/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import "Clock_RightViewController.h"
#import "Clock_LeftViewController.h"
#import "AppDelegate.h"
#import "TransitionViewController.h"

@interface Clock_RightViewController ()

@end

@implementation Clock_RightViewController
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
-(IBAction)yes:(id)sender
{
    [self callClockLeftView];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate.rightEyeResult setValue:@"No Astigmatism" forKey:@"clockdial"];


}
-(IBAction)no:(id)sender
{
    [self callClockLeftView];

}
-(void)callClockLeftView
{
    [self removeDistanceNotification];
/*
    Clock_LeftViewController *controller =[[Clock_LeftViewController alloc]initWithNibName:@"Clock_LeftViewController" bundle:nil];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        controller=[[Clock_LeftViewController alloc]initWithNibName:@"Clock_LeftViewController" bundle:nil];
    } else {
         controller=[[Clock_LeftViewController alloc]initWithNibName:@"Clock_LeftViewController_iPad" bundle:nil];
    }
    [self presentViewController:controller animated:YES completion:Nil];
 */
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate.transAudioFile = @"duo_right_eye.wav";
    appDelegate.transNib = @"Duo_RightViewController";
    appDelegate.transTitle = @"DUOCHROME RIGHT EYE";
    appDelegate.transPara1 = @"TO TAKE THIS TEST IDEALLY SWITCH OFF THE ROOM LIGHTS. \n\n \
    Cover your Left Eye and please tell us, in which color (Red/ Green) do you find letters are sharper and clearer?\
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
