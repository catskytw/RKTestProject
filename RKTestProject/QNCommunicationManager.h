//
//  QNCommunicationManager.h
//  RKTestProject
//
//  Created by Change.Liao on 13/8/19.
//  Copyright (c) 2013年 Change.Liao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNFileStationAPIManager.h"
@interface QNCommunicationManager : NSObject
@property(nonatomic, strong) NSMutableArray *allModules;

+(QNCommunicationManager*)shareCommunicationManager;

/**
 *  給予baseURL, 從array 裡尋找有沒有相同的FileStation
 *  若無則create 一個新的instance
 *  TODO: 應設定讓外部開發者無法自己alloc FileStation, 一定要透過這個API
 *
 *  @param baseURL FileStation base URL. e.g.  http://192.168.0.1:8080
 *
 *  @return 該FileStaton instance
 */
-(QNFileStationAPIManager*)factoryForFileStatioAPIManager:(NSString*)baseURL;

/**
 *  提供Lumberjack DDLog 以及 XCode color console的能力
 */
- (void)activateDebugLogLevel;
@end
