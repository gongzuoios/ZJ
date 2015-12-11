//
//  ZJViewController.h
//  ZJPaint
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJTouchPaint.h"

@interface ZJViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *triangle;

@property (weak, nonatomic) IBOutlet UIButton *round;

@property (weak, nonatomic) IBOutlet UIButton *rectangle;

@property (weak, nonatomic) IBOutlet UIButton *eraser;

@property (weak, nonatomic) IBOutlet UIButton *line;

@property (weak, nonatomic) IBOutlet UIButton *clear;

//背景图片，即相机传过来的照片
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

// 画板view
@property (weak, nonatomic) IBOutlet ZJTouchPaint *touchPaintArea;

//将相机拍照传过来的照片设为背景
-(void)addImage:(UIImage*)image;

@end
