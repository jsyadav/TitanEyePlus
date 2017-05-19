//
//  ViewController.h
//  imageBounds
//
//  Created by Lion User on 07/10/2013.
//  Copyright (c) 2013 3edge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@class AppDelegate;

@interface ValidationController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UIActionSheetDelegate>
{
    UIPopoverController *popover;
    IBOutlet UITextField *entercode;
    IBOutlet UITextField *cityField;
    UIActionSheet *actionSheet;
    IBOutlet UIButton *submit;
    AppDelegate *appDelegate;
    NSString *forcode;
    UIPickerView *selectcity;
    NSArray *cities;
    NSString *cd;
    IBOutlet UIView *sample;
}
@property(nonatomic,retain)UITextField *cityField;
@property(nonatomic,retain)UITextField *entercode;
@property(nonatomic,retain) NSString *forcode;
@property(nonatomic,retain)UIPickerView *selectcity;
@property(nonatomic,retain)UIPopoverController *popover;
@property(nonatomic,retain)UIActionSheet *actionSheet;
@property(nonatomic,retain)NSArray *cities;
@property(nonatomic,retain)NSString *cd;
@property(nonatomic,retain)UIView *sample;
-(IBAction)submit:(id)sender;
@end
