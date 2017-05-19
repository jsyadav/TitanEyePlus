//  LeftEyeViewController.h
//  TitanEyePlus
//
//  Created by Admin on 9/19/13.
//  Copyright (c) 2013 TitanEye Plus. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SquareCamViewController.h"


@interface RE_1_ViewController :UIViewController
{
    
    
    int curInd;
    int ans;
    int previousArrow;//0-right,1-down,2-left,3-top
    
    NSMutableArray *eDirection;
    NSDictionary *eDictionary;
    IBOutlet UISlider *slider;
    
}


@property(strong,nonatomic)UIImageView *image;

@property(nonatomic,retain)UIButton *upBtn;
@property(nonatomic,retain)UIButton *rightBtn;
@property(nonatomic,retain)UIButton *downBtn;
@property(nonatomic,retain)UIButton *leftBtn;

@property(nonatomic,retain) NSMutableArray *eDirection;
@property(nonatomic,retain) NSDictionary *eDictionary;

@property(nonatomic,assign) int curInd;
@property(nonatomic,assign) int ans;
@property(nonatomic,assign) int previousArrow;
@property(nonatomic,retain)IBOutlet UILabel *dlabel;
@property(nonatomic,retain)IBOutlet UIImageView *bulb;
@property(nonatomic,retain) IBOutlet UISlider *slider;

-(void)rotate:(int)degree;
-(void)eLogic:(NSString *)directions;

@end
