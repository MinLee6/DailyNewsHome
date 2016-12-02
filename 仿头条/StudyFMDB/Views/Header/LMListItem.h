//
//  LMListItem.h
//  StudyFMDB
//
//  Created by limin on 16/11/30.
//  Copyright © 2016年 君安信（北京）科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    top = 0,
    bottom = 1
}itemLocation;
@interface LMListItem : UIButton
{
@public
    NSMutableArray *locateView;
    NSMutableArray *topView;
    NSMutableArray *bottomView;
}
@property (nonatomic,strong) UIView   *hitTextLabel;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UIButton *hiddenBtn;
@property (nonatomic,assign) itemLocation location;
@property (nonatomic,copy) NSString *itemName;

@property (nonatomic,copy) void(^longPressBlock)();
@property (nonatomic,copy) void(^operationBlock)(animateType type, NSString *itemName, int index);


@property (nonatomic,strong) UIPanGestureRecognizer *gesture;
@property (nonatomic,strong) UILongPressGestureRecognizer *longGesture;
@end
