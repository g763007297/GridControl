//
//  GridControlViewController.m
//  Gridcontrol
//
//  Created by tusm on 16/2/19.
//  Copyright © 2016年 tusm. All rights reserved.
//

#import "GridControlViewController.h"
#import "GridManagerView.h"

@interface GridControlViewController ()<GridManageDelegate>

@property (nonatomic, strong) GridManagerView *gridControl;

@end

@implementation GridControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightTextColor];
    _gridControl = [[GridManagerView alloc] initWithframe:CGRectMake(0, 0, 320, 480) withCanEdit:YES];
    [_gridControl setItemWidth:50 withItemHeight:60 withRowMaxCount:4 ];
    _gridControl.manageDelegate = self;
    [self.view addSubview:_gridControl];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**添加按钮点击代理*/
- (void)addItemButtonAction{
    for (int i =0 ; i<100; i++) {
        UIImage *image = [UIImage imageNamed:@"gridcontrol_add"];
        [_gridControl addItemWithImage:image];
    }
}

/**单击代理*/
- (void)gridItemDidClickedWithIndex:(NSInteger)index{
    
}

/*删除代理*/
- (void)gridItemDidDeleteWithIndex:(NSInteger)index{
    
}

@end
