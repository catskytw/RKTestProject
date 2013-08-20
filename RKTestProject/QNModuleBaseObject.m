//
//  QNModuleBaseObject.m
//  RKTestProject
//
//  Created by Change.Liao on 13/8/19.
//  Copyright (c) 2013年 Change.Liao. All rights reserved.
//

#import "QNModuleBaseObject.h"

@implementation QNModuleBaseObject

-(id)initWithBaseURL:(NSString*)baseURL{
    if((self = [self init])){
        self.baseURL = baseURL;
    }
    return self;
}
@end
