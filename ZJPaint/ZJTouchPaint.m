//
//  ZJTouchPaint.m
//  ZJPaint
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ZJTouchPaint.h"

#define origin_x [UIScreen mainScreen].bounds.origin.x/4
#define origin_y [UIScreen mainScreen].bounds.origin.y/5
#define origin_radius [UIScreen mainScreen].bounds.size.width/8
#define size_width [UIScreen mainScreen].bounds.size.width/4
#define size_height [UIScreen mainScreen].bounds.size.width/4
#define regularValue 50


@implementation ZJTouchPaint


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)drawRect:(CGRect)rect {
    
    //画圆形
    [self drawRound];
    
    //三角形
    [self drawTriangle];
    
    //矩形
    [self drawRectangle];
    
    //线条
    [self drawLine];
    
}


//实例化方法
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    
    if (self) {
        
        _linesSet=[[NSMutableArray alloc] init];
        
        //允许多点触控
        [self setMultipleTouchEnabled:YES];
        
        [self becomeFirstResponder];
        
        self.isLine=YES;
        
        self.imageview=[[UIImageView alloc] initWithFrame:self.bounds];
        
        //橡皮擦的擦拭层加入到画板层
        [self addSubview:self.imageview];
        
    }
    
    return self;
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch*touch in touches) {
        
        CGPoint point=[touch locationInView:self];
        
        ZJLine*newLine=[[ZJLine alloc] init];
        
        newLine.begin=point;
        
        newLine.end=point;
        
        self.currentLine=newLine;
    }
}


//---把每个点加入道数组中
-(void)addLine:(ZJLine*)line{
    
    [self.linesSet addObject:line];
    
    [self setNeedsDisplay];
}



//---手指移动
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //当前为橡皮擦
    if (_canEraser){
        
        UITouch*touch=[touches anyObject];
        
        CGPoint startPoint=[touch locationInView:self.imageview];
        
        CGRect cirleRect = CGRectMake(startPoint.x-40, startPoint.y-40,80, 80);
        
        CGContextClip(UIGraphicsGetCurrentContext());
        
        UIGraphicsBeginImageContext(self.imageview.frame.size);
        
        [self.imageview.image drawInRect:self.imageview.bounds];
        
        CGContextClearRect(UIGraphicsGetCurrentContext(), cirleRect);
        
        self.imageview.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }else{
        
        //当前为画笔
        
        for (UITouch*touch in touches) {
            
            CGPoint point=[touch locationInView:self];
            
            self.currentLine.end=point;
            
            [self addLine:self.currentLine];
            
            ZJLine*newLine=[[ZJLine alloc] init];
            
            newLine.begin=point;
            
            newLine.end=point;
            
            self.currentLine=newLine;
        }
    }
}



//****-画线条-****
-(void)drawLine{
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    if (_isLine) {
        
        CGContextSaveGState(context);
        
        CGContextSetLineWidth(context, 3.0f);
        
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        
        CGContextSetLineCap(context, kCGLineCapRound);
        
        for (ZJLine*line in self.linesSet) {
            
            CGContextMoveToPoint(context, line.begin.x, line.begin.y);
            
            CGContextAddLineToPoint(context, line.end.x, line.end.y);
            
            CGContextSetRGBStrokeColor(context, 0/255.0, 0/255.0, 255/255.0, 1);
            
            CGContextStrokePath(context);
            
        }
        
        CGContextRestoreGState(context);
    }
}



//****-画圆形-****
-(void)drawRound{
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    if (_isRound) {
        
        CGContextSetLineWidth(context, 2.0f);
        
        CGContextAddArc(context, origin_x+regularValue, origin_y+regularValue, origin_radius, 0, 2*M_PI, 0);
        
        [[UIColor orangeColor] setStroke];
        
        CGContextDrawPath(context, kCGPathStroke);
    }
}



//****-画三角形-****
-(void)drawTriangle{
    
    if (_isTriangle) {
        
        CGContextRef context=UIGraphicsGetCurrentContext();
        
        CGContextBeginPath(context);
        
        CGContextSetLineWidth(context, 2.0f);
        
        CGContextMoveToPoint(context, 150, 100);
        
        CGContextAddLineToPoint(context, 250, 100);
        
        CGContextAddLineToPoint(context, 250, 210);
        
        CGContextClosePath(context);
        
        [[UIColor orangeColor] setStroke];
        
        [[UIColor clearColor] setFill];
        
        CGContextDrawPath(context, kCGPathFillStroke);
    }
}



//****-画矩形-****
-(void)drawRectangle{
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    if (_isRectangle) {
        
        CGContextSetLineWidth(context, 2.0f);
        
        CGRect tempRect=CGRectMake(40, 130, 200, 100);
        
        CGMutablePathRef path=CGPathCreateMutable();
        
        CGPathAddRect(path, NULL, tempRect);
        
        CGContextAddPath(context, path);
        
        [[UIColor greenColor] setStroke];
        
        [[UIColor clearColor] setFill];
        
        CGContextDrawPath(context, kCGPathFillStroke);
        
        CGPathRelease(path);
        
    }
}






@end
