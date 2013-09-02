//
//  OAuthToken.h
//  RKTestProject
//
//  Created by Change.Liao on 13/8/29.
//  Copyright (c) 2013年 Change.Liao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface OAuthToken : NSManagedObject

@property (nonatomic, retain) NSString * access_token;
@property (nonatomic, retain) NSString * token_type;
@property (nonatomic, retain) NSNumber * expire_in;
@property (nonatomic, retain) id scope;

@end
