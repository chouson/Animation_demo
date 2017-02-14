/*
 keyTimes:这是一个轨迹动画的时间的数组
 
 这里面数组的起始位置和末尾的数是0和1,如果我们不设置这个方法的话,轨迹动画的时间是time = duration/(values-1); 设置之后的会变化,举个例子:
 
 @[@(0),@(0.2),@(0.5),@(1)];这里面设置的三个的动画时间,假设总时间是10秒,
 
 第一段的时间为2秒(0.2 - 0)*10 第二段的时间为3秒(0.5-0.2)*10 第三段的时间为5秒(1-0.5)*10
 
 duration:动画的总时间
 
 begintime:延迟执行rectRunAnimation.beginTime=CACurrentMediaTime()+1;延时一秒执行
 
 rectRunAnimation.timingFunctions:这个也是数组,这个翻译就是时间的运行方式,就是我们每个时间段下面动画的运行方式,系统提供的是五中中
 
 rectRunAnimation.timingFunctions=@[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
 
 kCAMediaTimingFunctionLinear
 
 kCAMediaTimingFunctionEaseIn
 
 kCAMediaTimingFunctionEaseOut
 
 kCAMediaTimingFunctionEaseInEaseOut
 
 kCAMediaTimingFunctionDefault
 
 还有一种是自己设置的方式
 
 [CAMediaTimingFunction    functionWithControlPoints:0.55:0.085:0.68:0.53]];
 */

#import "ViewController.h"
#import "TestViewController.h"
#import "UpDownView.h"
#import "StarView.h"
#import "ShadeView.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<CAAnimationDelegate>

@property (nonatomic,strong) UILabel * rectLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Animation";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _rectLabel = [[UILabel alloc] initWithFrame:CGRectMake((Width-20)/2, (Height-100)/2, 20, 20)];
    _rectLabel.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_rectLabel];

    UpDownView * upView = [[UpDownView alloc] initWithFrame:CGRectMake((Width-40)/2, (Height-100)/2, 40, 100)];
    [self.view addSubview:upView];
    
    StarView * starView = [[StarView alloc] initWithFrame:CGRectMake((Width-50)/2, (Height-250)/2, 50, 50)];
    [self.view addSubview:starView];
    [starView start];
    
    ShadeView * shadeView = [[ShadeView alloc] initWithFrame:CGRectMake(10, (Height-250)/2, 100, 50)];
    [self.view addSubview:shadeView];

}

static const NSTimeInterval stageOne = 0.4;
static const NSTimeInterval stageTwo = 0.8;

-(void)animation {
    CAKeyframeAnimation * circleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    circleAnimation.values = @[@0,@(M_PI)];
    circleAnimation.keyTimes = @[@0,@(stageOne)];
    circleAnimation.duration = 1;
    circleAnimation.repeatCount = 1;
//    circleAnimation.removedOnCompletion = NO;
    [_rectLabel.layer addAnimation:circleAnimation forKey:nil];
    
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.values = @[@1,@0.2,@1];
    opacityAnimation.keyTimes = @[@0,@(stageOne),@(stageTwo)];
    opacityAnimation.duration = 1;
    opacityAnimation.repeatCount = 1;
//    opacityAnimation.removedOnCompletion = NO;
    [_rectLabel.layer addAnimation:opacityAnimation forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(stageTwo * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CAKeyframeAnimation * circleAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        circleAnimation1.values = @[@0,@(M_PI)];
        circleAnimation1.keyTimes = @[@(0),@(stageOne)];
        circleAnimation1.duration = 1;
        circleAnimation1.beginTime = CACurrentMediaTime()+0.3;
//        circleAnimation1.removedOnCompletion = NO;
        circleAnimation1.delegate = self;
        [_rectLabel.layer addAnimation:circleAnimation1 forKey:nil];
        
        CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.values = @[@1,@0.2,@1];
        opacityAnimation.keyTimes = @[@(0),@(stageOne),@(stageTwo)];
        opacityAnimation.duration = 1;
        opacityAnimation.repeatCount = 1;
//        opacityAnimation.removedOnCompletion = NO;
        opacityAnimation.beginTime = CACurrentMediaTime()+0.3;
        [_rectLabel.layer addAnimation:opacityAnimation forKey:nil];
    });
}

-(void)animationOne {
    CAKeyframeAnimation * circleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    circleAnimation.values = @[@0,@(M_PI)];
    circleAnimation.keyTimes = @[@0,@(stageOne)];
    circleAnimation.duration = 1;
    circleAnimation.repeatCount = 1;
    circleAnimation.removedOnCompletion = NO;
    [_rectLabel.layer addAnimation:circleAnimation forKey:nil];
    
    _rectLabel.clipsToBounds = YES;

    CAKeyframeAnimation * roundAnimation = [CAKeyframeAnimation animationWithKeyPath:@"cornerRadius"];
    roundAnimation.values = @[@0,@10];
    roundAnimation.keyTimes = @[@0,@(stageOne)];
    roundAnimation.duration = 1;
    roundAnimation.repeatCount = 1;
    roundAnimation.removedOnCompletion = NO;
    [_rectLabel.layer addAnimation:roundAnimation forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(stageTwo * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _rectLabel.layer.cornerRadius = 10;
        CAKeyframeAnimation * circleAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        circleAnimation1.values = @[@0,@(M_PI)];
        circleAnimation1.keyTimes = @[@(0),@(stageOne)];
        circleAnimation1.duration = 1;
        circleAnimation1.beginTime = CACurrentMediaTime()+0.3;
        circleAnimation1.removedOnCompletion = NO;
        circleAnimation1.delegate = self;
        [_rectLabel.layer addAnimation:circleAnimation1 forKey:nil];
        
        CAKeyframeAnimation * roundAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"cornerRadius"];
        roundAnimation1.values = @[@10,@0];
        roundAnimation1.keyTimes = @[@0,@(stageOne)];
        roundAnimation1.duration = 1;
        roundAnimation1.repeatCount = 1;
        roundAnimation1.beginTime = CACurrentMediaTime()+0.3;
        roundAnimation1.removedOnCompletion = NO;
        [_rectLabel.layer addAnimation:roundAnimation1 forKey:nil];
        
    });
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /***************************rotation*******************************/
    
    [self animation];
//    [self animationOne];
    /****************************position.x********************************/
//    CGFloat rext_x = _rectLabel.frame.origin.x;
//    
//    CAKeyframeAnimation * positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
//    
//    positionAnimation.values = @[@(rext_x-5),@(rext_x+10),@(rext_x-3),@(rext_x+6),@(rext_x-1),@(rext_x+2),@(rext_x)];
//
//    positionAnimation.keyTimes = @[@(0),@(0.2),@(0.4),@(0.6),@(0.8),@(1.0),@(1.2),@(1.4)];
//    
//    [_rectLabel.layer addAnimation:positionAnimation forKey:nil];

}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self animation];
//    [self animationOne];
}

/*
 用dispatch_after的时候就会用到dispatch_time_t变量，但是如何创建合适的时间呢？答案就是用dispatch_time函数，其原型如下：
 
 1
 dispatch_time_t dispatch_time ( dispatch_time_t when, int64_t delta );
 第一个参数一般是DISPATCH_TIME_NOW，表示从现在开始。
 
 那么第二个参数就是真正的延时的具体时间。
 
 这里要特别注意的是，delta参数是“纳秒！”，就是说，延时1秒的话，delta应该是“1000000000”=。=，太长了，所以理所当然系统提供了常量，如下：
 
 1
 2
 3
 #define NSEC_PER_SEC 1000000000ull
 #define USEC_PER_SEC 1000000ull
 #define NSEC_PER_USEC 1000ull
 关键词解释：
 
 NSEC：纳秒。
 USEC：微妙。
 SEC：秒
 PER：每
 所以：
 
 NSEC_PER_SEC，每秒有多少纳秒。
 USEC_PER_SEC，每秒有多少毫秒。（注意是指在纳秒的基础上）
 NSEC_PER_USEC，每毫秒有多少纳秒。
 所以，延时1秒可以写成如下几种：
 
 dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
 
 dispatch_time(DISPATCH_TIME_NOW, 1000 * USEC_PER_SEC);
 
 dispatch_time(DISPATCH_TIME_NOW, USEC_PER_SEC * NSEC_PER_USEC);
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
