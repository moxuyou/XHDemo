//
//  main.m
//  XHDemo
//
//  Created by moxuyou on 2017/1/20.
//  Copyright © 2017年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        int backInt = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        LXHLog(@"%i", backInt);
        return backInt;
    }
}
