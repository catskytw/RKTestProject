//
//  QNFirmware.h
//  RKTestProject
//
//  Created by Change.Liao on 13/8/20.
//  Copyright (c) 2013年 Change.Liao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QNFirmware : NSManagedObject

@property (nonatomic, retain) NSString * build;
@property (nonatomic, retain) NSString * buildTime;
@property (nonatomic, retain) NSString * version;

@end
