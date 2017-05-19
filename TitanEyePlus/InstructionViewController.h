//
//  InstructionViewController.h
//  TitanEyePlus
//
//  Created by Admin on 9/11/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@class AppDelegate;

@interface InstructionViewController : UIViewController
{
    IBOutlet UILabel *welcome,*age;
       IBOutlet UITextView *instructionview,*resolutionview;
    AppDelegate *appDelegate;
    IBOutlet UIWebView *instruction;
    IBOutlet UIButton *next;

       
}
@property(nonatomic,retain)UILabel *welcome,*age;
@property(nonatomic,retain)UIButton *click,*resolution;
@property(nonatomic,retain)UIWebView *instruction;

-(IBAction)next:(id)sender;

@end
