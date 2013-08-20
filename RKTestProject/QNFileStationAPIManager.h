//
//  QNFileStationAPIManager.h
//  RKTestProject
//
//  Created by Change.Liao on 13/8/16.
//  Copyright (c) 2013年 Change.Liao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "QNModuleBaseObject.h"
#import "QNLogin.h"

@interface QNFileStationAPIManager : QNModuleBaseObject
@property(nonatomic, strong) RKObjectManager *objectManager;

- (id)initWithBaseURL:(NSString *)baseURL;

/**
 *  login action in FileStations Version 1.0
 *  TODO: checkout the version above
 *
 *  @param account  the account you want to login
 *  @param password the password for account above
 *  @param success  a success block excuting while login success in asynchronized mode.
 *  @param failure  a failure block
 */
- (void)loginWithAccount:(NSString*)account withPassword:(NSString*)password withSuccessBlock:(void (^)(RKObjectRequestOperation *operation, RKMappingResult * mappingResult, QNLogin *loginInfo))success withFailureBlock:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;
@end
