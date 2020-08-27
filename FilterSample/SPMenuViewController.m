//
//  ViewController.m
//  FilterSample
//
//  Created by 王杰 on 2020/8/26.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import "SPMenuViewController.h"
#import "GPUImage.h"
#import "SPDisplayViewController.h"

@interface SPMenuViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *menuList;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation SPMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.menuList];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arr = [self.dataArray[indexPath.section] objectForKey:@"menuCategory"];
    SPDisplayViewController *vc = [[SPDisplayViewController alloc] initWithTitle:arr[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = [self.dataArray[section] objectForKey:@"menuName"];
    return title;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = [self.dataArray[section] objectForKey:@"menuCategory"];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *arr = [self.dataArray[indexPath.section] objectForKey:@"menuCategory"];
    cell.textLabel.text = arr[indexPath.row];
    return cell;
}

#pragma mark -

- (UITableView *)menuList {
    if (!_menuList) {
        _menuList = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_menuList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _menuList.delegate = self;
        _menuList.dataSource = self;
    }
    return _menuList;
}

- (NSArray *)dataArray {
    if (!_dataArray) {

        _dataArray = @[
            @{
                @"menuName" : @"🔨 颜色调校",
                @"menuCategory" : @[@"亮度", @"曝光度", @"对比度", @"饱和度", @"伽马线",@"反色",@"褐色(怀旧)",@"色阶",@"色彩直方图",@"RGB",@"色调曲线",@"单色",@"不透明度",@"提亮阴影"]
            },
            @{
                @"menuName" : @"🔨 视觉效果",
                @"menuCategory" : @[@"素描", @"卡通", @"细腻卡通", @"桑原",@"马赛克", @"像素化",@"同心圆像素化",@"交叉线阴影",@"晕影", @"漩涡", @"凸面镜", @"凹面镜", @"水晶球",@"球型折射", @"色调分离", @"CGA色彩滤镜",@"柏林燥点", @"3x3卷积", @"浮雕", @"像素圆点花样",@"点染"]
            }
        ];
    }
    return _dataArray;
}


@end
