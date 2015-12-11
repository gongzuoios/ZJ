//
//  ZJLine.h
//  ZJPaint
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZJLine : NSObject

//画笔开始的点
@property (nonatomic) CGPoint begin;

//画笔结束的点
@property (nonatomic) CGPoint end;

//画笔点的颜色(预留)
@property (nonatomic) UIColor*color;

@end
