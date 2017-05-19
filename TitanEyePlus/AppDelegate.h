//
//  AppDelegate.h
//  TitanEyePlus
//
//  Created by Admin on 9/4/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>



@class ViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString *passingName,*passingAge,*passingLabel,*passingCity;
    NSMutableDictionary *userInfo;
    NSMutableDictionary *leftEyeResult;
    NSMutableDictionary *reftEyeResult;
    NSString *transNib;
    NSString *transTitle;
    NSString *transPara1;
    NSString *transPara2;
    NSString *transAudioFile;
    
    double distance;
    
}
@property(nonatomic,retain)NSString *passingName;
@property(nonatomic,retain)NSString *passingAge;
@property(nonatomic,retain)NSString *passingLabel;
@property(nonatomic,retain)NSString *passingCity;
@property(nonatomic,retain)NSMutableDictionary *userInfo;
@property(nonatomic,retain)NSMutableDictionary *leftEyeResult;
@property(nonatomic,retain)NSMutableDictionary *rightEyeResult;

@property(nonatomic,retain)NSString *transNib;
@property(nonatomic,retain)NSString *transTitle;
@property(nonatomic,retain)NSString *transPara1;
@property(nonatomic,retain)NSString *transPara2;
@property(nonatomic,retain)NSString *transAudioFile;
@property()double distance;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;






@end
