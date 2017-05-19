//
//  NVision_R_ViewController.h
//  TitanEyePlus
//
//  Created by Admin on 10/9/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SquareCamViewController.h"


@interface NVision_R_ViewController : UIViewController
{
    IBOutlet UIButton *N1,*N2,*N3,*N4,*N5;
    IBOutlet UISlider *slider;
}
-(IBAction)N1:(id)sender;
-(IBAction)N2:(id)sender;
-(IBAction)N3:(id)sender;
-(IBAction)N4:(id)sender;
-(IBAction)N5:(id)sender;

@property(nonatomic,retain)IBOutlet UILabel *dlabel;
@property(nonatomic,retain)IBOutlet UIImageView *bulb;
@property(nonatomic,retain) IBOutlet UISlider *slider;

@end
