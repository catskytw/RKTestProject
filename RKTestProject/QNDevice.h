//
//  QNDevice.h
//  RKTestProject
//
//  Created by Change.Liao on 13/8/26.
//  Copyright (c) 2013年 Change.Liao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QNDevice : NSManagedObject

@property (nonatomic, retain) NSString * deviceId;
@property (nonatomic, retain) NSString * deviceType;
@property (nonatomic, retain) NSString * deviceName;
@property (nonatomic, retain) NSString * modelName;
@property (nonatomic, retain) NSString * serialNumber;
@property (nonatomic, retain) NSString * macAddress;
@property (nonatomic, retain) NSDate * checkedInTime;

@end
