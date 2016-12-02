//
//  LMDetailsList.h
//  StudyFMDB
//
//  Created by limin on 16/11/30.
//  Copyright © 2016年 君安信（北京）科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMDetailsList : UIScrollView
@property (nonatomic,strong) NSMutableArray *topView;
@property (nonatomic,strong) NSMutableArray *bottomView;
@property (nonatomic,strong) NSMutableArray *listAll;

@property (nonatomic,copy) void(^longPressedBlock)();
@property (nonatomic,copy) void(^opertionFromItemBlock)(animateType type, NSString *itemName, int index);
-(void)itemRespondFromListBarClickWithItemName:(NSString *)itemName;
@end
