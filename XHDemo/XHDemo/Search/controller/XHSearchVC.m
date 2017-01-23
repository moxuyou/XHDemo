//
//  XHSearchVC.m
//  XHDemo
//
//  Created by moxuyou on 2017/1/20.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHSearchVC.h"
#import "XHSearchEdictVC.h"

static NSString *cellId = @"XHSearchVCCell";
@interface XHSearchVC ()<UITableViewDelegate,UITableViewDataSource>

/** 列表tableView */
@property (weak, nonatomic)UITableView *tableView;
/** navigationBar左边的按钮 */
@property (weak, nonatomic)UIButton *leftButton;
/** navigationBar右边的按钮 */
@property (weak, nonatomic)UIButton *rightButton;
/** tableView数据源 */
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation XHSearchVC

#pragma mark - 懒加载

- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObject:@"UIView动画A"];
        [_dataArray addObject:@"UIView动画B"];
        [_dataArray addObject:@"UIView动画C"];
        [_dataArray addObject:@"UIView动画D"];
        [_dataArray addObject:@"UIView动画E"];
        [_dataArray addObject:@"核心动画A"];
        [_dataArray addObject:@"核心动画B"];
        [_dataArray addObject:@"核心动画C"];
        [_dataArray addObject:@"核心动画D"];
        [_dataArray addObject:@"核心动画E"];
    }
    return _dataArray;
}

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navigationBarHeigth, SCR_WIDTH, SCR_HEIGHT - tabBarHeigth - navigationBarHeigth) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableFooterView = [[UIView alloc] init];
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
        [self.view addSubview:tableView];
        
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - 系统方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    //初始化导航栏
    [self setUpNavigationBar];
    
    //创建tableView
    [self tableView];
}

#pragma mark - 初始化

- (void)setUpNavigationBar{
    
    //屏蔽父类的自定义导航栏，采用系统的
    self.navigationBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
    //添加左边按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [leftButton setTitle:@"进入编辑" forState:UIControlStateNormal];
    [leftButton sizeToFit];
    self.leftButton = leftButton;
    [leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    //添加右边按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [rightButton setImage:[UIImage imageNamed:@"zx_searchbtn"] forState:UIControlStateNormal];
    self.rightButton = rightButton;
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    //添加标题
    UILabel *midLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    midLabel.text = @"编辑";
    midLabel.textColor = [UIColor grayColor];
    self.navigationItem.titleView = midLabel;
}
#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark - 代理

#pragma mark - Action
//左边按钮被点击
- (void)leftButtonClick{
    
    LXHLog(@"%s", __func__);
    XHSearchEdictVC *edictVc = [[XHSearchEdictVC alloc] init];
    [self.navigationController pushViewController:edictVc animated:YES];
}

//右边按钮被点击
- (void)rightButtonClick{
    
    LXHLog(@"%s", __func__);
    
}

@end
