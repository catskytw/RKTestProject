//
//  QNModuleBaseObject.h
//  RKTestProject
//
//  Created by Change.Liao on 13/8/19.
//  Copyright (c) 2013年 Change.Liao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QNModuleBaseObject : NSObject
@property(nonatomic, strong)NSString *moduleId;
@property(nonatomic, strong)NSString *baseURL;

-(id)initWithBaseURL:(NSString*)baseURL;

@end
