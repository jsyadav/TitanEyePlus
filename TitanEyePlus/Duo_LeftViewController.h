//
//  Duo_LeftViewController.h
//  TitanEyePlus
//
//  Created by Admin on 10/9/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SquareCamViewController.h"


@interface Duo_LeftViewController : UIViewController
{
    IBOutlet UIButton *green,*red,*equal;
    UIImageView *e1,*e2,*e3,*e4,*e5,*e6,*e7,*e8;
    UIImageView *duochrome;
    IBOutlet UISlider *slider;
}
-(IBAction)green:(id)sender;

-(IBAction)red:(id)sender;

-(IBAction)equal:(id)sender;

@property(nonatomic,retain)UIImageView *e1,*e2,*e3,*e4,*e5,*e6,*e7,*e8;
@property(nonatomic,retain)UIImageView *duochrome;
@property(nonatomic,retain)IBOutlet UILabel *dlabel;
@property(nonatomic,retain)IBOutlet UIImageView *bulb;

@property(nonatomic,retain) IBOutlet UISlider *slider;

@end
