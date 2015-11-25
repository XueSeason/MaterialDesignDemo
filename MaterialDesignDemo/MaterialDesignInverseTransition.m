//
//  MaterialDesignInverseTransition.m
//  MaterialDesignDemo
//
//  Created by 薛纪杰 on 11/25/15.
//  Copyright © 2015 XueSeason. All rights reserved.
//

#import "MaterialDesignInverseTransition.h"

#import "ViewController.h"
#import "NextViewController.h"

@interface MaterialDesignInverseTransition ()
@property (strong, nonatomic) id<UIViewControllerContextTransitioning> transitionContext;
@end

@implementation MaterialDesignInverseTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.2f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    
    NextViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    
    // calculate
    CGFloat width   = [UIScreen mainScreen].bounds.size.width;
    CGFloat height  = [UIScreen mainScreen].bounds.size.height;
    CGFloat centerX = fromVC.button.center.x;
    CGFloat centerY = fromVC.button.center.y;
    CGFloat maxX    = fabs(width - centerX) > fabs(centerX - width) ? fabs(width - centerX) : fabs(centerX - width);
    CGFloat maxY    = fabs(height - centerY) > fabs(centerY - height) ? fabs(height - centerY) : fabs(centerY - height);
    CGFloat radius  = sqrt(maxX * maxX + maxY * maxY);
    
    UIBezierPath *startCircle = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(fromVC.button.frame, -radius, -radius)];
    UIBezierPath *finalCircle = [UIBezierPath bezierPathWithOvalInRect:fromVC.button.frame];
    
    // 创建 CAShaperLayer 遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = finalCircle.CGPath;
    toVC.view.layer.mask = maskLayer;

    // 创建 CABasicAnimation 动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(startCircle.CGPath);
    maskLayerAnimation.toValue   = (__bridge id _Nullable)(finalCircle.CGPath);
    maskLayerAnimation.duration  = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate  = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"basic"];
}

#pragma mark - CABasicAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end
