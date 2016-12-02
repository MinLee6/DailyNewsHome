//
//  LMArrow.h
//  StudyFMDB
//
//  Created by limin on 16/11/30.
//  Copyright © 2016年 君安信（北京）科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMArrow : UIButton
@property (nonatomic,copy) void(^arrowBtnClick)();
@end
