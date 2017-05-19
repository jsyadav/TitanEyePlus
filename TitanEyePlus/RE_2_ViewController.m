//
//  RE_2_ViewController.m
//  TitanEyePlus
//
//  Created by Admin on 10/8/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import "RE_2_ViewController.h"
#import "RE_3_ViewController.h"
#import "LE_1_ViewController.h"
#import "Clock_RightViewController.h"
#import "AppDelegate.h"
#import "TransitionViewController.h"

@interface RE_2_ViewController ()


@end

@implementation RE_2_ViewController
@synthesize image;
@synthesize curInd,ans;
@synthesize upBtn,downBtn,leftBtn,rightBtn;
@synthesize previousArrow;
@synthesize eDirection;
@synthesize eDictionary;
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
-(void)viewDidLoad{
    
    [super viewDidLoad];
    	[self observeDistanceNotification];
    
    
    //for e rotation logic
    curInd = 0;
    ans = 0;
    
    /*-----------for shuffle E direction array------------*/
    eDirection = [[NSMutableArray alloc]init];
    eDirection = [self shuffle];
    eDictionary = @{@"R":@0,@"B":@90,@"L":@180,@"T":@270};
    
    /*-----------physical size of device screen------------*/
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    //view size
    CGFloat arrowX;
    CGFloat arrowY;
    CGFloat aw;
    CGFloat ah ;
    CGFloat arrowDis;
    
    CGRect tRect;
    CGRect rRect;
    CGRect bRect;
    CGRect lRect;
    CGFloat eX,eY;
    CGFloat scale = [[UIScreen mainScreen]scale];

    
    
    //view size
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        aw = 30;
        ah = 30;
        eX=self.view.bounds.size.width/2;
        eY=(self.view.bounds.size.height-168)/2+168;
        arrowX    =   eX-(aw/2);
        arrowY    =   eY-(ah/2);
        aw = 30;
        ah = 30;
        arrowDis  =   80;
        
        tRect=CGRectMake(arrowX, arrowY-arrowDis, aw, ah);
        rRect=CGRectMake(arrowX+arrowDis, arrowY, aw, ah);
        bRect=CGRectMake(arrowX,arrowY+arrowDis, aw, ah);
        lRect=CGRectMake(arrowX-arrowDis, arrowY, aw, ah);
        
        
        
    }
    else
    {
        NSLog(@"width %f",self.view.bounds.size.width);
        arrowX    =   (self.view.bounds.size.width-381)/2-20;
        arrowY    = (self.view.bounds.size.height-193)/2-20+193;
        aw = 40;
        ah = 40;
        arrowDis  =   120;
        
        eX= (self.view.bounds.size.width-381)/2;
        eY = (self.view.bounds.size.height-193)/2+193;
        
        tRect=CGRectMake(arrowX, arrowY-arrowDis, aw, ah);
        rRect=CGRectMake(arrowX+arrowDis, arrowY, aw, ah);
        bRect=CGRectMake(arrowX,arrowY+arrowDis, aw, ah);
        lRect=CGRectMake(arrowX-arrowDis, arrowY, aw, ah);
        
        
    }
    
    
    
    //for - top -arrow
    upBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [upBtn setTag:3];
    UIImage * upImage = [UIImage imageNamed:@"grey_arrow_T.jpg"];
    [upBtn setBackgroundImage:upImage forState:UIControlStateNormal];
    [upBtn addTarget:self action:@selector(upArrow:) forControlEvents:UIControlEventTouchUpInside];
    upBtn.frame=tRect;
    [self.view addSubview:upBtn];
    
    //for - right - arrow
    rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rightBtn setTag:0];
    UIImage * rightImage = [UIImage imageNamed:@"grey_arrow_R.jpg"];
    [rightBtn setBackgroundImage:rightImage forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightArrow:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame=rRect;
    [self.view addSubview:rightBtn];
    
    //for- down - arrow
    downBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [downBtn setTag:1];
    UIImage * downImage = [UIImage imageNamed:@"grey_arrow_B.jpg"];    [downBtn setBackgroundImage:downImage forState:UIControlStateNormal];
    [downBtn addTarget:self action:@selector(downArrow:) forControlEvents:UIControlEventTouchUpInside];
    downBtn.frame=bRect;
    [self.view addSubview:downBtn];
    
    //for - left -arrow
    leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [leftBtn setTag:2];
    UIImage * leftImage = [UIImage imageNamed:@"grey_arrow_L.jpg"];
    [leftBtn setBackgroundImage:leftImage forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftArrow:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame=lRect;
    [self.view addSubview:leftBtn];
    //placing E
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        CGFloat ivhw    =   8;

        //for iphone 3gs(163 ppi ------ 480-by-320)
        if (screenWidth*scale ==  320 && screenHeight*scale == 480) {
            UIImage   *bgImage = [UIImage imageNamed:@"163ppi_8px_R.png"];
            image = [[UIImageView alloc]initWithImage:bgImage];
            image.frame=CGRectMake(truncf(eX-ivhw/2),truncf(eY-ivhw/2) ,ivhw,ivhw);
            
//            image.frame=CGRectMake(0.0, 0.0, 8,8);
//            [image setCenter:self.view.center];
            [self.view addSubview:image];
            
            
        }//for iphone 4,4s,5,5s,5c(326 ppi----- 4,4s-960x640-----5,5s,5c-1136x640)
        else{
         //   UIImage   *bgImage = [UIImage imageNamed:@"326ppi_17px_R.png"];
          
            UIImage   *bgImage = [UIImage imageNamed:@"326ppi_22px_R.png"];
            image = [[UIImageView alloc]initWithImage:bgImage];
           // image.frame=CGRectMake(0.0, 0.0, 8,8);
            //image.frame=CGRectMake(0.0, 0.0, 17,17);
           // [image setCenter:self.view.center];
            image.frame=CGRectMake(truncf(eX-ivhw/2),truncf(eY-ivhw/2) ,ivhw,ivhw);
            
            [self.view addSubview:image];
        }
    }
    else{
        //for ipad,ipad2(132 ppi -1024-by-768)
        if (screenWidth*scale == 768 && screenHeight*scale == 1024) {
            //still didn't get proper ppi image
            UIImage   *bgImage = [UIImage imageNamed:@"132ppi_7px_R.png"];
            image = [[UIImageView alloc]initWithImage:bgImage];
            image.frame=CGRectMake(truncf(eX), truncf(eY), 7,7);

                       [self.view addSubview:image];
            
        }
        else{//for iPad3,4,iPad Air(264 ppi----2048-by-1536)
            UIImage   *bgImage = [UIImage imageNamed:@"264ppi_20px_R_new.png"];
            image = [[UIImageView alloc]initWithImage:bgImage];
            //image.frame=CGRectMake(truncf(eX), truncf(eY), 15,15);
            image.frame=CGRectMake(truncf(eX), truncf(eY), 8,8);
            [self.view addSubview:image];
            
        }
        
        
    }
    //initial rotation of E, as per random shuffle
    if(![[eDirection objectAtIndex:0]isEqualToString:@"R"]){
        [self rotate:[self rotationDegree:[eDirection objectAtIndex:0]]];
    }
    
    
    
}
-(void)rotate:(int)degree

{
    CGAffineTransform transform = CGAffineTransformMakeRotation(degree * M_PI/180);
    image.transform = transform;
    
}
-(NSMutableArray *)shuffle{
    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:@"R",@"B",@"L",@"T",nil];
    NSInteger count = [array count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = arc4random_uniform(nElements) + i;
        [array exchangeObjectAtIndex:i withObjectAtIndex:n];
        
    }
    return array;
}
-(void)eLogic:(NSString *)directions{
    //Result calculation
    if([[eDirection objectAtIndex:curInd]isEqualToString:directions]){//if answer is correct
        ans++;
    }
    curInd++;
    NSLog(@"ans-%i---curInd%i",ans,curInd);
    if(ans>=curInd-1){
        if(curInd < 4){
            //e-rotation
            [self rotate:[self rotationDegree:[eDirection objectAtIndex:curInd]]];
        }
        else{//if 4 th arrow click
          //  [session stopRunning];
            [self removeDistanceNotification];
            RE_3_ViewController *controller1;
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                controller1=[[RE_3_ViewController alloc]initWithNibName:@"RE_3_ViewController" bundle:nil];
                
            } else {
                controller1=[[RE_3_ViewController alloc]initWithNibName:@"RE_3_ViewController_iPad" bundle:nil];
            }
            [self presentViewController:controller1 animated:YES completion:nil];
        }
        
    }
    else{//if two answers are wrong
       // [session stopRunning];
        [self removeDistanceNotification];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        appDelegate.transAudioFile = @"clock_left_eye.wav";
        appDelegate.transNib = @"Clock_LeftViewController";
        appDelegate.transTitle = @"CLOCK DIAL LEFT EYE";
        appDelegate.transPara1 = @"Cover your Right Eye and look at these lines and check if all lines appear equally dark? Answer is Yes / No. \n\n Request you to keep your device at a 60cm distance while taking the test.";
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
        Clock_RightViewController *controller;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            controller =[[Clock_RightViewController alloc]initWithNibName:@"Clock_RightViewController" bundle:nil];
            
        } else {
            controller =[[Clock_RightViewController alloc]initWithNibName:@"Clock_RightViewController_ipad" bundle:nil];
            
        }
        
        [self presentViewController:controller animated:YES completion:nil];
 */
    }
    
    
    
    
    
}
-(int)rotationDegree:(NSString *)direction{
    NSString *s = [NSString stringWithFormat:@"%@",[eDictionary valueForKey:direction]];
    return [s intValue];
}

-(void)rightArrow:(id)sender
{
    [self changeArrowColor:[sender tag]];
    [self eLogic:@"R"];
}


-(void)downArrow:(id)sender
{
    [self changeArrowColor:[sender tag]];
    [self eLogic:@"B"];
    
}
-(void)leftArrow:(id)sender
{
    [self changeArrowColor:[sender tag]];
    [self eLogic:@"L"];
}
-(void)upArrow:(id)sender
{
    [self changeArrowColor:[sender tag]];
    [self eLogic:@"T"];
}


-(void)changeArrowColor:(int)currentDir{
    
    [self changePreviousArrow];
    [self changeCurrentArrow:currentDir];
    
    
}
-(void)changePreviousArrow{
    //previousArrow 0-right,1-down,2-left,3-top
    switch ([self previousArrow]) {
        case 0:{
            UIImage *ga = [UIImage imageNamed:@"grey_arrow_R.jpg"];
            [rightBtn setBackgroundImage:ga forState:UIControlStateNormal];
            break;
        }
        case 1:{
            UIImage *ga = [UIImage imageNamed:@"grey_arrow_B.jpg"];
            [downBtn setBackgroundImage:ga forState:UIControlStateNormal];
            break;
        }
        case 2:{
            UIImage *ga = [UIImage imageNamed:@"grey_arrow_L.jpg"];
            [leftBtn setBackgroundImage:ga forState:UIControlStateNormal];
            break;
        }
        default:{
            UIImage *ga = [UIImage imageNamed:@"grey_arrow_T.jpg"];
            [upBtn setBackgroundImage:ga forState:UIControlStateNormal];
            break;
        }
    }
}
-(void)changeCurrentArrow:(int)direction{
    //direction 0-right,1-down,2-left,3-top
    switch (direction) {
        case 0:{
            UIImage *oa = [UIImage imageNamed:@"orange_arrow_R.jpg"];
            [rightBtn setBackgroundImage:oa forState:UIControlStateNormal];
            [self setPreviousArrow:0];
            break;
        }
        case 1:{
            UIImage *oa = [UIImage imageNamed:@"orange_arrow_B.jpg"];
            [downBtn setBackgroundImage:oa forState:UIControlStateNormal];
            [self setPreviousArrow:1];
            break;
        }
        case 2:{
            UIImage *oa = [UIImage imageNamed:@"orange_arrow_L.jpg"];
            [leftBtn setBackgroundImage:oa forState:UIControlStateNormal];
            [self setPreviousArrow:2];
            break;
        }
        default:{
            UIImage *oa = [UIImage imageNamed:@"orange_arrow_T.jpg"];
            [upBtn setBackgroundImage:oa forState:UIControlStateNormal];
            [self setPreviousArrow:3];
            break;
        }
    }
    
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
