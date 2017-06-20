//
//  BadgeButton.m
//  WhiteSoldier
//
//  Created by ling on 16/11/11.
//  Copyright © 2016年 ubtech. All rights reserved.
//

#import "BadgeButton.h"
#import "Masonry.h"

#define animateDelay 0.15   //默认动画执行时间
#define defaultScale 0.9    //默认缩小的比率

@interface BadgeButton ()
@property (nonatomic,strong) UIView *redView;
@end

@implementation BadgeButton

#pragma mark Public Method
- (instancetype)initWithFrame:(CGRect)frame Target:(id)target ClickBlock:(ClickBlock)block {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubViews:(ClickBlock)block];
    }
    return self;
}

- (void)showRedView {
    if (!_redView.hidden) return;
    _redView.hidden = NO;
}
- (void)hideRedView {
    if (_redView.hidden) return;
    _redView.hidden = YES;
}

#pragma mark Private Method
- (void)pressedEvent:(BadgeButton *)btn {
    [UIView animateWithDuration:animateDelay animations:^{
        self.transform = CGAffineTransformMakeScale(defaultScale, defaultScale);
    }];
}

- (void)unpressedEvent:(BadgeButton *)btn {
    [UIView animateWithDuration:animateDelay animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        //执行动作响应
        if (self.clickBlock) {
            self.clickBlock();
        }
    }];
}

- (void)setupSubViews:(ClickBlock)block {
    self.backgroundColor = [UIColor clearColor];
    
    UIButton *clickBtn = [[UIButton alloc] init];
    clickBtn.layer.cornerRadius = 21;
    clickBtn.layer.masksToBounds = YES;
    [clickBtn setTitle:@"Task" forState:UIControlStateNormal];
    clickBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [clickBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [clickBtn setBackgroundImage:[UIImage imageNamed:@"timer_robot_header"] forState:UIControlStateNormal];
    [clickBtn addTarget:self action:@selector(pressedEvent:) forControlEvents:UIControlEventTouchDown];
    [clickBtn addTarget:self action:@selector(unpressedEvent:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    [self addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _redView = [[UIView alloc] init];
    _redView.layer.cornerRadius = 5;
    _redView.layer.masksToBounds = YES;
    _redView.backgroundColor = [UIColor redColor];
    [self addSubview:_redView];
    [_redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.top.equalTo(@0);
        make.right.equalTo(@0);
    }];
    
    self.clickBlock = block;
}

@end
