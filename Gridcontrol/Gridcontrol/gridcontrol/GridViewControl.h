//
//  GridViewControl.h
//  WeatherInZhuhai
//
//  Created by tb on 14-9-5.
//  Copyright (c) 2014年 tb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GridViewControl;

@protocol GridControlDelegate<NSObject>
@required
- (void)gridItemDidClicked:(GridViewControl *)gridItem atIndex:(NSInteger)index;
- (void)gridItemDidDeleted:(GridViewControl *)gridItem atIndex:(NSInteger)index;
- (void)gridItemDidLongPressed:(GridViewControl *)gridItem atIndex:(NSInteger)index;
@end

@interface GridViewControl : UIControl

@property (nonatomic, assign) id<GridControlDelegate> delegate;
@property (nonatomic) BOOL isEditing;   //是否是编辑状态
@property (nonatomic) NSInteger index;  //标记当前ItemID

- (id)initWithFrame:(CGRect)frame withImage:(UIImage *)image atIndex:(NSInteger)index;

- (void)enableEditing;  //启动编辑
- (void)disableEditing; //取消编辑

@end
