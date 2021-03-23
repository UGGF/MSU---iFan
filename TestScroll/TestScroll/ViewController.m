//
//  ViewController.m
//  TestScroll
//
//  Created by Zhuge_Su on 2017/7/12.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "ViewController.h"
#import "MSUFirstView.h"
#import "MSUSecondView.h"
#import "MSUThirdView.h"
#import "MSUFourView.h"
#import "MSUFiveView.h"

//自定义屏幕宽高
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define ScreenInterval 1
#define ScaleInterval 0.5
#define ScaleHeight (HEIGHT*0.5-10)
#define ScaleWidth (WIDTH*0.5-10)

@interface ViewController ()

@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) UIButton *testBtn;
@property (nonatomic , strong) MSUFirstView *first;
@property (nonatomic , strong) MSUSecondView *second;
@property (nonatomic , strong) MSUThirdView *third;
@property (nonatomic , strong) MSUFourView *four;
@property (nonatomic , strong) MSUFiveView *five;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // 滚动视图分页
    [self createScrollViewPages];
    
    self.testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _testBtn.frame = CGRectMake(WIDTH-80, 50, 50, 50);
    _testBtn.backgroundColor = [UIColor blueColor];
    _testBtn.layer.cornerRadius = 25;
    _testBtn.layer.shouldRasterize = YES;
    _testBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self.view addSubview:_testBtn];
    [_testBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(WIDTH-80, 150, 50, 50);
    sendBtn.backgroundColor = [UIColor blueColor];
    sendBtn.layer.cornerRadius = 25;
    sendBtn.layer.shouldRasterize = YES;
    sendBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self.view addSubview:sendBtn];
    [sendBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)btnClick:(UIButton *)sender{
    NSString *pointStr = NSStringFromCGPoint(_scrollView.contentOffset);
//    NSLog(@"%@",NSStringFromCGPoint(_scrollView.contentOffset));

    if ([pointStr isEqualToString:@"{0, 0}"]) {
        [UIView animateWithDuration:0.25 animations:^{
            [self scaleScrollViewFrame];
            _scrollView.contentOffset = CGPointMake(0, 0);
        }];
    } else if ([pointStr isEqualToString:@"{375, 0}"]) {
        [UIView animateWithDuration:0.25 animations:^{
            [self scaleScrollViewFrame];
            _scrollView.contentOffset = CGPointMake(ScaleWidth, 0);
        }];
    } else if ([pointStr isEqualToString:@"{750, 0}"]) {
        [UIView animateWithDuration:0.25 animations:^{
            [self scaleScrollViewFrame];
            _scrollView.contentOffset = CGPointMake(ScaleWidth*2, 0);
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            [self scaleScrollViewFrame];
        }];
    }
    
   
}

/* 滚动视图分页 */
- (void)createScrollViewPages{
    self.scrollView = [[UIScrollView alloc] init];
    _scrollView.scrollEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_scrollView];
    
    self.first = [[MSUFirstView alloc] init];
    _first.backgroundColor = [UIColor yellowColor];
    [_scrollView addSubview:_first];

    self.second = [[MSUSecondView alloc] init];
    _second.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_second];

    self.third = [[MSUThirdView alloc] init];
    _third.backgroundColor = [UIColor orangeColor];
    [_scrollView addSubview:_third];
    

    self.four = [[MSUFourView alloc] init];
    _four.backgroundColor = [UIColor greenColor];
    [_scrollView addSubview:_four];

    self.five = [[MSUFiveView alloc] init];
    _five.backgroundColor = [UIColor purpleColor];
    [_scrollView addSubview:_five];
    
    // 原始视图
    [self originalScrollViewFrame];
}

/* 原始视图 */
- (void)originalScrollViewFrame{
    // 滚动视图
    _scrollView.pagingEnabled = YES;
    _scrollView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    _scrollView.contentSize = CGSizeMake(WIDTH * 5, 0);
    
    // 子页面
    _first.frame = CGRectMake(ScreenInterval, 0, WIDTH-ScreenInterval*2, HEIGHT);
    _second.frame = CGRectMake(WIDTH+ScreenInterval, 0, WIDTH-ScreenInterval*2, HEIGHT);
    _third.frame = CGRectMake(WIDTH*2+ScreenInterval, 0, WIDTH-ScreenInterval*2, HEIGHT);
    _four.frame = CGRectMake(WIDTH*3+ScreenInterval, 0, WIDTH-ScreenInterval*2, HEIGHT);
    _five.frame = CGRectMake(WIDTH*4+ScreenInterval, 0, WIDTH-ScreenInterval*2, HEIGHT);
}

/* 缩放后视图 */
- (void)scaleScrollViewFrame{
    // 滚动视图
    _scrollView.frame = CGRectMake(0, HEIGHT * 0.5+10, WIDTH, ScaleHeight);
    _scrollView.contentSize = CGSizeMake(ScaleWidth*5, 0);
    _scrollView.pagingEnabled = NO;
    
    // 缩放按钮
    _testBtn.hidden = YES;
    
    // 子视图
    _first.frame = CGRectMake(ScaleInterval, 0, ScaleWidth-ScaleInterval*2, ScaleHeight);
    _second.frame = CGRectMake(ScaleInterval+ScaleWidth, 0, ScaleWidth-ScaleInterval*2, ScaleHeight);
    _third.frame = CGRectMake(ScaleInterval+ScaleWidth*2, 0, ScaleWidth-ScaleInterval*2, ScaleHeight);
    _four.frame = CGRectMake(ScaleInterval+ScaleWidth*3, 0, ScaleWidth-ScaleInterval*2, ScaleHeight);
    _five.frame = CGRectMake(ScaleInterval+ScaleWidth*4, 0, ScaleWidth-ScaleInterval*2, ScaleHeight);

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:_scrollView];
    
    if (CGRectContainsPoint(_first.frame, point)) {
        [UIView animateWithDuration:0.25 animations:^{
            [self originalScrollViewFrame];
            _testBtn.hidden = NO;
            _scrollView.contentOffset = CGPointMake(0, 0);
        }];
    }
    
    if (CGRectContainsPoint(_second.frame, point)) {
        [UIView animateWithDuration:0.25 animations:^{
            [self originalScrollViewFrame];
            _testBtn.hidden = NO;
            _scrollView.contentOffset = CGPointMake(WIDTH, 0);
        }];
    }
    
    if (CGRectContainsPoint(_third.frame, point)) {
        [UIView animateWithDuration:0.25 animations:^{
            [self originalScrollViewFrame];
            _testBtn.hidden = NO;
            _scrollView.contentOffset = CGPointMake(WIDTH*2, 0);
            
        }];
    }
    
    if (CGRectContainsPoint(_four.frame, point)) {
        [UIView animateWithDuration:0.25 animations:^{
            [self originalScrollViewFrame];
            _testBtn.hidden = NO;
            _scrollView.contentOffset = CGPointMake(WIDTH*3, 0);
            
        }];
    }
    
    if (CGRectContainsPoint(_five.frame, point)) {
        [UIView animateWithDuration:0.25 animations:^{
            [self originalScrollViewFrame];
            _testBtn.hidden = NO;
            _scrollView.contentOffset = CGPointMake(WIDTH*4, 0);
            
        }];
    }

}


@end
