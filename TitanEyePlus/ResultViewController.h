//
//  ResultViewController.h
//  TitanEyePlus
//
//  Created by Admin on 10/9/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  AppDelegate;

@interface ResultViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UIPopoverControllerDelegate,UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *nearBy;
    AppDelegate *appDelegate;
    IBOutlet UITextField *selectNearBy;
    IBOutlet UITableView *table;
    NSArray *s1,*s2,*s3;
    NSMutableArray *lr,*rr;
    
    
    
    
}
@property(nonatomic,retain)IBOutlet UIButton *next;
@property(nonatomic,retain)NSArray *nearBy;
@property(nonatomic,retain)UITextField *selectNearBy;
@property(nonatomic,retain)UITableView *table;
@property(nonatomic,retain)UIActionSheet *actionSheet;
@property(nonatomic,retain)UIPopoverController *popover;
@property(nonatomic,retain)UIPickerView *nearLocation;
@property(nonatomic,retain)NSArray *cities_nearBy;
@property(nonatomic,retain) NSMutableArray *lr;
@property(nonatomic,retain) NSMutableArray *rr;
-(IBAction)next:(id)sender;
@end
