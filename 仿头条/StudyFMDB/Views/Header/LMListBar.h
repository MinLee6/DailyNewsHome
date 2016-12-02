//
//  LMListBar.h
//  StudyFMDB
//
//  Created by limin on 16/11/30.
//  Copyright © 2016年 君安信（北京）科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMListBar : UIScrollView
//被选中的按钮
@property (nonatomic, strong) UIButton *btnSelect;
@property (nonatomic,copy) void(^arrowChange)();
@property (nonatomic,copy) void(^listBarItemClickBlock)(NSString *itemName , NSInteger itemIndex);

@property (nonatomic,strong) NSMutableArray *visibleItemList;

-(void)operationFromBlock:(animateType)type itemName:(NSString *)itemName index:(int)index;
-(void)itemClickByScrollerWithIndex:(NSInteger)index;

@end
