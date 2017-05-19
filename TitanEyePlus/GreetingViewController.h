//
//  GreetingViewController.h
//  TitanEyePlus
//
//  Created by Admin on 10/9/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;


@interface GreetingViewController : UIViewController<UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIPopoverControllerDelegate,UITextViewDelegate,UIAlertViewDelegate>
{
    
      IBOutlet UITextField *ratingField;
    IBOutlet UITextView *userFeedback;
      AppDelegate *appDelegate;
    IBOutlet UIButton *shareOnFacebbok;
    IBOutlet UIButton *exit;
    UIAlertView *alert1;
}
@property(nonatomic,retain)UIButton *thanks;

@property(nonatomic,retain)UITextField *ratingField;
@property(nonatomic,retain)UIPopoverController *popover;
@property(nonatomic,retain)UIActionSheet *actionSheet;
@property(nonatomic,retain)NSArray *rating;
@property(nonatomic,retain) UITextView *userFeedback;
@property(nonatomic,retain)UIPickerView *picker;

@property(nonatomic,retain)UIAlertView *alert1;

-(IBAction)thanks:(id)sender;
-(IBAction)shareOnFacebook:(id)sender;
-(IBAction)exit:(id)sender;


@end
