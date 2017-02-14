//
//  XHMusicListVC.m
//  XHDemo
//
//  Created by moxuyou on 2017/2/14.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHMusicListVC.h"
#import "XHMusicModel.h"
#import "XHMusicPlayVC.h"

static NSString *cellId = @"XHMusicListVCCell";
@interface XHMusicListVC ()<UITableViewDelegate,UITableViewDataSource>
/**  */
@property (weak, nonatomic)UITableView *tableView;
/**  */
@property (strong, nonatomic) NSMutableArray *dataArray;
/** navigationBar左边的按钮 */
@property (weak, nonatomic)UIButton *leftButton;
/** navigationBar右边的按钮 */
@property (weak, nonatomic)UIButton *rightButton;

@end

@implementation XHMusicListVC


#pragma mark - 懒加载

- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Musics.plist" ofType:nil];
        
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModel = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            
            XHMusicModel *model = [XHMusicModel musicModelWithDict:dict];
            [arrayModel addObject:model];
        }
        _dataArray = arrayModel;
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
    [self.navigationBar addNavigationBarLeftButton:@"返回"];
    
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
    
    XHMusicModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    cell.imageView.image = [UIImage imageNamed:model.singerIcon];
    
    return cell;
}

#pragma mark - 代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XHMusicPlayVC *vc = [[XHMusicPlayVC alloc] init];
    vc.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 66.66;
}

#pragma mark - Action

//点击左按钮事件
-(void)clickCustomNavigationBarLeftButtonEvent:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
