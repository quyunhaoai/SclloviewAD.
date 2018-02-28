//
//  QuAD.h
//  SclloviewAD
//
//  Created by hao on 16/5/19.
//  Copyright © 2016年 hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuAD : UIView<UIScrollViewDelegate>
@property(copy,nonatomic) void (^complat)(int *page);
@property(copy,nonatomic) void (^dissplay)(NSString *content);
@property(copy,nonatomic) void (^pushView)(NSString *content);
@end
