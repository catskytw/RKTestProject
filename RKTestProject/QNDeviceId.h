//
//  QNDeviceId.h
//  RKTestProject
//
//  Created by Change.Liao on 13/8/26.
//  Copyright (c) 2013年 Change.Liao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QNDeviceId : NSManagedObject

@property (nonatomic, retain) NSString * deviceId;
@property (nonatomic, retain) NSString * nasName;

@end
