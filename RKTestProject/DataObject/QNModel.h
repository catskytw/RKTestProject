//
//  QNModel.h
//  RKTestProject
//
//  Created by Change.Liao on 13/8/20.
//  Copyright (c) 2013年 Change.Liao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QNModel : NSManagedObject

@property (nonatomic, retain) NSString * customModelName;
@property (nonatomic, retain) NSString * displayModelName;
@property (nonatomic, retain) NSString * internalModelName;
@property (nonatomic, retain) NSString * modelName;
@property (nonatomic, retain) NSString * platform;
@property (nonatomic, retain) NSString * storage_v2;

@end
