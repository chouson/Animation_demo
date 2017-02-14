//
//  UpDownView.m
//  Animation_demo
//
//  Created by xxdl_ccz on 17/1/8.
//  Copyright © 2017年 xxdl_ccz. All rights reserved.
//

#import "UpDownView.h"
#import "WaveView.h"

@interface UpDownView ()<CAAnimationDelegate>

@property (nonatomic,strong) UIView * coverView;

@end

@implementation UpDownView {
    double current_y;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self addSubview:self.coverView];
        current_y = _coverView.frame.origin.y;
        self.clipsToBounds = YES;
        
        WaveView * waveView = [[WaveView alloc] initWithFrame:self.bounds];
        [self addSubview:waveView];
        [waveView startWave];
        
        [self animation];
    }
    return self;
}

-(void)animation {
    CAKeyframeAnimation * upAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    upAnimation.values = @[@(current_y),@(current_y-40),@(current_y-55)];
    upAnimation.keyTimes = @[@0,@0.1,@0.3];
    upAnimation.duration = 1;
    upAnimation.repeatCount = 1;
    [_coverView.layer addAnimation:upAnimation forKey:nil];
    
    double delay = 0.4;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 也可以使用组合动画完成 CAAnimationGroup
        CAKeyframeAnimation * circleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        circleAnimation.values = @[@0,@(M_PI)];
        circleAnimation.keyTimes = @[@0,@(0.3)];
        circleAnimation.duration = 1;
        circleAnimation.repeatCount = 1;
        [_coverView.layer addAnimation:circleAnimation forKey:nil];
        
        CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.values = @[@1,@0.2,@1];
        opacityAnimation.keyTimes = @[@0,@(0.3),@(0.6)];
        opacityAnimation.duration = 1;
        opacityAnimation.repeatCount = 1;
        [_coverView.layer addAnimation:opacityAnimation forKey:nil];
        
//        CAKeyframeAnimation * roundAnimation = [CAKeyframeAnimation animationWithKeyPath:@"cornerRadius"];
//        roundAnimation.values = @[@0,@10];
//        roundAnimation.keyTimes = @[@0,@(0.3)];
//        roundAnimation.duration = 1;
//        roundAnimation.repeatCount = 1;
//        roundAnimation.removedOnCompletion = NO;
//        [_coverView.layer addAnimation:roundAnimation forKey:nil];
    });
    
    
    double delay1 = 0.7;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (delay1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CAKeyframeAnimation * upAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
        upAnimation1.values = @[@(current_y-55),@(current_y-40),@(current_y)];
        upAnimation1.keyTimes = @[@0,@0.2,@0.35];
        upAnimation1.duration = 1;
        upAnimation1.repeatCount = 1;
        upAnimation1.beginTime = CACurrentMediaTime();
        upAnimation1.delegate = self;
        [_coverView.layer addAnimation:upAnimation1 forKey:nil];
    });
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self animation];
}

#pragma mark - lazy
-(UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(10, self.frame.size.height+20, 20, 20)];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.clipsToBounds = YES;
    }
    return _coverView;
}

@end
