//
//  XHSearchEdictVC.m
//  XHDemo
//
//  Created by moxuyou on 2017/1/23.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import "XHSearchEdictVC.h"
#import "XHEdictHeadView.h"

static NSString *cellId = @"XHSearchEdictVCCell";
@interface XHSearchEdictVC ()<UITableViewDelegate,UITableViewDataSource>

/** 列表tableView */
@property (weak, nonatomic)UITableView *tableView;
/** navigationBar右边的按钮 */
@property (weak, nonatomic)UIButton *rightButton;
/** 编辑状态 */
@property (assign, nonatomic)BOOL isEdict;
/** 数据源 */
@property (strong, nonatomic) NSMutableArray *dataArray;
/** tableView头部数据源 */
@property (strong, nonatomic) NSMutableArray *headViewArray;
@end

@implementation XHSearchEdictVC

#pragma mark - 懒加载

- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray array];
        
        for (int i = 0; i < 5; ++i) {
            NSMutableArray *tempArray = [NSMutableArray array];
            for (int j = 0; j < 10; ++j) {
                
                [tempArray addObject:[NSString stringWithFormat:@"%i--%i", i, j]];
            }
            [_dataArray addObject:tempArray];
        }
    }
    return _dataArray;
}

- (NSMutableArray *)headViewArray{
    
    if (_headViewArray == nil) {
        
        _headViewArray = [NSMutableArray array];
        for (int i = 0; i < self.dataArray.count; ++i) {
            
            XHEdictHeadView *headView = [[XHEdictHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
            headView.headLabel.text = [NSString stringWithFormat:@"   Moxuyou--%i", i];
            [_headViewArray addObject:headView];
        }
    }
    
    return _headViewArray;
}

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navigationBarHeigth, SCR_WIDTH, SCR_HEIGHT - tabBarHeigth - navigationBarHeigth) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
        [self.view addSubview:tableView];
        
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - 系统方法
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //初始化导航栏
    [self setUpNavigationBar];
    
    //初始化参数
    [self setUpXHSearchEdictVC];
}

#pragma mark - 初始化

- (void)setUpXHSearchEdictVC{
    
    self.isEdict = YES;
}

- (void)setUpNavigationBar{
    
    self.navigationController.navigationBar.backgroundColor = [UIColor purpleColor];
    self.navigationBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
    //添加右边按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rightButton sizeToFit];
    self.rightButton = rightButton;
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    //添加标题
    UILabel *midLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    midLabel.text = @"编辑页面";
    self.navigationItem.titleView = midLabel;
}
#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return ((NSArray *)self.dataArray[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    NSArray *dataArray = self.dataArray[indexPath.section];
    cell.textLabel.text = [NSString stringWithFormat:@"Moxuyou--%@", dataArray[indexPath.row]];
    
    return cell;
}

#pragma mark - 代理

//tableView头部视图
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return self.headViewArray[section];
}
//tableView头部视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

//tableViewCell被选中的时候
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *dataStr = self.dataArray[indexPath.section][indexPath.row];
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"编辑数据" message:@"请输入想要修改的内容" preferredStyle:UIAlertControllerStyleAlert];
    // 添加输入框 (注意:在UIAlertControllerStyleActionSheet样式下是不能添加下面这行代码的)
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Moxuyou--";
    }];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = dataStr;
    }];
    
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        LXHLog(@"取消按钮被点击");
    }]];
    
    __weak __typeof(self)weakSelf = self;
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textF1 = alertVc.textFields[0];
        UITextField *textF2 = alertVc.textFields[1];
        LXHLog(@"确定按钮被点击，输入框数据为%@%@", textF1.text, textF2.text);
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:weakSelf.dataArray];
        array[indexPath.section][indexPath.row] = [NSString stringWithFormat:@"%@%@", textF1.text, textF2.text];
        weakSelf.dataArray = array;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        
    }];
    
    [alertVc addAction:sureAction];
 
    [self presentViewController:alertVc animated:YES completion:nil];
}

// 设置编辑的样式.
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

// 默认状态只有是delete的时候可以左划出现删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //删除数据
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.dataArray];
    [tempArray[indexPath.section] removeObjectAtIndex:indexPath.row];
    // 将要消失的行加动画,消失画面变得柔和
    self.dataArray = tempArray;
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}
//自定义tableView编辑时候的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}

// tableview的移动
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.dataArray];
    //被操作的数据
    NSString *data = self.dataArray[sourceIndexPath.section][sourceIndexPath.row];
    
    [tempArray[sourceIndexPath.section] removeObjectAtIndex:sourceIndexPath.row];
    [tempArray[destinationIndexPath.section] insertObject:data atIndex:destinationIndexPath.row];
    self.dataArray = tempArray;
    
}

// 设置哪些行可以进行编辑,通过返回yes和no来判断.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isEdict) {
        return YES;
    }
    return NO;
}

// 设置哪些行可以进行移动,通过返回yes和no来判断.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}


#pragma mark - Action

//右边按钮被点击
- (void)rightButtonClick{
    
    LXHLog(@"%s", __func__);
    self.isEdict = !self.isEdict;
}

- (void)setIsEdict:(BOOL)isEdict{
    _isEdict = isEdict;
    
    [self.tableView setEditing:isEdict animated:YES];
    if (isEdict) {
        
        [self.rightButton setTitle:@"保存" forState:UIControlStateNormal];
    }else{
        
        [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    }
}


@end
