//
//  WaveView.m
//  Animation_demo
//
//  Created by xxdl_ccz on 17/1/9.
//  Copyright © 2017年 xxdl_ccz. All rights reserved.
//

#import "WaveView.h"

typedef NS_ENUM(NSInteger, WaveType) {
    sin_wave,
    cos_wave
};

@interface WaveView ()

@property (nonatomic,assign) CGFloat amplitude;     // 振幅
@property (nonatomic,assign) CGFloat waveHeight;    // 波高 (并非实际的高度，而是比例参考值)
@property (nonatomic,assign) CGFloat waveWidth;     // 波宽
@property (nonatomic,assign) CGFloat frequency;     // 频率
@property (nonatomic,assign) CGFloat max_amplitude; // 最大振幅

// 这两个参数不够直观 换成 waveOffset waveSpeed 会好一点
//@property (nonatomic,assign) CGFloat phase;         // 月相  波的变化值
//@property (nonatomic,assign) CGFloat phaseShift;    // 月相  波的变化率 （快慢）

@property (nonatomic,assign) CGFloat waveOffset;    // 波的位移
@property (nonatomic,assign) CGFloat waveSpeed;     // 波的变化速度

// 初始位置
@property (nonatomic,assign) CGFloat wavePointx;    // 初始位置x
@property (nonatomic,assign) CGFloat wavePointy;    // 初始位置y

@property (nonatomic,strong) CAShapeLayer * sinLayer;
@property (nonatomic,strong) CAShapeLayer * cosLayer;
@property (nonatomic,strong) CADisplayLink * dispalyLink;

@end

@implementation WaveView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializeValues];
        [self createSubLayers];
    }
    return self;
}

-(void)initializeValues {
    _waveWidth     = CGRectGetWidth(self.bounds);  // other ways
    _waveHeight    = 20.0;
    _frequency     = 0.3;
//    _phaseShift    = 4;
    _waveSpeed     = 6;
    _max_amplitude = _waveHeight * 0.3;
    
    _wavePointx = 0;
    _wavePointy = self.frame.size.height - 10;  // 相当于起始高度
}

-(void)createSubLayers {
    _sinLayer = [CAShapeLayer layer];
    _sinLayer.fillColor = [UIColor colorWithWhite:0 alpha:0.7].CGColor;
    // layer 图层由路径决定大小，但可设置position
//    _sinLayer.frame = CGRectMake(0, self.frame.size.height-15, self.frame.size.width, self.frame.size.height);
    
    _cosLayer = [CAShapeLayer layer];
    _cosLayer.fillColor = [UIColor colorWithWhite:0.5 alpha:0.6].CGColor;
//    _cosLayer.frame = CGRectMake(0, self.frame.size.height-15, self.frame.size.width, self.frame.size.height);
    
    [self.layer addSublayer:_sinLayer];
    [self.layer addSublayer:_cosLayer];
}

-(void)updateWave:(CADisplayLink *)display {
    // 变化值
//    _phase += _phaseShift;
    _waveOffset += _waveSpeed;
    // 添加路径
    _sinLayer.path = [self createWavePathWith:sin_wave].CGPath;
    _cosLayer.path = [self createWavePathWith:cos_wave].CGPath;
}

-(UIBezierPath *)createWavePathWith:(WaveType)type {
    UIBezierPath * wavePath = [UIBezierPath bezierPath];
    // 起点
    [wavePath moveToPoint:CGPointMake(0, _wavePointy)];
    
    for (float x = 0; x<_waveWidth+1; x++) {

        CGFloat y = 0;
        if (type == sin_wave) {
//            y = _max_amplitude * sin(360.0 / _waveWidth * (x  * M_PI / 180) * _frequency + _phase * M_PI/ 180) + _max_amplitude;
            y = _max_amplitude * sin(360.0 / _waveWidth * (x  * M_PI / 180) * _frequency + _waveOffset * M_PI/ 180) + _wavePointy;
        }
        else {
            // coshf(float) 这个方法会导致不可预见的bug
//            y = _max_amplitude * cos(360.0 / _waveWidth * (x  * M_PI / 180) * _frequency + _phase * M_PI/ 180) + _max_amplitude;
            y = _max_amplitude * cos(360.0 / _waveWidth * (x  * M_PI / 180) * _frequency + _waveOffset * M_PI/ 180) + _wavePointy;
        }

        [wavePath addLineToPoint:CGPointMake(x, y)];
    }
    
    [wavePath addLineToPoint:CGPointMake(_waveWidth, self.frame.size.height)];
    [wavePath addLineToPoint:CGPointMake(0, self.frame.size.height)];

    return wavePath;
}

-(void)startWave {
    _dispalyLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWave:)];
    [_dispalyLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    /*********************制作波浪升高动画****************************/
    // 计算最终位置
//    CGPoint position = _sinLayer.position;
//    position.y = position.y - 50;
    
//    static NSTimeInterval waveDuration = 4;
    
//    CABasicAnimation * baseAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
//    baseAnimation.fromValue = [NSValue valueWithCGPoint:_sinLayer.position];
//    baseAnimation.toValue   = [NSValue valueWithCGPoint:position];
//    baseAnimation.duration  = waveDuration;
//    baseAnimation.removedOnCompletion = NO;
//    baseAnimation.repeatCount = HUGE_VALF;
//    
//    [_sinLayer addAnimation:baseAnimation forKey:@"positionWave"];
//    [_cosLayer addAnimation:baseAnimation forKey:@"positionWave"];
}

@end
