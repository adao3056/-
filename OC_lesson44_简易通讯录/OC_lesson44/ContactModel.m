//
//  AppDelegate.h
//  jishiben
//
//  Created by songdaozhang on 16/1/22.
//  Copyright © 2016年 songdaozhang. All rights reserved.
//

#import "ContactModel.h"

#define kName @"name"
#define kid @"kid"

@interface ContactModel ()<NSCoding>

@end

@implementation ContactModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    if (self) {
        
        self.name = [aDecoder decodeObjectForKey:kName];
        self.cardId = [aDecoder decodeObjectForKey:kid];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.name forKey:kName];
    [aCoder encodeObject:self.cardId forKey:kid];
}




+ (instancetype)contactModelWithCardId:(NSString *)cardId andName:(NSString *)name{
    
    ContactModel *contactModel = [ContactModel new];
    contactModel.name = name;
    contactModel.cardId = cardId;
    return contactModel;
}
@end
