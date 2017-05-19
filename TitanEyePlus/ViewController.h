//
//  ViewController.h
//  TitanEyePlus
//
//  Created by Admin on 9/4/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ValidationController.h"
#import "Reachability.h"
#import "InstructionViewController.h"


@class FbViewController;
@class  AppDelegate;





@interface ViewController : UIViewController<UITextFieldDelegate,NSURLConnectionDelegate,UITextViewDelegate>
{
   
  IBOutlet UILabel *label,*label1,*label2,*label3;
  IBOutlet UITextField *name,*age,*email,*mobile;
  IBOutlet UIImageView *logo;
  IBOutlet UITextView *message,*msg2,*msg3,*msg4;
  IBOutlet UIButton *starttest;
  IBOutlet UIButton *fblogin;
  //NSString *smscode;
  AppDelegate *appDelegate;
   
    

}
@property(nonatomic,retain)UILabel *label,*label1,*label2,*label3;
@property(nonatomic,retain) UITextField *name,*age,*email,*mobile;
@property(nonatomic,retain)UIImageView *logo;
@property(nonatomic,retain) UIButton *fblogin;
//@property(nonatomic,retain)  NSString *smscode;
@property(nonatomic,retain)UIActivityIndicatorView *spinner;

-(IBAction)starttest:(id)sender;
-(IBAction)fblogin:(id)sender;

-(void)loginFailed;
-(void)logoutButtonWasPressed:(id)sender;
-(void)openSession;

-(BOOL)networkCheck;

@end
