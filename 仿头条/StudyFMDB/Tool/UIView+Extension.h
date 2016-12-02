//
//  UIView+Extension.h
//  StudyFMDB
//
//  Created by limin on 16/11/30.
//  Copyright © 2016年 君安信（北京）科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Extension)

//方便获取任何一个控件的frame属性
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;

/** 从xib中创建一个控件 */
+ (instancetype)viewFromXib;

+ (instancetype)createViewFromNib;

+ (instancetype)createViewFromNibName:(NSString *)nibName;


//宽度
- (CGFloat)current_w;

//高度
- (CGFloat)current_h;

//当前view.frame的x、y、x+宽、y+高
- (CGFloat)current_x;
- (CGFloat)current_y;
- (CGFloat)current_x_w;
- (CGFloat)current_y_h;

//细线
+ (UIView *)lineWithColor:(UIColor *)color frame:(CGRect)frame;


@end
