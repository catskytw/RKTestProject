//
//  QNFileStationAPIManager.m
//  RKTestProject
//
//  Created by Change.Liao on 13/8/16.
//  Copyright (c) 2013年 Change.Liao. All rights reserved.
//

#import "QNFileStationAPIManager.h"
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "RKXMLReaderSerialization.h"
#import "QNLogin.h"
#import "QNFirmware.h"
#import "QNFileStationCoreDataMappingModule.h"

#define USING_CORE_DATA YES
int ddLogLevel = LOG_LEVEL_ERROR;
@implementation QNFileStationAPIManager

#pragma mark - Initiail Section
- (id)initWithBaseURL:(NSString *)baseURL{
    if((self = [super initWithBaseURL:baseURL])){
        //ttp://changenas.myqnapcloud.com:8080/cgi-bin/authLogin.cgi?pwd=YWRtaW4=&service=1&user=admin
        self.objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:baseURL]];
        [self.objectManager setAcceptHeaderWithMIMEType:@"text/xml"];
        [RKMIMETypeSerialization registerClass:[RKXMLReaderSerialization class] forMIMEType:@"text/xml"];
        
        NSURL *modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"CommunicationResult" ofType:@"momd"]];
        
        //Iniitalize CoreData with RestKit
        NSManagedObjectModel *managedObjectModel = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] mutableCopy];
        RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
        self.objectManager.managedObjectStore = managedObjectStore;
        
        [self.objectManager.managedObjectStore createPersistentStoreCoordinator];
        NSError *error;
        NSPersistentStore __unused *persistentStore = [managedObjectStore addInMemoryPersistentStore:&error];
        NSAssert(persistentStore, @"Failed to add persistent store: %@", error);

        [self.objectManager.managedObjectStore createManagedObjectContexts];

    }
    return self;
}
#pragma mark - FileStation API
- (void)loginWithAccount:(NSString*)account withPassword:(NSString*)password withSuccessBlock:(void (^)(RKObjectRequestOperation *operation, RKMappingResult * mappingResult, QNLogin *loginInfo))success withFailureBlock:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure{

    //mapping the first layer
    RKEntityMapping *responseMapping = [[QNFileStationCoreDataMappingModule shareModule] loginObjectMapping:self.objectManager.managedObjectStore];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:nil
                                                                                           keyPath:@"QDocRoot"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:responseDescriptor];
    NSDictionary *parameters = @{@"pwd":password, @"user":account, @"service":@"1"};
    
    [self.objectManager getObjectsAtPath:@"cgi-bin/authLogin.cgi"
                              parameters:parameters
                                 success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                     //fetching the result from coredata
                                     if(success!=nil){
                                         NSArray *allQNLogin = [QNLogin MR_findAllInContext:self.objectManager.managedObjectStore.mainQueueManagedObjectContext];
                                         QNLogin *targetLogin = [allQNLogin objectAtIndex:0];
                                         success(operation, mappingResult, targetLogin);
                                         DDLogInfo(@"fetching login information successfully...Sid: %@", targetLogin.authSid);
                                     }
                                 }
                                 failure:^(RKObjectRequestOperation *operation, NSError *error){
                                     if(failure!=nil)
                                         failure(operation, error);
                                     DDLogError(@"HTTP Request Error! %@", error);
                                 }];

}

@end
