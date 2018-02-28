//
//  QuAD.m
//  SclloviewAD
//
//  Created by hao on 16/5/19.
//  Copyright © 2016年 hao. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#import "QuViewController.h"
#import "ViewController.h"
#import "QuAD.h"
@interface QuAD()

//容器
@property(nonatomic,strong)UIScrollView     *scrollView;
/* 滚动圆点 **/
@property(nonatomic,strong)UIPageControl    *pageControl;
/* 定时器 **/
@property(nonatomic,strong)NSTimer          *animationTimer;
/* 当前index **/
@property(nonatomic,assign)NSInteger        currentPageIndex;
/* 所有的图片数组 **/
@property(nonatomic,strong)NSMutableArray   *imageArray;
/* 当前图片数组，永远只存储三张图 **/
@property(nonatomic,strong)NSMutableArray   *currentArray;



@end


@implementation QuAD
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    return [self initWithFrame:SCREEN_BOUNDS];
}


//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        [self render];
//    }
//    return self;
//}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self peizi];
        self.backgroundColor =[UIColor colorWithRed:(48/255.0f) green:(48/255.0f) blue:(48/255.0f) alpha:0.9f];
    }
    return self;
}
-(void)peizi{
    CGRect frame = self.bounds;
    frame.origin.y = 100;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.scrollView.contentMode = UIViewContentModeCenter;
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width*3, self.bounds.size.height-100);
    self.scrollView.delegate = self;
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.scrollView.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:.7f];
    [self addSubview:self.scrollView];
    
    //设置分页显示的圆点
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.alpha = 0.8;
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.numberOfPages = 3;
    _pageControl.currentPage = 0;
    _pageControl.frame = CGRectMake(0, 0, 100, 200);
    [self addSubview:_pageControl];
    
    //点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tapGesture];


//    CGFloat x = 3 * self.scrollView.frame.size.width;
//
//    self.scrollView.contentOffset = CGPointMake(x, 0);
    
    CGFloat scrollViewW = self.scrollView.frame.size.width;
    //    图片的宽

//    CGFloat imageW = self.scrollView.frame.size.width;

    CGFloat imageW = self.scrollView.frame.size.width-100;


    //    图片高

//    CGFloat imageH = self.scrollView.frame.size.height;
    CGFloat imageH = self.frame.size.height-300;

    //    图片的Y

//    CGFloat imageY = 0;
    CGFloat imageY = (self.frame.size.height -imageH)/2-100;

    //    图片中数

    NSInteger totalCount = 3;

    //   1.添加5张图片

    for (int i = 0; i < totalCount; i++) {

        UIImageView *imageView = [[UIImageView alloc] init];

        //        图片X

        CGFloat imageX = i * scrollViewW + (scrollViewW - imageW)/2 ;

        //        设置frame
                 imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
         //        设置图片
                 NSString *name = [NSString stringWithFormat:@"%d.jpg", i + 1];
                 imageView.image = [UIImage imageNamed:name];
        
         //        隐藏指示条
                 self.scrollView.showsHorizontalScrollIndicator = NO;
        
                 [self.scrollView addSubview:imageView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = imageView.frame;
        
        [button addTarget:self action:@selector(dianji) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        
    }

    CGPoint center = _scrollView.center;
    center.y = imageY +imageH+120;
    _pageControl.center = center;
    
    UIButton *cloes = [UIButton buttonWithType:UIButtonTypeCustom];
    [cloes setTitle:@"关闭" forState:UIControlStateNormal];
    [cloes setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    cloes.frame = CGRectMake(scrollViewW-120, 20, 80, 50);
    [cloes addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cloes];
    
    UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
    [more setTitle:@"更多" forState:UIControlStateNormal];
    [more setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    more.backgroundColor = [UIColor blue];
    more.frame = CGRectMake(scrollViewW-220, 20, 80, 50);
    [more addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:more];
}
-(void)moreAction{
    NSString *b = [[NSString alloc]initWithFormat:@"bbbb"];
    self.pushView(b);
    [self removeFromSuperview];
//    QuViewController *view= [[QuViewController alloc]init];
//    UIViewController *view2  = [[UIViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:view2];
//    [nav pushViewController:view animated:YES];
}
-(void)tap{
    [UIView beginAnimations:@"outAnimat" context:nil];
    //设置时常
    [UIView setAnimationDuration:0.3];
    //设置动画淡入淡出
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    //设置代理
    [UIView setAnimationDelegate:self];
    
    self.alpha = 0.0f;
    
    //动画结束
    [UIView commitAnimations];
    NSLog(@"点击事件！");
    NSString *aa = @"点击事件！";
//    self.dissplay(aa);
}
-(void)dianji{
    NSLog(@"button touchUp!");
}
-(void)closeAction
{
    NSString *aa = @"点击事件！";
    //   开始动画
    [UIView beginAnimations:@"outAnimat" context:nil];
    //设置时常
    [UIView setAnimationDuration:0.3];
    //设置动画淡入淡出
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    //设置代理
    [UIView setAnimationDelegate:self];
    
    self.alpha = 0.0f;

    //动画结束
    [UIView commitAnimations];
//    self.dissplay(aa);

    NSLog(@"close!");
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    [self.animationTimer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //    [self.animationTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.animationDuration]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollviewW =  scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
   
    int page = (x + scrollviewW / 2) /  scrollviewW;
 
    self.pageControl.currentPage = page;

//    int contentOffsetX = scrollView.contentOffset.x;
//    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
//        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
//        _pageControl.currentPage = _currentPageIndex;
//        [self configContentViews];
//    }
//    if(contentOffsetX <= 0) {
//        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
//        _pageControl.currentPage = _currentPageIndex;
//        [self configContentViews];
//    }
//    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
        self.complat(self.pageControl.currentPage);
}

@end
