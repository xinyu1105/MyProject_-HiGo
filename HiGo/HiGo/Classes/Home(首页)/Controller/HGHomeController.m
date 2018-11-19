//
//  HGHomeController.m
//  HiGo
//
//  Created by Think_lion on 15/7/25.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGHomeController.h"
#import "HGTitleView.h"

#import "HGSpecialController.h"
#import "HGFindController.h"
#import "HGChoiceController.h"
#import "ActivityViewController.h"

@interface HGHomeController ()<UIScrollViewDelegate,HGTitleViewDelegate>
@property (nonatomic,strong) NSMutableArray *childViewsArray;
@property (nonatomic,strong) UIScrollView *scrollView;
//@property (nonatomic,weak) HGTitleView *titView;
@property (nonatomic,strong) HGTitleView *titView;
@end

@implementation HGHomeController

//懒加载
-(NSMutableArray *)childViewsArray{
    if(!_childViewsArray){
        _childViewsArray=[NSMutableArray array];
    }
    return _childViewsArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.添加右边导航栏上面的点击按钮
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithIcon:@"search02" highIcon:nil target:self action:@selector(searchGoods)];
    //2.添加自定义的titleView(3个button)
    [self setupTitleView];
    //3.添加滚动视图
    [self setupScroll];
    
}
#pragma mark  添加titleview视图

-(void)setupTitleView{
    /*
    self.titView =[[HGTitleView alloc]init];
   // tv.backgroundColor=[UIColor redColor];
    tv.delegate=self;
    tv.frame=CGRectMake(0, 0, 200, 30);
    self.navigationItem.titleView=tv;
    self.titView=tv;
    */
    self.titView =[[HGTitleView alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    _titView.delegate=self;
    self.navigationItem.titleView = _titView;
}

#pragma mark 添加titleView的代理方法
-(void)titleView:(HGTitleView *)titleView scrollToIndex:(NSInteger)tagIndex{
    
    //????与下面几句代码等效(确定scrollView的偏移量)

    [self.scrollView scrollRectToVisible:CGRectMake(ScreenWidth*tagIndex, 0, self.view.width, self.view.height) animated:YES];
    
//    CGPoint offset = CGPointZero;
//    offset.x = ScreenWidth *tagIndex;
//    self.scrollView.contentOffset = offset;
}



#pragma mark 添加滚动视图
-(void)setupScroll{
    
    //添加三个子视图控制器
    
    //1.精选控制器
    HGChoiceController *choice=[[HGChoiceController alloc]init];
    [self addChildViewController:choice];
    //2.发现控制器
    HGFindController *find=[[HGFindController alloc]init];
    [self addChildViewController:find];
    //3.专场控制器
    HGSpecialController *special=[[HGSpecialController alloc]init];
    //4.活动控制器
    ActivityViewController *activity = [[ActivityViewController alloc]init];
    [self addChildViewController:special];
    
    //这几个自控制器的view添加到数组中
    [self.childViewsArray addObject:choice.view];
    [self.childViewsArray addObject:find.view];
    [self.childViewsArray addObject:special.view];
   
    [self.childViewsArray addObject:activity.view];
    /*
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    for(int i=0;i<self.childViewsArray.count;i++){

        CGFloat childVX=ScreenWidth*i;
        UIView *childV=self.childViewsArray[i];
        childV.frame=CGRectMake(childVX, 0, ScreenWidth, self.view.height);
        [scrollView addSubview:childV];
    }
    
    //设置滚动的属性
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.pagingEnabled=YES;
    scrollView.contentSize=CGSizeMake(ScreenWidth*3, 0);
    scrollView.bounces=NO;
    self.scrollView=scrollView;
    
    */
    
    self.scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scrollView.delegate=self;
    //设置滚动的属性
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.pagingEnabled=YES;
    _scrollView.contentSize=CGSizeMake(ScreenWidth * self.childViewsArray.count, 0);
    _scrollView.bounces=NO;
    [self.view addSubview:_scrollView];
    
    //把各个子视图控制器的view添加到scrollView上
    for(int i = 0; i<self.childViewsArray.count; i++){
        
        UIView *childV=self.childViewsArray[i];
        childV.frame=CGRectMake(ScreenWidth * i, 0, ScreenWidth, self.view.height);
        [self.scrollView addSubview:childV];
    }
}
/////
//为什么默认状态下选中的是第一个控制器"精选"????
//因为先走scrollViewDidScroll这个方法,默认状态下scrollView的偏移量为0,所以标记第一个button"精选"

//一进来就会走的方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
//    NSLog(@"%f",scrollView.contentOffset.x);
    //下(scrollView的左右滑动)与上(titleView上的button的左右滑动)的关联
    if(scrollView.contentOffset.x/ScreenWidth==0){
        [self.titView wanerSelected:0];
    }else if(scrollView.contentOffset.x/ScreenWidth==1){
        [self.titView wanerSelected:1];
    }else if(scrollView.contentOffset.x/ScreenWidth==2){
        [self.titView wanerSelected:2];
    }else if(scrollView.contentOffset.x/ScreenWidth==3){
        [self.titView wanerSelected:3];
    }
    //1
    NSLog(@"1111");
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"2222");
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"3333");
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"4444");
}


-(void)searchGoods
{
    NSLog(@"搜索按钮");
}

@end
