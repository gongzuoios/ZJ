//
//  ZJViewController.m
//  ZJPaint
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ZJViewController.h"

@interface ZJViewController ()

@end

@implementation ZJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //传过来的照片作为背景（即相机拍照得到的照片）
    [self addImage:[UIImage imageNamed:@"1.jpg"]];
    
}


- (IBAction)triangle:(id)sender {
    
    self.touchPaintArea.isTriangle=YES;
    
    [self.touchPaintArea setNeedsDisplay];
}


- (IBAction)round:(id)sender {
    
    self.touchPaintArea.isRound=YES;
    
    [self.touchPaintArea setNeedsDisplay];
}


- (IBAction)rectangle:(id)sender {
    
    self.touchPaintArea.isRectangle=YES;
    
    [self.touchPaintArea setNeedsDisplay];
    
}


- (IBAction)eraser:(id)sender {
    
    self.touchPaintArea.canEraser=YES;
    
    [self.touchPaintArea.linesSet removeAllObjects];
    
    self.touchPaintArea.isTriangle=NO;
    
    self.touchPaintArea.isRectangle=NO;
    
    self.touchPaintArea.isRound=NO;
    
    self.touchPaintArea.imageview.image=[self makeImageWithView:self.touchPaintArea];
    
    [self.touchPaintArea setNeedsDisplay];
    
}


- (IBAction)line:(id)sender {
    
    self.touchPaintArea.isLine=YES;
    
    self.touchPaintArea.canEraser=NO;
    
    [self.touchPaintArea setNeedsDisplay];
    
}


- (IBAction)clear:(id)sender {
    
    [self.touchPaintArea.linesSet removeAllObjects];
    
    self.touchPaintArea.isTriangle=NO;
    
    self.touchPaintArea.isRectangle=NO;
    
    self.touchPaintArea.isRound=NO;
    
    self.touchPaintArea.imageview.image=[self makeBlankImage];
    
    [self.touchPaintArea setNeedsDisplay];
    
}


//---增加背景图片(拍摄的照片作为背景)
-(void)addImage:(UIImage *)image{
    
    self.imageview.image=image;
    
}


//---制作橡皮擦图层
- (UIImage *)makeImageWithView:(UIView *)view

{
    CGSize size = view.bounds.size;
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}


//制作透明图层(当点击橡皮擦后，再点击清空，则无法清除橡皮擦图层，因为它是touchPaintArea的照片，所以给它更新一个透明的image，便可以达到清空的效果，而实际的touchPaintArea画板层已经清空)
-(UIImage*)makeBlankImage{
    
    UIGraphicsBeginImageContextWithOptions(self.touchPaintArea.frame.size, NO, [UIScreen mainScreen].scale);
    
    UIImage*blankImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return blankImage;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
