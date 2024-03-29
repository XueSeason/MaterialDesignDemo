//
//  NextViewController.m
//  MaterialDesignDemo
//
//  Created by 薛纪杰 on 11/25/15.
//  Copyright © 2015 XueSeason. All rights reserved.
//

#import "NextViewController.h"
#import "MaterialDesignInverseTransition.h"

@interface NextViewController () <UINavigationControllerDelegate>
@property (strong, nonatomic) MaterialDesignInverseTransition *popTransition;
@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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

- (IBAction)pop:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return self.popTransition;
    } else {
        return nil;
    }
}

#pragma mark - getters and setters
- (MaterialDesignInverseTransition *)popTransition {
    if (_popTransition == nil) {
        _popTransition = [[MaterialDesignInverseTransition alloc] init];
    }
    return _popTransition;
}

@end
