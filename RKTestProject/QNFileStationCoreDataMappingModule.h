//
//  QNFileStationCoreDataMappingModule.h
//  RKTestProject
//
//  Created by Change.Liao on 13/8/19.
//  Copyright (c) 2013年 Change.Liao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
@interface QNFileStationCoreDataMappingModule : NSObject
/**
 *  QNFileStationCoreDataMappingModule's singleton
 *
 *  @return QNFileStationCoreDataMappingModule singleton instance
 */
+(QNFileStationCoreDataMappingModule*)shareModule;

/**
 *  針對login API做的CoreData ObjectMapping
 *
 *  @param managedObjectStore 由外部傳入managedObjectStore
 *
 *  @return 傳回mapping 值
 */
-(RKEntityMapping *)loginObjectMapping:(RKManagedObjectStore *)managedObjectStore;
@end
