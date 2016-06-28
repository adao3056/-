//
//  AppDelegate.h
//  jishiben
//
//  Created by songdaozhang on 16/1/22.
//  Copyright © 2016年 songdaozhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomAlter : UIAlertController

+ (instancetype)alertWithTitle:(NSString *)title andMessage:(NSString *)message andCallBack:(void(^)(UIAlertAction *action))handle;
@end
