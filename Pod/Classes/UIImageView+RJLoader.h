//
//  UIImageView+RJLoader.h
//  ImageLoaderAnimation
//
//  Created by Rounak Jain on 28/12/14.
//  Copyright (c) 2014 Rounak Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "objc/runtime.h"


@interface UIImageView (RJLoader)

- (void)updateImageDownloadProgress:(CGFloat)progress;
- (void)startLoader;
- (void)startLoaderWithTintColor:(UIColor *)color;
- (void)reveal;

@end
