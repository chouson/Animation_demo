//
//  ShadeView.m
//  Animation_demo
//
//  Created by xxdl_ccz on 17/1/8.
//  Copyright © 2017年 xxdl_ccz. All rights reserved.
//

#import "ShadeView.h"

@interface ShadeView ()

@property (nonatomic,strong) UILabel * shadeLabel;

@end

@implementation ShadeView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self addSubview:self.shadeLabel];
//        UILabel *label4 = ({
            UILabel *label = [[UILabel alloc]initWithFrame:self.bounds];
//            startY +=20;
            label.text = @"你好啊";
            [self addSubview:label];
            //设置渐变层，实际上有这个渐变层就可以显示了。
            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//            gradientLayer.frame = label.frame;
            gradientLayer.frame = CGRectMake(30, 0, 200, 30);
            // 设置渐变层的颜色
            gradientLayer.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor purpleColor].CGColor];
            //水平渐变添加下面两行即可
            //    gradientLayer.startPoint = CGPointMake(0, .5);
            //    gradientLayer.endPoint = CGPointMake(1, .5);
            // 疑问:渐变层能不能加在label上
            // 不能，如果添加渐变层到label图层上,则会遮盖label的文字图层；如果作为label图层的mask，由于mask是完全不透明渐变层，所以是正常显示，这种情况如果消失了，说明mask的frame.origin没有设置正确。
            // 添加渐变层到控制器的view图层上
            [self.layer addSublayer:gradientLayer];
            gradientLayer.mask = label.layer;
            //由于label.layer从self.view.layer中移动到渐变层gradientLayer中作为蒙版，所以坐标改变了需要重新调整。
//            label.layer.frame = gradientLayer.bounds;
//            label;
//        });
        
//        [self addSubview:label4];
    }
    return self;
}

-(UILabel *)shadeLabel {
    if (!_shadeLabel) {
        _shadeLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _shadeLabel.text = @"Hello world!";
        _shadeLabel.textColor = [UIColor blackColor];
        _shadeLabel.font = [UIFont systemFontOfSize:14];
    }
    return _shadeLabel;
}

@end
