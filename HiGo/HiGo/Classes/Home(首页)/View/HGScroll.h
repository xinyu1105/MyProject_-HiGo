//
//  HGScroll.h
//  HiGo
//
//  Created by Think_lion on 15/7/26.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import <UIKit/UIKit.h>
#warning 轮播图 ScrollView
@class HGScroll;
@protocol HGScrollDelegate <NSObject>

@optional

-(void)scrollClick:(HGScroll*)click clickIndex:(NSInteger)clickIndex;
@end

@interface HGScroll : UIView

@property (nonatomic,weak) id<HGScrollDelegate> delegate;

@end
