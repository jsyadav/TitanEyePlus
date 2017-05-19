//
//  TransitionViewController.m
//  TitanEyePlus
//
//  Created by Jitendra Yadav MB on 1/20/14.
//  Copyright (c) 2014 TitanEye Plus. All rights reserved.
//

#import "TransitionViewController.h"

#import "LE_1_ViewController.h"
#import "RE_1_ViewController.h"
#import "Clock_RightViewController.h"
#import "Clock_LeftViewController.h"
#import "Duo_LeftViewController.h"
#import "Duo_RightViewController.h"
#import "Nvision_L_ViewController.h"
#import "NVision_R_ViewController.h"


@interface TransitionViewController ()

@end


@implementation TransitionViewController


@synthesize sliderOutlet;
@synthesize fiveSecTimer;
@synthesize oneSecTimer;
@synthesize durationTime;
@synthesize currentTime;
//@synthesize audioPlayer;
@synthesize duration;
@synthesize togglePlay;
@synthesize head;
@synthesize para1;
@synthesize para2;
@synthesize audioPlayer1;
@synthesize appDelegate;

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
    [super viewDidLoad];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"Back-image_new.jpg"]];
    }
	// Do any additional setup after loading the view.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //self.audioPlayer = [[AVPlayer alloc] init];
    //[self startPlaying];
    
    [self startPlaying1];
    
    // Fill the title and paragraphs
    self.head.text = appDelegate.transTitle;
    self.para1.text = appDelegate.transPara1;
    self.para2.text = appDelegate.transPara2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) startPlaying1
{
    // initialize the timers
    [[self oneSecTimer] invalidate];
    self.oneSecTimer = nil;
    [[self fiveSecTimer] invalidate];
    self.fiveSecTimer = nil;
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",
                                         [[NSBundle mainBundle] resourcePath],appDelegate.transAudioFile]];
    NSError *error;
	self.audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    self.audioPlayer1.delegate = self;
    
    // Set the seek to 0
    audioPlayer1.currentTime = 0;

    self.togglePlay = 1;
    
    // start playing
    [self.audioPlayer1 play];
    
    
    [[self togglePlayPauseButton] setTitle:@"Pause" forState:UIControlStateNormal];
    
    // Set the duration time
    duration = audioPlayer1.duration;
    int durationMins = (int)(duration/60);
    int durationSec  = (int)(duration%60);
    NSString * durationLabel =[NSString stringWithFormat:@"%02d:%02d",durationMins,durationSec];
    [[self durationTime] setText :durationLabel];
    
    // initialize the slider
    [self.sliderOutlet setValue:0];
    [self.sliderOutlet setMinimumValue:0];
    [self.sliderOutlet setMaximumValue:self.audioPlayer1.duration];
    NSLog(@" value of duration %f", audioPlayer1.duration);
    
    // Recurresive timer every 1 sec
    self.oneSecTimer = [NSTimer
                  scheduledTimerWithTimeInterval:1.0
                  target:self selector:@selector(updateSliderAndCurrentTime)
                  userInfo:nil repeats:YES];
    
    
}
-(void) updateSliderAndCurrentTime
{
    
    // Set the current time
    int currentT = audioPlayer1.currentTime+1;
    int currentMins = (int)(currentT/60);
    int currentSec  = (int)(currentT%60);
    NSString * durationLabel =[NSString stringWithFormat:@"%02d:%02d",currentMins,currentSec];
    [[self currentTime] setText :durationLabel];
    
    // Set the new slider value
    [[self sliderOutlet] setValue :(currentT) animated:YES];
    NSLog(@"Value of slider current %d, duration %d ", currentT, duration);
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                       successfully:(BOOL)flag
{
    [[self oneSecTimer] invalidate];
    self.oneSecTimer = nil;
    
    // Check if the player has reached the end
    NSLog(@"Current song ends, scheduling autoplay after 5 sec");
        
    [[self togglePlayPauseButton] setTitle:@"Play" forState:UIControlStateNormal];
    // Wait for 5 secs and start playing the clip again.
    self.fiveSecTimer =  [NSTimer scheduledTimerWithTimeInterval:5.0 target:self
                        selector:@selector(startPlaying1) userInfo:nil repeats:NO];
    
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player
                                 error:(NSError *)error
{
    
}


#pragma - mark ButtonActions

-(IBAction)replay:(id)sender
{
    NSLog(@"Replay button hit");
    //[self.audioPlayer seekToTime:CMTimeMakeWithSeconds(0 , 1)];
    [self startPlaying1];

}

-(IBAction) togglePlayPause:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    if(self.togglePlay == 1) {
        //NSLog(@"toggle play pause button hit when playing");
        //[self.audioPlayer pause];
        [self.audioPlayer1 pause];
        self.togglePlay = 0;
        [btn setTitle:@"Play" forState:UIControlStateNormal];
    } else {
        //NSLog(@"toggle play pause button hit when paused");
        //[self.audioPlayer play];
        [self.audioPlayer1 play];
        self.togglePlay = 1;
        [btn setTitle:@"Pause" forState:UIControlStateNormal];
    }
    
}
-(IBAction) seekSet:(id)sender
{
    
    UISlider *slider = (UISlider *)sender;
    NSInteger val = lround(slider.value);
    NSLog(@"seek set from slider %d, seek to %d",val, val*self.duration/100);
    //[self.audioPlayer seekToTime:CMTimeMakeWithSeconds(2*self.duration*val/100 , 1)];
    self.audioPlayer1.currentTime = (2*self.duration*val/100);
    
}


-(IBAction) takeTest:(id)sender
{
    // Cancel the timer if any
    [[self fiveSecTimer] invalidate];
    self.fiveSecTimer = nil;
    //[[self audioPlayer  ]pause];
    //self.audioPlayer = nil;
    
    [[self oneSecTimer] invalidate];
    self.oneSecTimer = nil;
    
    // Stop the player
    [self.audioPlayer1 stop];
    
    
    NSLog(@"Value of self duration is %d", self.duration);
    //[self.audioPlayer seekToTime:CMTimeMakeWithSeconds(self.duration , 1)];
    self.duration = 0;

    NSLog(@"Take test button clicked");

    NSString *iPadNib = [NSString  stringWithFormat:@"%@_%@",appDelegate.transNib,@"iPad"];
    
    
    if ([appDelegate.transNib  isEqual: @"InstructionViewController"]){
        /*
        InstructionViewController  *uvc;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            uvc = [[InstructionViewController alloc] initWithNibName:appDelegate.transNib bundle:nil];
        } else {
            uvc = [[InstructionViewController alloc] initWithNibName:iPadNib bundle:nil];
        }
        //controller.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:uvc animated:YES completion:nil];
        uvc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
         */
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
    }else if ([appDelegate.transNib  isEqual: @"LE_1_ViewController"]){
        LE_1_ViewController  *uvc;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            uvc = [[LE_1_ViewController alloc] initWithNibName:appDelegate.transNib bundle:nil];
        } else {
            uvc = [[LE_1_ViewController alloc] initWithNibName:iPadNib bundle:nil];
        }
        
        [self presentViewController:uvc animated:YES completion:nil];
        uvc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    }else if ([appDelegate.transNib  isEqual: @"Clock_RightViewController"]){
        Clock_RightViewController  *uvc;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            uvc = [[Clock_RightViewController alloc] initWithNibName:appDelegate.transNib bundle:nil];
        } else {
            uvc = [[Clock_RightViewController alloc] initWithNibName:iPadNib bundle:nil];
        }
        
        [self presentViewController:uvc animated:YES completion:nil];
        uvc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    }else if ([appDelegate.transNib  isEqual: @"Duo_RightViewController"]){
        Duo_RightViewController  *uvc;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            uvc = [[Duo_RightViewController alloc] initWithNibName:appDelegate.transNib bundle:nil];
        } else {
            uvc = [[Duo_RightViewController alloc] initWithNibName:iPadNib bundle:nil];
        }
        
        [self presentViewController:uvc animated:YES completion:nil];
        uvc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    }else if ([appDelegate.transNib  isEqual: @"RE_1_ViewController"]){
        RE_1_ViewController  *uvc;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            uvc = [[RE_1_ViewController alloc] initWithNibName:appDelegate.transNib bundle:nil];
        } else {
            uvc = [[RE_1_ViewController alloc] initWithNibName:iPadNib bundle:nil];
        }
        
        [self presentViewController:uvc animated:YES completion:nil];
        uvc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    }else if ([appDelegate.transNib  isEqual: @"Clock_LeftViewController"]){
        Clock_LeftViewController  *uvc;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            uvc = [[Clock_LeftViewController alloc] initWithNibName:appDelegate.transNib bundle:nil];
        } else {
            uvc = [[Clock_LeftViewController alloc] initWithNibName:iPadNib bundle:nil];
        }
        
        [self presentViewController:uvc animated:YES completion:nil];
        uvc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    }else if ([appDelegate.transNib  isEqual: @"Duo_LeftViewController"]){
        Duo_LeftViewController  *uvc;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            uvc = [[Duo_LeftViewController alloc] initWithNibName:appDelegate.transNib bundle:nil];
        } else {
            uvc = [[Duo_LeftViewController alloc] initWithNibName:iPadNib bundle:nil];
        }
        
        [self presentViewController:uvc animated:YES completion:nil];
        uvc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    }else if ([appDelegate.transNib  isEqual: @"NVision_R_ViewController"]){
        NVision_R_ViewController  *uvc;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            uvc = [[NVision_R_ViewController alloc] initWithNibName:appDelegate.transNib bundle:nil];
        } else {
            uvc = [[NVision_R_ViewController alloc] initWithNibName:iPadNib bundle:nil];
        }
        
        [self presentViewController:uvc animated:YES completion:nil];
        uvc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    }else if ([appDelegate.transNib  isEqual: @"Nvision_L_ViewController"]){
        Nvision_L_ViewController  *uvc;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            uvc = [[Nvision_L_ViewController alloc] initWithNibName:appDelegate.transNib bundle:nil];
        } else {
            uvc = [[Nvision_L_ViewController alloc] initWithNibName:@"Nvision_L_ViewController_ipad" bundle:nil];
        }
        
        [self presentViewController:uvc animated:YES completion:nil];
        uvc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    }else{// Call for the disclaimer scree
        
#if 1
        appDelegate.transAudioFile = @"instructions.wav";
        appDelegate.transNib = @"InstructionViewController";
        appDelegate.transPara1 = @"If you wear spectacles, take the test wearing them.\n \
        The screen should be parallel to your face.\n \
        Maintain eye level at the same height as the screen so that the letters are clearly visible.";
        appDelegate.transPara2 = @"";
        appDelegate.transTitle = @"EYE SCREENING INSTRUCTIONS";
       
        
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
    
#else
    SquareCamViewController *svc = [[SquareCamViewController alloc ]initWithNibName:@"SquareCamViewController_iPad" bundle:nil];
    [self presentViewController:svc animated:YES completion:nil];
    svc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    
#endif
    }
    
}


- (void)dealloc
{
    //[audioPlayer release];
    //[super dealloc];
}

/*
 
 
 -(void)playerItemDidReachEnd {
 //add the next song to your queue and play , just as you did in the method for selecting a cell.
 
 }
 
 -(void) startPlaying{
 
 [[self timer] invalidate];
 self.timer = nil;
 
 NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",
 [[NSBundle mainBundle] resourcePath],appDelegate.transAudioFile]];
 AVPlayerItem * item = [AVPlayerItem playerItemWithURL:url];
 
 [self.audioPlayer replaceCurrentItemWithPlayerItem:item];
 
 
 
 [self.audioPlayer play];
 [[self togglePlayPauseButton] setTitle:@"Pause" forState:UIControlStateNormal];
 self.togglePlay = 1;
 
 
 self.duration = audioPlayer1.duration;
 
 [[NSNotificationCenter defaultCenter] addObserver:self
 selector:@selector(playerItemDidReachEnd)
 name:AVPlayerItemDidPlayToEndTimeNotification
 object:nil];
 
 [self configurePlayer];
 
 }
 
 #pragma - mark LoopingThread
 -(void) configurePlayer {
 
 __block TransitionViewController * weakSelf = self;
 
 [self.audioPlayer addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, 1)
 queue:NULL usingBlock:^(CMTime time)
 {
 if(!time.value) {
 return;
 }
 int currentT = (int)((weakSelf.audioPlayer.currentTime.value)/weakSelf.audioPlayer.currentTime.timescale);
 int currentMins = (int)(currentT/60);
 int currentSec  = (int)(currentT%60);
 NSString * durationLabel =[NSString stringWithFormat:@"%02d:%02d",currentMins,currentSec];
 //NSLog(@"%@",durationLabel);
 weakSelf.currentTime.text = durationLabel;
 //weakSelf.sliderOutlet.value = currentT;
 
 AVPlayerItem * item = [[weakSelf audioPlayer] currentItem];
 if (item.status == AVPlayerItemStatusReadyToPlay){
 CMTime cmtTime = item.duration;
 weakSelf.duration = cmtTime.value/cmtTime.timescale;
 
 int currentMins = (int)(weakSelf.duration/60);
 int currentSec  = (int)(weakSelf.duration%60);
 
 // Set the duration label
 //if (weakSelf.duration == 0){
 NSString * durationLabel =
 [NSString stringWithFormat:@"%02d:%02d",currentMins,currentSec];
 [[weakSelf durationTime] setText :durationLabel];
 
 [weakSelf.sliderOutlet setMaximumValue:weakSelf.audioPlayer.currentItem.duration.value/weakSelf.audioPlayer.currentItem.duration.timescale];
 // NSLog(@"min = %f and max = %f", weakSelf.sliderOutlet.minimumValue, weakSelf.sliderOutlet.maximumValue);
 // }
 
 // Set the new slider value
 float t = (100.0)*currentT/weakSelf.duration;
 [[weakSelf sliderOutlet] setValue :(t/2) animated:YES];
 
 //NSLog(@"Value of slider current %d, time %d , %f", currentT, weakSelf.duration, t/2);
 }
 
 }];
 
 
 }
 */

@end
