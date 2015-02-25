# RJImageLoader

[![Version](https://img.shields.io/cocoapods/v/RJImageLoader.svg?style=flat)](http://cocoadocs.org/docsets/RJImageLoader)

This project is based on [Michael Villar's excellent Motion Experiments post](http://www.michaelvillar.com/motion). He designed an image loading animation which shows a circular progress indicator, and then reveals the image in an expanding circular ring.

![demo](https://raw.githubusercontent.com/rounak/RJImageLoader/master/out6.gif)

For a detailed explaination of the animation, visit [raywenderlich.com](http://www.raywenderlich.com/94302/implement-circular-image-loader-animation-cashapelayer).

## Usage


```objective-c
#import <UIImageView+RJLoader.h>

//before starting
[self.imageView startLoader];

//to change the color of the indicator, use the startLoaderWithTintColor: method

//update progress
[self.imageView updateImageDownloadProgress:progress];

//after completion
[self.imageView reveal];

```


To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

RJImageLoader is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "RJImageLoader"

## Author

Rounak Jain.

Follow me on Twitter [@r0unak](https://twitter.com/r0unak)

##Contributors

[@bguidolim](http://twitter.com/bguidolim)

## License

RJImageLoader is available under the MIT license. See the LICENSE file for more info.

