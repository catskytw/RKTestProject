//
//  QNViewController.m
//  RKTestProject
//
//  Created by Change.Liao on 13/8/15.
//  Copyright (c) 2013年 Change.Liao. All rights reserved.
//

#import "QNViewController.h"
#import "QNLogin.h"
#import "RKXMLReaderSerialization.h"
#import "QNMyCloudVLink.h"
#import <CommonCrypto/CommonDigest.h>
#import "QNFileStationAPIManager.h"
#import "QNCommunicationManager.h"
#import "QNFirmware.h"

@interface QNViewController ()

@end

@implementation QNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TestLogin

-(IBAction)loginTest:(id)sender{
    //h ttp://changenas.myqnapcloud.com:8080/cgi-bin/authLogin.cgi?pwd=YWRtaW4%3D&service=1&user=admin
    [[QNCommunicationManager shareCommunicationManager] activateDebugLogLevel];
    
    QNFileStationAPIManager *fileStations = [[QNCommunicationManager shareCommunicationManager] factoryForFileStatioAPIManager:@"http://changenas.myqnapcloud.com:8080"];
    [fileStations loginWithAccount:@"admin"
                      withPassword:@"YWRtaW4="
                  withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult * mappingResult, QNLogin *loginInfo){
                      DDLogInfo(@"loginInfo sid:%@, firmware buildTime:%@", loginInfo.authSid, loginInfo.relationship_QNFirmware.buildTime);
                  }
                  withFailureBlock:nil];
}

#pragma mark - TestVlink
-(IBAction)getVlinkTest:(id)sender{
    NSString *baseURLString = @"https://core.api.myqnapcloud.com:443/v1/services/vlink/";
    self.myObjectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:baseURLString]];
    [self.myObjectManager.router.routeSet addRoute:[RKRoute routeWithClass:[QNMyCloudVLink class] pathPattern:@":nasName" method:RKRequestMethodGET]];
    [self settingHeader];
    [self getVlinkRequest];
}

-(void)settingHeader{
    [self.myObjectManager.HTTPClient setDefaultHeader:@"X-QNAP-APP-VER" value:@"1.2.3"];
    [self.myObjectManager.HTTPClient setDefaultHeader:@"X-QNAP-CHECK" value:@"888a9debce40018ba4a2afd97884d6a211100b57"];
    [self.myObjectManager.HTTPClient setDefaultHeader:@"X-QNAP-TIME" value:@"1376553019"];
    [self.myObjectManager.HTTPClient setDefaultHeader:@"X-QNAP-APP-ID" value:@"ewedcnowsnnweefo9328s9cnaf7001"];
}
-(void)getVlinkRequest{
    //add responseMapping
    RKObjectMapping *responseMapping = [RKObjectMapping mappingForClass:[QNMyCloudVLink class]];
    [responseMapping addAttributeMappingsFromDictionary:@{@"actTime":@"actTime"}
     ];
    
    RKResponseDescriptor *responseDescriptor =[RKResponseDescriptor responseDescriptorWithMapping:responseMapping
                                                                                           method:RKRequestMethodGET
                                                                                      pathPattern:nil
                                                                                          keyPath:nil
                                                                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [self.myObjectManager addResponseDescriptor:responseDescriptor];
    
    QNMyCloudVLink *myVLink = [QNMyCloudVLink new];
    myVLink.nasName = @"changenas";
    [self.myObjectManager getObject:myVLink
                               path:nil
                       parameters:nil
                          success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                              NSLog(@"myVlink actTime %@", myVLink.actTime);
                          }
                          failure:^(RKObjectRequestOperation *operation, NSError *error){
                              NSLog(@"login Error");
                          }];
}

#pragma mark - Notification
- (void)handleDataModelChange:(NSNotification *)note
{
    NSSet *updatedObjects = [[note userInfo] objectForKey:NSUpdatedObjectsKey];
    NSSet *deletedObjects = [[note userInfo] objectForKey:NSDeletedObjectsKey];
    NSSet *insertedObjects = [[note userInfo] objectForKey:NSInsertedObjectsKey];
    // Do something in response to this
    
    if ([insertedObjects count]) {
        NSLog(@"");
    }
}
@end
