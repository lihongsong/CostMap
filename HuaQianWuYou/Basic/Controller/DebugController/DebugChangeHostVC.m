//
//  DebugChangeHostVC.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/4.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "DebugChangeHostVC.h"
#import "DebugSegmentedControl.h"
#import "UtilitiesDefine.h"
#import "PlistManager.h"
#import "DebugCollectionViewCell.h"
#import "PhotoCollectionReusableView.h"
#import "CollectionFooterView.h"

// 初始化数据
#define InitObj @"0"
// 当前状态
#define StatusObj @"1"

////section 头title
//#define SectionTitle @"SectionTitle"

static NSString *cellID = @"collectionCellID";
@interface DebugChangeHostVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SelectApiDelegate,ApiSelectFooterDelegate>

@property(nonatomic,strong)DebugSegmentedControl *segmentedControl;
@property(nonatomic,strong)UICollectionView *debugCollectionView;

@property(nonatomic,strong)PlistManager *manager;

@end

@implementation DebugChangeHostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 获取 数据
    [self getDataSource];
    
    // 设置 分段控制器
    [self setSegmentedControl];
    
    // 设置 collectionview
    [self setCollectionView];
    // 设置底部试图
    [self setCollectionFooter];
}

- (void)getDataSource{
    self.manager = [PlistManager plistInit:^(ApiType type){
        [self.debugCollectionView reloadData];
    }];
    
}

- (void)setSegmentedControl{
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"测试服",@"预正式服",@"正式服",nil];
    DebugSegmentedControl *segmentedControl = [[DebugSegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.selectedSegmentIndex = self.manager.apiType;
    [self.view addSubview:segmentedControl];
    
    //添加事件
    [segmentedControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
}

- (void)setCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 40;
    flowLayout.headerReferenceSize = CGSizeMake(SWidth, 47);
    self.debugCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 80,SWidth , SHeight - 20 -40) collectionViewLayout:flowLayout];
    self.debugCollectionView.backgroundColor = [UIColor whiteColor];
    self.debugCollectionView.delegate = self;
    self.debugCollectionView.dataSource = self;
     [self.debugCollectionView registerNib:[UINib nibWithNibName:@"DebugCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    [self.debugCollectionView registerNib:[UINib nibWithNibName:@"PhotoCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PhotoCollectionReusableView"];
    [self.view addSubview:self.debugCollectionView];
}

- (void)setCollectionFooter{
    CollectionFooterView *footer = [[CollectionFooterView alloc]initWithFrame:CGRectMake(0, SHeight - 40, SWidth, 40)];
    footer.delegate = self;
    [self.view addSubview:footer];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.manager getSectionCount];
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionReusableView *headerView = [self.debugCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PhotoCollectionReusableView" forIndexPath:indexPath];
    headerView.titleLabel.text = [self.manager getSectionTitle:indexPath.section];
    return headerView;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        return [[self.manager getRowsAtSection:section] count];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    DebugCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.delegate = self;
    [self setCellButton:cell indexPath:indexPath];
    return cell;
}

- (void)setCellButton:(DebugCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    NSInteger currenTag = 0;
    currenTag = [self.manager getCurrentTag:indexPath.section];
    cell.stateButton.tag = (indexPath.section + 1) * 10 + indexPath.row;
    if (indexPath.row == currenTag) {
        cell.stateButton.selected = true;
        cell.stateButton.backgroundColor = [UIColor testSelectColor];
    }else{
        cell.stateButton.selected = false;
        cell.stateButton.backgroundColor = [UIColor testNormalColor];
    }
    [cell.stateButton setTitle:[self.manager getCellTitle:indexPath] forState:UIControlStateNormal];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SWidth - 30)/2.0, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
   
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)change:(UISegmentedControl *)sender{
    
    NSLog(@"测试");
    
    if (sender.selectedSegmentIndex == 0) {
        
        NSLog(@"1");
        self.manager.apiType = TestApiType;
        [self.debugCollectionView reloadData];
        
    }else if (sender.selectedSegmentIndex == 1){
        
        NSLog(@"2");
        self.manager.apiType = TestReleaseApiType;
        [self.debugCollectionView reloadData];
        
    }else if (sender.selectedSegmentIndex == 2){
         NSLog(@"3");
        self.manager.apiType = ReleaseApiType;
        [self.debugCollectionView reloadData];
    }
}

#pragma mark cell delegate  方法
- (void)selectApi:(NSInteger)tag{
    NSInteger section = tag/10 - 1;
    [self.manager refreshSelectData:tag block:^{
        [self.debugCollectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
    }];
}

- (void)footerJumpClick{
    self.rootStartVC();
}

- (void)footerConfirmClick{
    [self.manager saveApiConfig];
    self.rootStartVC();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
