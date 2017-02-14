//
//  StartView.m
//  Animation_demo
//
//  Created by xxdl_ccz on 17/1/8.
//  Copyright © 2017年 xxdl_ccz. All rights reserved.
//

#import "StarView.h"

#define SWidth self.frame.size.width
#define SHeight self.frame.size.height

@interface StarView ()

@property (nonatomic,strong) CAShapeLayer * starLayer;

@end

@implementation StarView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self animation];
    }
    return self;
}

-(CAShapeLayer *)starLayer {
    if (!_starLayer) {
        _starLayer  = [CAShapeLayer layer];
        _starLayer.fillColor = [UIColor clearColor].CGColor;
        _starLayer.strokeColor = [UIColor blackColor].CGColor;
//        NSLog(@"stroke:%f  %f",_starLayer.strokeEnd,_starLayer.strokeStart);
        _starLayer.strokeStart = _starLayer.strokeEnd = 0;
        _starLayer.lineWidth = 1;
        [self.layer addSublayer:_starLayer];
    }
    return _starLayer;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    UIBezierPath * starPath = [UIBezierPath bezierPath];
    [starPath moveToPoint:CGPointMake(SWidth/2, 0)];
    [starPath addLineToPoint:CGPointMake(SWidth/4, SHeight)];
    [starPath addLineToPoint:CGPointMake(SWidth, SHeight/3)];
    [starPath addLineToPoint:CGPointMake(0, SHeight/3)];
    [starPath addLineToPoint:CGPointMake(SWidth*3/4, SHeight)];
    [starPath addLineToPoint:CGPointMake(SWidth/2, 0)];
    [starPath closePath];
    self.starLayer.path = starPath.CGPath;
}

const NSTimeInterval duration = 2;
-(void)start {
    [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(animation) userInfo:nil repeats:YES];
//    [self animation];
}

-(void)animation {
//    CABasicAnimation * endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    endAnimation.fromValue = @0;
//    endAnimation.toValue = @1;
//    endAnimation.duration = duration;
//    endAnimation.delegate = self;
//    [self.starLayer addAnimation:endAnimation forKey:@"end"];
//    
//    CABasicAnimation * startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
//    startAnimation.fromValue = @0;
//    startAnimation.toValue = @1;
//    startAnimation.duration = duration/2;
//    startAnimation.beginTime = CACurrentMediaTime() + duration/2;
//    [self.starLayer addAnimation:startAnimation forKey:@"start"];
    
    CAKeyframeAnimation * endAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimation.values = @[@0,@1];
    endAnimation.duration = duration;
    endAnimation.repeatCount = 1;
    [self.starLayer addAnimation:endAnimation forKey:@"end"];
    
    CAKeyframeAnimation * startAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.values = @[@0,@1];
    startAnimation.duration = duration/2;
    startAnimation.beginTime = CACurrentMediaTime() + duration/2;
    startAnimation.repeatCount = 1;
    [self.starLayer addAnimation:startAnimation forKey:@"start"];
}



@end
