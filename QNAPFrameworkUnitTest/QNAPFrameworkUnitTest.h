//
//  QNAPFrameworkUnitTest.h
//  QNAPFrameworkUnitTest
//
//  Created by Chen-chih Liao on 13/8/21.
//  Copyright (c) 2013年 Change.Liao. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "QNCommunicationManager.h"
#import "QNFileStationAPIManager.h"

@interface QNAPFrameworkUnitTest : SenTestCase
@property(nonatomic, strong) QNCommunicationManager *communicationManager;
@property(nonatomic, strong) QNFileStationAPIManager *fileStationManager;
@end
