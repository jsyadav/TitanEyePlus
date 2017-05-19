//
//  InstructionViewController.m
//  TitanEyePlus
//
//  Created by Admin on 9/11/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import "InstructionViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "RE_1_ViewController.h"
#import "LE_1_ViewController.h"
#import "SquareCamViewController.h"
#import "TransitionViewController.h"

@interface InstructionViewController ()

@end

@implementation InstructionViewController
@synthesize  welcome,age,click,resolution,instruction;

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

    //For Instruction in webview
    
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    
    welcome.text=[ appDelegate.userInfo valueForKey:@"name"];
    age.text=[appDelegate.userInfo valueForKey:@"age"];

    
    
    NSLog(@"PassingString==>%@",appDelegate.passingName);
    NSLog(@"PassingString==>%@",appDelegate.passingAge);


    [instructionview setEditable:NO];
    [resolutionview setEditable:NO];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(IBAction)next:(id)sender
{
//    SquareCamViewController *facedetector;
//    facedetector =[[SquareCamViewController alloc]initWithNibName:@"SquareCamViewController" bundle:nil];
//    [self presentViewController:facedetector animated:YES completion:nil];
    /*
    LE_1_ViewController *leftview;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        leftview =[[LE_1_ViewController alloc]initWithNibName:@"LE_1_ViewController" bundle:nil];
    }
    else{
        leftview=[[LE_1_ViewController alloc]initWithNibName:@"LE_1_ViewController_iPad" bundle:nil];
    }

    [self presentViewController:leftview animated:YES completion:nil];
    */
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate.transAudioFile = @"etest_right_eye.wav";
    appDelegate.transNib = @"LE_1_ViewController";
    appDelegate.transTitle = @"EXAMINE YOUR RIGHT EYE";
    appDelegate.transPara1 = @"Please cover your Left Eye and Select the direction arrow according to the direction of letter E \
    (direction of the 3 arms of letter E like whether it is facing left, right, up or down)\
    at each letter size. \n\n Request you to keep your device at a 60cm distance while taking the test";
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
