//
//  ViewController.m
//  MaterialDesignDemo
//
//  Created by 薛纪杰 on 11/25/15.
//  Copyright © 2015 XueSeason. All rights reserved.
//

#import "ViewController.h"
#import "MaterialDesignTransition.h"

@interface ViewController () <UINavigationControllerDelegate>
@property (strong, nonatomic) MaterialDesignTransition *mdTransition;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    CALayer *layer = self.button.layer;
    layer.shadowOffset = CGSizeMake(0, 5);
    layer.shadowRadius = 5.0;
    layer.shadowOpacity = 0.5;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.masksToBounds = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return self.mdTransition;
    } else {
        return nil;
    }
}

#pragma mark - getters and setters
- (MaterialDesignTransition *)mdTransition {
    if (_mdTransition == nil) {
        _mdTransition = [[MaterialDesignTransition alloc] init];
    }
    return _mdTransition;
}


@end
