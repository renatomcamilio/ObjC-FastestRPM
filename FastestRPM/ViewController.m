//
//  ViewController.m
//  FastestRPM
//
//  Created by Renato Camilio on 1/22/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *speedometerWheelImageView;
@property (nonatomic, strong) UIImageView *speedometerTickImageView;

- (void)setupSpeedometer;

@end

@implementation ViewController

#define NEEDLE_INITIAL_DEGREE -215

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSpeedometer];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    panGesture.delegate = self;
    
    [self.view addGestureRecognizer:panGesture];
}

- (void)didPan:(id)sender {
    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)sender;
    CGPoint speed = [panGesture velocityInView:self.view];
    CGFloat realSpeed = speed.x * speed.y;
    __block CGFloat degree = NEEDLE_INITIAL_DEGREE;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        if ([panGesture numberOfTouches] <= 1) {
            if (panGesture.state == UIGestureRecognizerStateCancelled ||
                panGesture.state == UIGestureRecognizerStateFailed ||
                panGesture.state == UIGestureRecognizerStateEnded) {
                NSLog(@"state: %li", panGesture.state);
                degree = NEEDLE_INITIAL_DEGREE;
            } else if (realSpeed) {
                degree = ((NSInteger)realSpeed / 1000) + NEEDLE_INITIAL_DEGREE;
            }
        }
        
        degree = (degree < NEEDLE_INITIAL_DEGREE || degree > 55) ? NEEDLE_INITIAL_DEGREE : degree;
        self.speedometerTickImageView.transform = CGAffineTransformMakeRotation(M_PI * degree/ 180);
    } completion:^(BOOL finished) {
        return;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSpeedometer {
    //Speedometer Wheel View definitions
    UIImage *speedometerWheelImage = [UIImage imageNamed:@"RymB8v2.png"];
    self.speedometerWheelImageView = [[UIImageView alloc] initWithImage:speedometerWheelImage];
    self.speedometerWheelImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.speedometerWheelImageView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.speedometerWheelImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.speedometerWheelImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    //Speedometer Tick View definitions
    UIImage *speedometerTickImage = [UIImage imageNamed:@"olnJarq.png"];
    self.speedometerTickImageView = [[UIImageView alloc] initWithImage:speedometerTickImage];
    self.speedometerTickImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.speedometerWheelImageView addSubview:self.speedometerTickImageView];
    [self.speedometerTickImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.speedometerTickImageView
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1.0
                                                                               constant:280.0]];
    [self.speedometerTickImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.speedometerTickImageView
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1.0
                                                                               constant:280.0]];
    [self.speedometerWheelImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.speedometerTickImageView
                                                                               attribute:NSLayoutAttributeCenterY
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.speedometerWheelImageView
                                                                               attribute:NSLayoutAttributeCenterY
                                                                              multiplier:1.0
                                                                                constant:10.0]];
    [self.speedometerWheelImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.speedometerTickImageView
                                                                               attribute:NSLayoutAttributeCenterX
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.speedometerWheelImageView
                                                                               attribute:NSLayoutAttributeCenterX
                                                                              multiplier:1.0
                                                                                constant:0.0]];
    CGFloat degree = NEEDLE_INITIAL_DEGREE;
    self.speedometerTickImageView.transform = CGAffineTransformMakeRotation(M_PI * degree / 180);
}

@end
