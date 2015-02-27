//
//  DSFancyLoaderView.m
//  Design Shots
//
//  Created by Rounak Jain on 19/12/14.
//  Copyright (c) 2014 Rounak Jain. All rights reserved.
//

#import "RJCircularLoaderView.h"

#define MAX_RADIUS 20

@interface RJCircularLoaderView ()
@property (nonatomic, strong) CAShapeLayer *circlePathLayer;
@end

@implementation RJCircularLoaderView

+ (CGFloat)radiusForPoint:(CGPoint)point
{
    return sqrtf((point.x*point.x) + (point.y*point.y));
}

+ (CGFloat)distanceBetweenPoint1:(CGPoint)point1 point2:(CGPoint)point2
{
    return [self radiusForPoint:CGPointMake(point1.x - point2.x, point1.y - point2.y)];
}

- (CGPathRef)circlePath
{
    CGRect circleFrame = CGRectMake(0, 0, 2*MAX_RADIUS, 2*MAX_RADIUS);
    circleFrame.origin.x = CGRectGetMidX(self.circlePathLayer.bounds) - CGRectGetMidX(circleFrame);
    circleFrame.origin.y = CGRectGetMidY(self.circlePathLayer.bounds) - CGRectGetMidY(circleFrame);
    return [UIBezierPath bezierPathWithOvalInRect:circleFrame].CGPath;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _circlePathLayer = [CAShapeLayer layer];
        _circlePathLayer.frame = self.bounds;
        _circlePathLayer.lineWidth = 2;
        _circlePathLayer.fillColor = [UIColor clearColor].CGColor;
        _circlePathLayer.strokeStart = 0;
        _circlePathLayer.strokeColor = self.tintColor.CGColor;
        _circlePathLayer.strokeEnd = _progress;
        [self.layer addSublayer:_circlePathLayer];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.circlePathLayer.frame = self.bounds;
    self.circlePathLayer.path = self.circlePath;
}

- (void)tintColorDidChange
{
    [super tintColorDidChange];
    self.circlePathLayer.strokeColor = self.tintColor.CGColor;
}

- (void)reveal
{
    self.backgroundColor = [UIColor clearColor];
    [self.circlePathLayer removeAnimationForKey:NSStringFromSelector(@selector(strokeEnd))];
    [self.circlePathLayer removeFromSuperlayer];
    self.superview.layer.mask = self.circlePathLayer;
    CGRect circleFrame = CGRectMake(0, 0, 2*MAX_RADIUS, 2*MAX_RADIUS);
    circleFrame.origin.x = CGRectGetMidX(self.circlePathLayer.bounds) - CGRectGetMidX(circleFrame);
    circleFrame.origin.y = CGRectGetMidY(self.circlePathLayer.bounds) - CGRectGetMidY(circleFrame);
    
    CGFloat finalRadius = [self.class distanceBetweenPoint1:CGPointZero point2:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
    CGFloat radius = finalRadius - MAX_RADIUS;
    CGRect outerRect = CGRectInset(circleFrame, -radius, -radius);
    UIBezierPath *toPath = [UIBezierPath bezierPathWithOvalInRect:outerRect];
    
    CGPathRef fromPath = self.circlePathLayer.path;
    CGFloat fromLineWidth = self.circlePathLayer.lineWidth;
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    self.circlePathLayer.lineWidth = 2*finalRadius;
    self.circlePathLayer.path = toPath.CGPath;
    [CATransaction commit];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.fillMode = kCAFillModeForwards;
    // Prevent the removal of the animation on completion to fix a flicker.  We will remove it manually after we remove the mask.
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.duration = 1;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(lineWidth))];
    lineWidthAnimation.fromValue = @(fromLineWidth);
    lineWidthAnimation.toValue = @(2*finalRadius);
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(path))];
    pathAnimation.fromValue = (__bridge id)(fromPath);
    pathAnimation.toValue = (id)toPath.CGPath;
    
    
    groupAnimation.animations = @[lineWidthAnimation, pathAnimation];
    groupAnimation.delegate = self;
    [self.circlePathLayer addAnimation:groupAnimation forKey:@"strokeWidth"];
    
}

- (void)setProgress:(CGFloat)progress
{
    if (progress > 1) {
        progress = 1;
    }
    if (progress < 0) {
        progress = 0;
    }
    _progress = progress;
    self.circlePathLayer.strokeEnd = _progress;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.superview.layer.mask = nil;
    [self.circlePathLayer removeAllAnimations];
    [self removeFromSuperview];
}

@end
