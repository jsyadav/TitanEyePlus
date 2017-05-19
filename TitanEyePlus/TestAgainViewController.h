//
//  TestAgainViewController.h
//  TitanEyePlus
//
//  Created by Admin on 11/13/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface TestAgainViewController : UIViewController
{
    IBOutlet UITextView *greetings;
    IBOutlet UILabel *name;
    AppDelegate *appDelegate;
    IBOutlet UIButton *website;
    IBOutlet UIButton *takeTestAgain;
    IBOutlet UIButton *exit;
}
-(IBAction)website:(id)sender;

-(IBAction)takeTestAgain:(id)sender;

-(IBAction)exit:(id)sender;

@end
