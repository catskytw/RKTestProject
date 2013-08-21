//
//  QNAPFrameworkUnitTest.m
//  QNAPFrameworkUnitTest
//
//  Created by Chen-chih Liao on 13/8/21.
//  Copyright (c) 2013年 Change.Liao. All rights reserved.
//

#import "QNAPFrameworkUnitTest.h"
#import <RestKit/RestKit.h>
#import <Expecta/Expecta.h>

#define EXP_SHORTHAND YES
@implementation QNAPFrameworkUnitTest

- (void)setUp
{
    [super setUp];
    self.communicationManager = [QNCommunicationManager shareCommunicationManager];
    self.fileStationManager = [self.communicationManager factoryForFileStatioAPIManager:@"http://changenas.myqnapcloud.com:8080"];

    /**
     *設定asynchronized request等待時間為10秒
     *若10秒沒有resultMapping, 判定fail
     **/
    [Expecta setAsynchronousTestTimeout:10];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testAuthLogin
{
    __block RKObjectRequestOperation *requestOperation = nil;
    [self.fileStationManager loginWithAccount:@"admin"
                                 withPassword:@"YWRtaW4="
                             withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult * mappingResult, QNLogin *loginInfo){
                                 NSLog(@"loginInfo success sid:%@", loginInfo.authSid);
                                 requestOperation = operation;
                             }
                             withFailureBlock:^(RKObjectRequestOperation *operation,NSError *error){
                                 NSLog(@"loginInfo failure");
                                 requestOperation = operation;
                             }
     ];
    EXP_expect(requestOperation.mappingResult).willNot.beNil();
}

@end
