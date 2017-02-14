//
//  XHFeatruedVC.m
//  XHDemo
//
//  Created by moxuyou on 2017/1/20.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHFeatruedVC.h"

static NSString *cellId = @"XHFeatruedVCCell";
@interface XHFeatruedVC ()<UITableViewDelegate,UITableViewDataSource>

/**  */
@property (weak, nonatomic)UITableView *tableView;
/**  */
@property (strong, nonatomic) NSMutableArray *dataArray;
/** navigationBar左边的按钮 */
@property (weak, nonatomic)UIButton *leftButton;
/** navigationBar右边的按钮 */
@property (weak, nonatomic)UIButton *rightButton;
@end

@implementation XHFeatruedVC

#pragma mark - 懒加载

- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObject:@"音乐播放器"];
        [_dataArray addObject:@"Moxuyou--B"];
        [_dataArray addObject:@"Moxuyou--C"];
        [_dataArray addObject:@"Moxuyou--D"];
        [_dataArray addObject:@"Moxuyou--E"];
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
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    //初始化导航栏
    [self setUpNavigationBar];
    
    //创建tableView
    [self tableView];
}


#pragma mark - 初始化
- (void)setUpNavigationBar{
    
    //添加左边按钮
    [self.navigationBar addNavigationBarLeftButton:@"左边按钮"];
    //添加右边按钮
    [self.navigationBar addNavigationBarRightButton:@"右边按钮"];
    //添加标题
    [self.navigationBar addNavigationBarTitile:@"零碎知识总结"];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

#pragma mark - Action
//点击标题栏事件
- (void)tapMiddleLabelEvent:(id)sender{
    
    NSLog(@"%s", __func__);
}
//点击左按钮事件
-(void)clickCustomNavigationBarLeftButtonEvent:(id)sender{
    
    NSLog(@"%s", __func__);
}
//点击右按钮事件
-(void)clickCustomNavigationBarRightButtonEvent:(id)sender{
    
    NSLog(@"%s", __func__);
}

@end
