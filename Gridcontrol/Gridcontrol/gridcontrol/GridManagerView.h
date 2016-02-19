//
//  GridManagerView.h
//  Gridcontrol
//
//  Created by tusm on 16/2/19.
//  Copyright © 2016年 tusm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridViewControl.h"

@protocol GridManageDelegate <NSObject>

@optional
/**添加按钮点击代理*/
- (void)addItemButtonAction;
/**单击代理*/
- (void)gridItemDidClickedWithIndex:(NSInteger)index;
/*删除代理*/
- (void)gridItemDidDeleteWithIndex:(NSInteger)index;

@end

@interface GridManagerView : UIView<GridControlDelegate,UIScrollViewDelegate>{
    UIButton *addItemButton;//添加按钮
    NSMutableArray *_arrayItem;//用于管理成员
    BOOL isEditing;//是否为编辑状态
    float sItemRowMargin;//行距
    NSInteger rowMaxCount;
}

- (id)initWithframe:(CGRect)rect withCanEdit:(BOOL)canEdit;

- (void)setItemWidth:(float)width withItemHeight:(float)hight withRowMaxCount:(NSInteger)maxCount;

- (void)addItemWithImage:(UIImage *)image;

@property (nonatomic, assign) id<GridManageDelegate>manageDelegate;

@end
