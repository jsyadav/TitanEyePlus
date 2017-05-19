//
//  TransitionViewController.h
//  TitanEyePlus
//
//  Created by Jitendra Yadav MB on 1/20/14.
//  Copyright (c) 2014 TitanEye Plus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"


@interface TransitionViewController : UIViewController<AVAudioPlayerDelegate>
{
    // Instance variables
    IBOutlet UILabel *currentTime;
    IBOutlet UILabel *durationTime;
    IBOutlet UISlider *sliderOutlet;
    IBOutlet UILabel *head;
    IBOutlet UILabel *para1;
    IBOutlet UITextView *para2;
    //AVPlayer *audioPlayer;
    AVAudioPlayer *audioPlayer1;
    NSTimer *fiveSecTimer;
    NSTimer *oneSecTimer;
    int duration;
    int togglePlay;
    AppDelegate *appDelegate;
}

// Property for accessor methods
@property(nonatomic,retain)IBOutlet UILabel *currentTime;
@property(nonatomic,retain)IBOutlet UILabel *durationTime;
@property(nonatomic,retain)IBOutlet UISlider *sliderOutlet;
@property(nonatomic,retain)IBOutlet UILabel *head;
@property(nonatomic,retain)IBOutlet UILabel *para1;
@property(nonatomic,retain)IBOutlet UITextView *para2;
//@property(strong, nonatomic) AVPlayer *audioPlayer;
@property(strong, nonatomic) AVAudioPlayer *audioPlayer1;
@property(nonatomic,retain)IBOutlet UIButton *togglePlayPauseButton;
@property(nonatomic, retain) NSTimer *fiveSecTimer;
@property(nonatomic, retain) NSTimer *oneSecTimer;
@property(nonatomic)int duration;
@property(nonatomic)int togglePlay;
@property(nonatomic, retain)AppDelegate *appDelegate;


// Instance methods
-(IBAction)seekSet:(id)sender;
-(IBAction)takeTest:(id)sender;
-(IBAction)replay:(id)sender;
-(IBAction)togglePlayPause:(id)sender;

@end
