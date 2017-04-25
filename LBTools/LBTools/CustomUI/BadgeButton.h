//
//  BadgeButton.h
//  WhiteSoldier
//
//  Created by ling on 16/11/11.
//  Copyright © 2016年 ubtech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)();

@interface BadgeButton : UIView

@property (nonatomic, copy) ClickBlock clickBlock;
- (instancetype)initWithFrame:(CGRect)frame Target:(id)target ClickBlock:(ClickBlock)block;
- (void)showRedView;
- (void)hideRedView;
@end
