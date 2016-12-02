//
//  LMCollectionViewCell.m
//  StudyFMDB
//
//  Created by limin on 16/11/30.
//  Copyright © 2016年 君安信（北京）科技有限公司. All rights reserved.
//

#import "LMCollectionViewCell.h"
@interface LMCollectionViewCell()
/* 表格 */
@property(nonatomic,strong)UITableView *lmTableView;
@end

@implementation LMCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //创建表
        self.lmTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-kNavHeight-kListBarH)];
        [self addSubview:self.lmTableView];
        
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    
}
-(void)setIdStr:(NSString *)idStr
{
    _idStr = idStr;
    NSLog(@"%@",idStr);
    self.lmTableView.backgroundColor = RGBColor(arc4random()%255, arc4random()%255, arc4random()%255);
}
@end
