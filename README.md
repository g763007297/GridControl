# GridControl
多图片排列，支持点击，长按编辑，批量添加

视图初始化:
   _gridControl = [[GridManagerView alloc] initWithframe:CGRectMake(0, 0, 320, 480) withCanEdit:YES];
    [_gridControl setItemWidth:50 withItemHeight:60 withRowMaxCount:4 ];
   _gridControl.manageDelegate = self;
   [self.view addSubview:_gridControl];
    
添加代理:
   /**添加按钮点击代理*/
   - (void)addItemButtonAction;
   /**单击代理*/
   - (void)gridItemDidClickedWithIndex:(NSInteger)index;
   /*删除代理*/
   - (void)gridItemDidDeleteWithIndex:(NSInteger)index;
