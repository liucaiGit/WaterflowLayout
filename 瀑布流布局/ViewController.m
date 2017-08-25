//
//  ViewController.m
//  瀑布流布局
//
//  Created by liucai on 2017/8/14.
//  Copyright © 2017年 liucai. All rights reserved.
//

#import "ViewController.h"
#import "WaterflowLayout.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface CustomCollectionCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *contentLabel;
@end

@implementation CustomCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.contentLabel = [UILabel new];
        self.contentLabel.textColor = [UIColor redColor];
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        self.contentLabel.font = [UIFont systemFontOfSize:16];
        self.contentLabel.frame = CGRectMake(0, 0, 50, 20);
        self.contentLabel.center = self.contentView.center;
        
        [self addSubview:self.contentLabel];
    }
    return self;
}

@end

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *subCollectionV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    WaterflowLayout *waterFlowLayout = [[WaterflowLayout alloc] init];
    waterFlowLayout.lineSpacing =  5.f;
    waterFlowLayout.interitemSpacing = 5.f;
    waterFlowLayout.sectionInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    waterFlowLayout.numberOfColums = 3;
    waterFlowLayout.calculateitemHBlock = ^CGFloat(CGFloat itemW, NSIndexPath *indexPath) {
        return arc4random_uniform(itemW) + 40;
    };
    
    self.subCollectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, CGRectGetHeight(self.view.bounds)) collectionViewLayout:waterFlowLayout];
    self.subCollectionV.backgroundColor = [UIColor whiteColor];
    self.subCollectionV.showsVerticalScrollIndicator = NO;
    
    self.subCollectionV.delegate = self;
    self.subCollectionV.dataSource = self;
    
    //注册单元格
    [self.subCollectionV registerClass:[CustomCollectionCell class] forCellWithReuseIdentifier:@"CustomCollectionCell"];
    
    [self.view addSubview:self.subCollectionV];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - <UICollectionView delegate & datasourse>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    cell.contentLabel.text = [NSString stringWithFormat:@"%li",indexPath.item];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
