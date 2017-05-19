//
//  Duo_RightViewController.m
//  TitanEyePlus
//
//  Created by Admin on 10/9/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import "Duo_RightViewController.h"
#import "NVision_R_ViewController.h"
#import"Duo_LeftViewController.h"
#import "AppDelegate.h"
#import "TransitionViewController.h"

@interface Duo_RightViewController ()

@end

@implementation Duo_RightViewController
@synthesize e1,e2,e3,e4,e5,e6,e7,e8;
@synthesize duochrome;
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
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    NSLog(@"%f",screenWidth);
    CGFloat screenHeight = screenRect.size.height;
    CGFloat scale = [[UIScreen mainScreen]scale];
    
    CGFloat imageX=(self.view.bounds.size.width-300)/2;
    // CGFloat imageY=self.view.bounds.size.width
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        
        
        //for iphone 3gs(163 ppi ------ 480-by-320)
        if (screenWidth*scale ==  320 && screenHeight*scale == 480) {
            
            UIImage *duo = [UIImage imageNamed:@"new_red.png"];
            duochrome = [[UIImageView alloc]initWithImage:duo];
            duochrome.frame=CGRectMake(imageX, 190,300 ,170);
            // [duochrome setCenter:self.view.center];
            [self.view addSubview:duochrome];

            
            UIImage   *bgImage = [UIImage imageNamed:@"326ppi_22px_R.png"];
            e1 = [[UIImageView alloc]initWithImage:bgImage];
            e1.frame=CGRectMake(42, 236, 22, 22);
            [self.view addSubview:e1];
            
            
            UIImage   *LImage = [UIImage imageNamed:@"326ppi_22px_L.png"];
            e2 = [[UIImageView alloc]initWithImage:LImage];
            e2.frame=CGRectMake(116, 236, LImage.size.width, LImage.size.height);
            [self.view addSubview:e2];
            
            UIImage   *UImage = [UIImage imageNamed:@"326ppi_22px_T.png"];
            e3 = [[UIImageView alloc]initWithImage:UImage];
            e3.frame=CGRectMake(191, 236, UImage.size.width, UImage.size.height);
            [self.view addSubview:e3];
            
            UIImage   *DImage = [UIImage imageNamed:@"326ppi_22px_B.png"];
            e4 = [[UIImageView alloc]initWithImage:DImage];
            e4.frame=CGRectMake(263, 236, DImage.size.width, DImage.size.height);
            [self.view addSubview:e4];
            
            UIImage   *rImage = [UIImage imageNamed:@"326ppi_17px_R.png"];
            e5 = [[UIImageView alloc]initWithImage:rImage];
            e5.frame=CGRectMake(42, 320, rImage.size.width, rImage.size.height);
            [self.view addSubview:e5];
            
            UIImage   *lImage = [UIImage imageNamed:@"326ppi_17px_L.png"];
            e6 = [[UIImageView alloc]initWithImage:lImage];
            e6.frame=CGRectMake(116, 320, lImage.size.width, lImage.size.height);
            [self.view addSubview:e6];
            
            
            UIImage   *r1Image = [UIImage imageNamed:@"326ppi_17px_R.png"];
            e7 = [[UIImageView alloc]initWithImage:r1Image];
            e7.frame=CGRectMake(191, 320, r1Image.size.width, r1Image.size.height);
            [self.view addSubview:e7];
            
            
            
            UIImage   *l1Image = [UIImage imageNamed:@"326ppi_17px_L.png"];
            e8 = [[UIImageView alloc]initWithImage:l1Image];
            e8.frame=CGRectMake(263, 320, l1Image.size.width, l1Image.size.height);
            [self.view addSubview:e8];
            
        }//for iphone 4,4s,5,5s,5c(326 ppi----- 4,4s-960x640-----5,5s,5c-1136x640)
        else{
//            UIImage *duo = [UIImage imageNamed:@"duo_326.jpg"];
//            duochrome = [[UIImageView alloc]initWithImage:duo];
//            duochrome.frame=CGRectMake(imageX, 220,300 ,136);
//            // [duochrome setCenter:self.view.center];
//            [self.view addSubview:duochrome];
            
            
            UIImage *duo = [UIImage imageNamed:@"new_red.png"];
                       duochrome = [[UIImageView alloc]initWithImage:duo];
                      duochrome.frame=CGRectMake(imageX, 220,300 ,136);
                     // [duochrome setCenter:self.view.center];
                       [self.view addSubview:duochrome];


            UIImage   *bgImage = [UIImage imageNamed:@"326ppi_22px_R.png"];
            e1 = [[UIImageView alloc]initWithImage:bgImage];
            e1.frame=CGRectMake(36, 245, 12, 12);
            [self.view addSubview:e1];
            
            
            UIImage   *LImage = [UIImage imageNamed:@"326ppi_22px_L.png"];
            e2 = [[UIImageView alloc]initWithImage:LImage];
            e2.frame=CGRectMake(122, 245, 12, 12);
            [self.view addSubview:e2];
            
            UIImage   *UImage = [UIImage imageNamed:@"326ppi_22px_T.png"];
            e3 = [[UIImageView alloc]initWithImage:UImage];
            e3.frame=CGRectMake(184, 245, 12, 12);
            [self.view addSubview:e3];
            
            UIImage   *DImage = [UIImage imageNamed:@"326ppi_22px_B.png"];
            e4 = [[UIImageView alloc]initWithImage:DImage];
            e4.frame=CGRectMake(270, 245, 12, 12);
            [self.view addSubview:e4];
            
            UIImage   *rImage = [UIImage imageNamed:@"326ppi_17px_T.png"];
            e5 = [[UIImageView alloc]initWithImage:rImage];
            e5.frame=CGRectMake(36, 324, 8, 8);
            [self.view addSubview:e5];
            
            UIImage   *lImage = [UIImage imageNamed:@"326ppi_17px_B.png"];
            e6 = [[UIImageView alloc]initWithImage:lImage];
            e6.frame=CGRectMake(122, 324, 8, 8);
            [self.view addSubview:e6];
            
            
            UIImage   *r1Image = [UIImage imageNamed:@"326ppi_17px_R.png"];
            e7 = [[UIImageView alloc]initWithImage:r1Image];
            e7.frame=CGRectMake(184, 324, 8, 8);
            [self.view addSubview:e7];
            
            
            
            UIImage   *l1Image = [UIImage imageNamed:@"326ppi_17px_L.png"];
            e8 = [[UIImageView alloc]initWithImage:l1Image];
            e8.frame=CGRectMake(270, 324, 8, 8);
            [self.view addSubview:e8];
        }
    }
    else{
//        UIImage *duo = [UIImage imageNamed:@"new_red.png"];
//        duochrome = [[UIImageView alloc]initWithImage:duo];
//        duochrome.frame=CGRectMake(509, 294,388 ,242);
//        // [duochrome setCenter:self.view.center];
//        [self.view addSubview:duochrome];
        
       

        //for ipad,ipad2(132 ppi -1024-by-768)
        if (screenWidth*scale == 768 && screenHeight*scale == 1024) {
            UIImage *duo = [UIImage imageNamed:@"duo_132.jpg"];
            duochrome = [[UIImageView alloc]initWithImage:duo];
            duochrome.frame=CGRectMake(509, 294,400 ,200);
            // [duochrome setCenter:self.view.center];
            [self.view addSubview:duochrome];
            //still didn't get proper ppi image
//            UIImage   *bgImage = [UIImage imageNamed:@"326ppi_22px_R.png"];
//            e1 = [[UIImageView alloc]initWithImage:bgImage];
//            e1.frame=CGRectMake(547, 345, 10, 10);
//            [self.view addSubview:e1];
//            
//            
//            UIImage   *LImage = [UIImage imageNamed:@"326ppi_22px_L.png"];
//            e2 = [[UIImageView alloc]initWithImage:LImage];
//            e2.frame=CGRectMake(641, 345, 10, 10);
//            [self.view addSubview:e2];
//            
//            UIImage   *UImage = [UIImage imageNamed:@"326ppi_22px_T.png"];
//            e3 = [[UIImageView alloc]initWithImage:UImage];
//            e3.frame=CGRectMake(725, 345, 10, 10);
//            [self.view addSubview:e3];
//            
//            UIImage   *DImage = [UIImage imageNamed:@"326ppi_22px_B.png"];
//            e4 = [[UIImageView alloc]initWithImage:DImage];
//            e4.frame=CGRectMake(844, 345, 10, 10);
//            [self.view addSubview:e4];
//            
//            UIImage   *rImage = [UIImage imageNamed:@"326ppi_17px_R.png"];
//            e5 = [[UIImageView alloc]initWithImage:rImage];
//            e5.frame=CGRectMake(547, 483, 8, 8);
//            [self.view addSubview:e5];
//            
//            UIImage   *lImage = [UIImage imageNamed:@"326ppi_17px_L.png"];
//            e6 = [[UIImageView alloc]initWithImage:lImage];
//            e6.frame=CGRectMake(641, 483, 8, 8);
//            [self.view addSubview:e6];
//            
//            
//            UIImage   *r1Image = [UIImage imageNamed:@"326ppi_17px_R.png"];
//            e7 = [[UIImageView alloc]initWithImage:r1Image];
//            e7.frame=CGRectMake(725, 483, 8, 8);
//            [self.view addSubview:e7];
//            
//            
//            
//            UIImage   *l1Image = [UIImage imageNamed:@"326ppi_17px_L.png"];
//            e8 = [[UIImageView alloc]initWithImage:l1Image];
//            e8.frame=CGRectMake(844, 483, 8, 8);
//            [self.view addSubview:e8];
            
        }
        else{//for iPad3,4,iPad Air(264 ppi----2048-by-1536)
            UIImage *duo = [UIImage imageNamed:@"duo_264.jpg"];
            duochrome = [[UIImageView alloc]initWithImage:duo];
            duochrome.frame=CGRectMake(509, 294,400 ,200);
            // [duochrome setCenter:self.view.center];
            [self.view addSubview:duochrome];
            
//            UIImage   *bgImage = [UIImage imageNamed:@"326ppi_22px_R.png"];
//            e1 = [[UIImageView alloc]initWithImage:bgImage];
//            e1.frame=CGRectMake(547, 345, 10, 10);
//            [self.view addSubview:e1];
//            
//            
//            UIImage   *LImage = [UIImage imageNamed:@"326ppi_22px_L.png"];
//            e2 = [[UIImageView alloc]initWithImage:LImage];
//            e2.frame=CGRectMake(641, 345, 10, 10);
//            [self.view addSubview:e2];
//            
//            UIImage   *UImage = [UIImage imageNamed:@"326ppi_22px_T.png"];
//            e3 = [[UIImageView alloc]initWithImage:UImage];
//            e3.frame=CGRectMake(725, 345, 10, 10);
//            [self.view addSubview:e3];
//            
//            UIImage   *DImage = [UIImage imageNamed:@"326ppi_22px_B.png"];
//            e4 = [[UIImageView alloc]initWithImage:DImage];
//            e4.frame=CGRectMake(844, 345, 10, 10);
//            [self.view addSubview:e4];
//            
//            UIImage   *rImage = [UIImage imageNamed:@"326ppi_17px_R.png"];
//            e5 = [[UIImageView alloc]initWithImage:rImage];
//            e5.frame=CGRectMake(547, 483, 8, 8);
//            [self.view addSubview:e5];
//            
//            UIImage   *lImage = [UIImage imageNamed:@"326ppi_17px_L.png"];
//            e6 = [[UIImageView alloc]initWithImage:lImage];
//            e6.frame=CGRectMake(641, 483, 8, 8);
//            [self.view addSubview:e6];
//            
//            
//            UIImage   *r1Image = [UIImage imageNamed:@"326ppi_17px_R.png"];
//            e7 = [[UIImageView alloc]initWithImage:r1Image];
//            e7.frame=CGRectMake(725, 483, 8, 8);
//            [self.view addSubview:e7];
//            
//            
//            
//            UIImage   *l1Image = [UIImage imageNamed:@"326ppi_17px_L.png"];
//            e8 = [[UIImageView alloc]initWithImage:l1Image];
//            e8.frame=CGRectMake(844, 483, 8, 8);
//            [self.view addSubview:e8];
        }
        
        
    }


    [super viewDidLoad];
    [self observeDistanceNotification];

    // Do any additional setup after loading the view from its nib.
}
-(void)callDuoLeftView{
    [self removeDistanceNotification];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate.transAudioFile = @"etest_right_eye.wav";
    appDelegate.transNib = @"RE_1_ViewController";
    appDelegate.transTitle = @"EXAMINE YOUR LEFT EYE";
    appDelegate.transPara1 = @"Please cover your Right Eye and Select the direction arrow according to the direction of letter E \
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
    /*
    Duo_LeftViewController  *controller;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        controller=[[Duo_LeftViewController alloc]initWithNibName:@"Duo_LeftViewController" bundle:nil];
    } else {
        controller=[[Duo_LeftViewController alloc]initWithNibName:@"Duo_LeftViewController_iPad" bundle:nil];
    }
    [self presentViewController:controller animated:YES completion:Nil];
     */
    
}

-(IBAction)green:(id)sender
{
    [self callDuoLeftView];
    
}

-(IBAction)red:(id)sender
{
    [self callDuoLeftView];
  
}

-(IBAction)equal:(id)sender
{
    [self callDuoLeftView];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate.rightEyeResult setValue:@"Normal Vision" forKey:@"duochrome"];

    
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
        //bulb.image =  [[userInfo valueForKey:@"textcolor"]isEqualToString:@"green"]?[UIImage imageNamed:@"bulb_g.jpg"]:[UIImage imageNamed:@"bulb_s.jpg"];
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
