//
//  QNCommunicationManager.m
//  RKTestProject
//
//  Created by Change.Liao on 13/8/19.
//  Copyright (c) 2013年 Change.Liao. All rights reserved.
//

#import "QNCommunicationManager.h"
#import "QNModuleBaseObject.h"
static QNCommunicationManager *communicationManager = nil;

@implementation QNCommunicationManager

+(QNCommunicationManager*)shareCommunicationManager{
    if(communicationManager == nil){
        communicationManager = [[QNCommunicationManager alloc] init];
        [MagicalRecord setupAutoMigratingCoreDataStack];
    }
    return communicationManager;
}

-(QNFileStationAPIManager*)factoryForFileStatioAPIManager:(NSString*)baseURL{
    if([self validateUrl:baseURL])
        return nil;
    QNFileStationAPIManager *fileStationsAPIManager = [[QNFileStationAPIManager alloc] initWithBaseURL:baseURL];
    QNModuleBaseObject *searchExistingModule = [self sameModuleWithTargetModule:fileStationsAPIManager];
    return (searchExistingModule==nil)?fileStationsAPIManager:(QNFileStationAPIManager*)searchExistingModule;
}

#pragma mark - PrivateMethod
- (BOOL) validateUrl: (NSString *) candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

-(QNModuleBaseObject *)sameModuleWithTargetModule:(QNModuleBaseObject*)targetModule{
    @synchronized(self.allModules){
        for (QNModuleBaseObject *examModule in self.allModules) {
            if([examModule.baseURL isEqualToString:targetModule.baseURL] && [targetModule isMemberOfClass:[examModule class]]){
                return examModule;
            }
        }
        return nil;
    }
}

- (void)activateDebugLogLevel{
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor greenColor] backgroundColor:nil forFlag:LOG_FLAG_INFO];
}
@end
