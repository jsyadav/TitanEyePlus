//
//  Clock_RightViewController.h
//  TitanEyePlus
//
//  Created by Admin on 10/9/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SquareCamViewController.h"


@interface Clock_RightViewController : UIViewController
{
    IBOutlet UIButton *yes,*no;
    IBOutlet UISlider *slider;
}
-(IBAction)yes:(id)sender;
-(IBAction)no:(id)sender;

@property(nonatomic,retain)IBOutlet UILabel *dlabel;
@property(nonatomic,retain)IBOutlet UIImageView *bulb;
@property(nonatomic,retain) IBOutlet UISlider *slider;

@end
