//
//  AppDelegate.h
//  jishiben
//
//  Created by songdaozhang on 16/1/22.
//  Copyright © 2016年 songdaozhang. All rights reserved.
//

#import "CustomAlter.h"

@implementation CustomAlter
+ (instancetype)alertWithTitle:(NSString *)title andMessage:(NSString *)message andCallBack:(void (^)(UIAlertAction *))handle{
    
    CustomAlter *alert = [CustomAlter alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        if(handle){
            
            handle(action);
        }
    }]];
    
    return alert;
}
@end
