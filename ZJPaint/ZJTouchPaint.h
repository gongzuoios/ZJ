//
//  ZJTouchPaint.h
//  ZJPaint
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJLine.h"

@interface ZJTouchPaint : UIView

@property(nonatomic,assign)BOOL isRound;

@property(nonatomic,assign)BOOL isTriangle;

@property(nonatomic,assign)BOOL isRectangle;

@property(nonatomic,assign)BOOL isLine;

@property(nonatomic,assign)BOOL canEraser;

//书写轨迹
@property(nonatomic)ZJLine*currentLine;

//书写轨迹的数组
@property(nonatomic)NSMutableArray*linesSet;


//照片imageview，即touchPaintArea的照片，橡皮擦再该层操作，擦除该层的image，显示出touchPaintArea
@property(nonatomic,strong)UIImageView*imageview;

@end
