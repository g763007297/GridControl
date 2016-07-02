# GridControl
多图片排列，支持点击，长按编辑，批量添加

## Basic usage
(参见demo)
1.下载 代码zip包 解压。

2.将 GQGridControlManager 内的源文件添加(拖放)到你的工程。

3.在需要使用的文件中引用头文件 GQGridManagerView.h。

4:代码示例:

``` objc

视图初始化:
   _gridControl = [[GridManagerView alloc] initWithframe:CGRectMake(0, 0, 320, 480) withCanEdit:YES];
    [_gridControl setItemWidth:50 withItemHeight:60 withRowMaxCount:4 ];
   _gridControl.manageDelegate = self;
   [self.view addSubview:_gridControl];
    
添加代理:
@required
   /**添加按钮点击代理*/
   - (void)addItemButtonAction;
   
@optional
   /**单击代理*/
   - (void)gridItemDidClickedWithIndex:(NSInteger)index;
   /*删除代理*/
   - (void)gridItemDidDeleteWithIndex:(NSInteger)index;

```

##Support

欢迎指出bug或者需要改善的地方，欢迎提出issues，或者联系qq：763007297， 我会及时的做出回应。
