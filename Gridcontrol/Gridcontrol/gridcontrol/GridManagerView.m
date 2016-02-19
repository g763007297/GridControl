//
//  GridManagerView.m
//  Gridcontrol
//
//  Created by tusm on 16/2/19.
//  Copyright © 2016年 tusm. All rights reserved.
//

#import "GridManagerView.h"

static CGFloat sItemWidth = 90.0f;   //图片的宽度
static CGFloat sItemHeight = 90.0f; //图片的高度

static CGFloat const sViewTop = 10.0f;//距离顶部的高度

static float sItemColumnMargin = 10.0f;//列距

static NSInteger sCommunityMaxCount = 3;    //每行显示的最大数

static BOOL _canEdit = YES;

@interface GridManagerView()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation GridManagerView

- (id)initWithframe:(CGRect)rect withCanEdit:(BOOL)canEdit{
    self = [super initWithFrame:rect];
    if (self) {
        _canEdit = canEdit;
    }
    return self;
}

- (void)setItemWidth:(float)width withItemHeight:(float)hight withRowMaxCount:(NSInteger)maxCount{
    sItemWidth = width;
    sItemHeight = hight;
    sCommunityMaxCount = maxCount;
    sItemColumnMargin = (CGRectGetWidth(self.frame)-width * maxCount)/(maxCount +1);
    sItemRowMargin = 10;
    [self onConfigure];
}

- (void)onConfigure{
    
    if (!_arrayItem) {
        _arrayItem = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    addItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addItemButton setFrame:CGRectMake(sItemColumnMargin, sViewTop, sItemWidth, sItemHeight)];
    [addItemButton addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    [addItemButton setBackgroundImage:[UIImage imageNamed:@"gridcontrol_add"] forState:UIControlStateNormal];
    [_scrollView addSubview:addItemButton];
}

#pragma mark - UIButton - 编辑

- (void)buttonDeleteItemAction:(id)sender{
    if ([sender isSelected]) {
        [sender setSelected:NO];
    }else{
        [sender setSelected:YES];
    }
    if (isEditing) {
        for (GridViewControl *item in _arrayItem) {
            [item disableEditing];
        }
        [addItemButton setHidden:NO];
        isEditing = NO;
    } else {
        for (GridViewControl *item in _arrayItem) {
            [item enableEditing];
        }
        [addItemButton setHidden:YES];
        isEditing = YES;
    }
}

#pragma mark －buttonAction

- (void)addImage:(id)sender {
    if (isEditing) {
        for (GridViewControl *item in _arrayItem) {
            [item disableEditing];
        }
        isEditing = NO;
    } else {
        if ([self.manageDelegate respondsToSelector:@selector(addItemButtonAction)]) {
            [self.manageDelegate addItemButtonAction];
        }
    }
}

#pragma mark - 添加图片

- (void)addItemWithImage:(UIImage *)image
{
    GridViewControl *itemControl;
    
    CGFloat x = (_arrayItem.count%sCommunityMaxCount)*(sItemWidth+sItemColumnMargin)+sItemColumnMargin;
    CGFloat y = (_arrayItem.count/sCommunityMaxCount)*(sItemHeight+sItemRowMargin) + sViewTop;
    
    itemControl = [[GridViewControl alloc] initWithFrame:CGRectMake(x, y, sItemWidth, sItemHeight) withImage:image atIndex:[_arrayItem count]-1];
    itemControl.delegate = self;
    [_arrayItem addObject:itemControl];
    [_scrollView addSubview:itemControl];
    
    CGFloat a = ((_canEdit?(_arrayItem.count +1):[_arrayItem count])/sCommunityMaxCount)*(sItemHeight+sItemRowMargin) + sViewTop;
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), a+sItemHeight+sViewTop);
    [self onShowTempSubViews];
}

#pragma mark - GridControlDelegate

- (void)gridItemDidClicked:(GridViewControl *)gridItem atIndex:(NSInteger)index
{
    if ([self.manageDelegate respondsToSelector:@selector(gridItemDidClickedWithIndex:)]) {
        [self.manageDelegate gridItemDidClickedWithIndex:index];
    }
}

- (void)gridItemDidDeleted:(GridViewControl *)gridItem atIndex:(NSInteger)index
{
    __block GridViewControl *item = [_arrayItem objectAtIndex:index];
    
    [_arrayItem removeObjectAtIndex:index];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect lastFrame = item.frame;
        CGRect curFrame;
        for (int i=(int)index; i < [_arrayItem count]; i++) {
            GridViewControl *temp = [_arrayItem objectAtIndex:i];
            curFrame = temp.frame;
            [temp setFrame:lastFrame];
            lastFrame = curFrame;
            [temp setIndex:i];
        }
        addItemButton.frame = CGRectMake(lastFrame.origin.x, lastFrame.origin.y, sItemWidth, sItemHeight);
    } completion:^(BOOL finished) {
        [item removeFromSuperview];
        item = nil;
        if ([_arrayItem count] ==0) {
            isEditing = NO;
            addItemButton.hidden = NO;
        }
    }];
    
    CGFloat a = ((_canEdit?(_arrayItem.count +1):[_arrayItem count])/sCommunityMaxCount)*(sItemHeight+sItemRowMargin) + sViewTop;
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), a+sItemHeight+sViewTop);
    
    if ([self.manageDelegate respondsToSelector:@selector(gridItemDidDeleteWithIndex:)]) {
        [self.manageDelegate gridItemDidDeleteWithIndex:index];
    }
}

- (void)gridItemDidLongPressed:(GridViewControl *)gridItem atIndex:(NSInteger)index
{
    if (!_canEdit) {
        return;
    }
    if (isEditing) {
        for (GridViewControl *item in _arrayItem) {
            [item disableEditing];
        }
        [addItemButton setHidden:NO];
        isEditing = NO;
    } else {
        for (GridViewControl *item in _arrayItem) {
            [item enableEditing];
        }
        [addItemButton setHidden:YES];
        isEditing = YES;
    }
}

- (void)onShowTempSubViews
{
    for (int i=0; i<=[_arrayItem count]; i++) {
        if (_canEdit) {
            [addItemButton setHidden:NO];
        }
        if (i == [_arrayItem count]) {
            CGRect rect = addItemButton.frame;
            rect.origin.x = ((_arrayItem.count)%sCommunityMaxCount)*(sItemWidth+sItemColumnMargin)+sItemColumnMargin;
            rect.origin.y = ((_arrayItem.count)/sCommunityMaxCount)*(sItemHeight+sItemRowMargin) + sViewTop;
            addItemButton.frame = rect;
        }
    }
}

@end
