//
//  ViewController.m
//  SclloviewAD
//
//  Created by hao on 16/5/19.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "ViewController.h"
#import "QuAD.h"
#import "QuViewController.h"
@interface ViewController ()
{
    QuViewController *view;
    UIView *backView;
}
@property(nonatomic,strong) QuAD *ad;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    

    
    
}
- (IBAction)点击:(id)sender {
    
    [UIView animateWithDuration:2 animations:^{
        backView = [[UIView alloc]initWithFrame:self.view.bounds];

        backView.backgroundColor = [UIColor colorWithRed:(50/255.0f) green:(50/255.0f) blue:(50/255.0f) alpha:0.7f];
        
        
        [self.view.window addSubview:backView];
        
    } completion:^(BOOL finished) {
        
        backView.alpha = 1.0f;
    }];

    [UIView beginAnimations:@"HideArrow" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelay:1.0];
    backView.alpha = 1.0;
    [UIView commitAnimations];
    
    
    
    
    
}



- (IBAction)goAd:(id)sender {
    self.ad = [[QuAD alloc]init];
    self.ad.alpha = 0.0f;
    //开始动画
    [UIView beginAnimations:@"doflip" context:nil];
    //设置时常
    [UIView setAnimationDuration:0.3];
    //设置动画淡入淡出
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    //设置代理
    [UIView setAnimationDelegate:self];
    
    self.ad.alpha = 1.0f;
    
    //动画结束
    [UIView commitAnimations];
    
    [self.view.window addSubview:self.ad];
    self.ad.complat = ^(int *page){
        
        NSLog(@"----%d",page);
        
    };
    self.ad.dissplay = ^(NSString *abc){
    
        
        [self.ad removeFromSuperview];

    };

    self.ad.pushView = ^(NSString *bb){
        [self.ad removeFromSuperview];
//        view = [[QuViewController alloc]init];
//        [self.navigationController pushViewController:view animated:NO];
//        [self.navigationController prepareForSegue:@"two" sender:self];
        

    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
