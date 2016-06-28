//
//  AppDelegate.h
//  jishiben
//
//  Created by songdaozhang on 16/1/22.
//  Copyright © 2016年 songdaozhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject
@property (nonatomic,copy)NSString *cardId;
@property (nonatomic,copy)NSString *name;

+ (instancetype)contactModelWithCardId:(NSString *)cardId andName:(NSString *)name;
@end
