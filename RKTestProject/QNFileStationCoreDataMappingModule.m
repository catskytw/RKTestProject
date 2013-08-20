//
//  QNFileStationCoreDataMappingModule.m
//  RKTestProject
//
//  Created by Change.Liao on 13/8/19.
//  Copyright (c) 2013年 Change.Liao. All rights reserved.
//

#import "QNFileStationCoreDataMappingModule.h"
static QNFileStationCoreDataMappingModule *staticFileStationCoreDataMappingModule=nil;
@implementation QNFileStationCoreDataMappingModule

#pragma mark - Singleton section
+(QNFileStationCoreDataMappingModule*)shareModule{
    if(staticFileStationCoreDataMappingModule==nil){
        staticFileStationCoreDataMappingModule = [[QNFileStationCoreDataMappingModule alloc] init];
    }
    return staticFileStationCoreDataMappingModule;
}

#pragma mark - object mapping section
-(RKEntityMapping *)loginObjectMapping:(RKManagedObjectStore *)managedObjectStore{
    //login mapping
    RKEntityMapping *responseMapping = [RKEntityMapping mappingForEntityForName:@"QNLogin" inManagedObjectStore:managedObjectStore];
    
    responseMapping.identificationAttributes = @[@"authSid"];
    
    NSManagedObjectModel *managerObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    [responseMapping addAttributeMappingsFromDictionary:[self allMappingInAuthLogin]];

    //firmware mapping
    RKEntityMapping *firmwareMapping = [RKEntityMapping mappingForEntityForName:@"QNFirmware" inManagedObjectStore:managedObjectStore];
    NSEntityDescription *firmwareDescription = [[managerObjectModel entitiesByName] objectForKey:@"QNFirmware"];
    NSArray *firmwareKeys =[[[RKPropertyInspector sharedInspector] propertyInspectionForEntity:firmwareDescription] allKeys];
    [firmwareMapping addAttributeMappingsFromDictionary:[self convertAllKeysFromRKPropertInspectorToDictionary:firmwareKeys]];
    
    RKRelationshipMapping *firmwareRelation = [RKRelationshipMapping relationshipMappingFromKeyPath:@"firmware"
                                                                                          toKeyPath:@"relationship_QNFirmware"
                                                                                        withMapping:firmwareMapping];
    [responseMapping addPropertyMapping:firmwareRelation];
    
    return responseMapping;
}

#pragma mark - Private methods
-(NSDictionary *)allMappingInAuthLogin{
//    return @{@"authSid.text":@"authSid", @"HTTPHost.text":@"httpHost"};
    return @{
             @"doQuick.text": @"doQuick",
             @"is_booting.text":@"is_booting",
             @"authPassed.text": @"authPassed",
             @"authSid.text": @"authSid",
             @"isAdmin.text":@"isAdmin",
             @"username.text":@"username",
             @"groupname.text":@"groupname",
             @"specVersion.text":@"specVersion",
             @"hostname.text":@"hostname",
             @"DemoSiteSuppurt.text":@"demoSiteSupport",
             @"HTTPHost.text":@"httpHost",
             @"webAccessPort.text":@"webAccessPort",
             @"QWebPort.text":@"qWebPort",
             @"webFSEnabled.text":@"webFSEnabled",
             @"QMultimediaEnabled.text":@"qMultimediaEnabled",
             @"MSV2Supported.text":@"msv2Supported",
             @"MSV2WebEnabled.text":@"msv2WebEnabled",
             @"MSV2URL.text":@"msv2URL",
             @"QDownloadEnabled.text":@"qDownloadEnabled",
             @"DSV2Supported.text":@"dsv2Supported",
             @"DSV3Supported.text":@"dsv3Supported",
             @"DSV2URL.text":@"dsv2URL",
             @"QWebEnabled.text":@"qWebEnabled",
             @"QWebSSLEnabled.text":@"qWebSSLEnabled",
             @"QWebSSLPort.text":@"qWebSSLPort",
             @"NVREnabled.text":@"nvrEnabled",
             @"NVRURL.text":@"nvrURL",
             @"NVRVER.text":@"nvrVer",
             @"WFM2.text":@"wfm2",
             @"wfmPortEnabled.text":@"wfmPortEnabled",
             @"wfmPort.text":@"wfmPort",
             @"wfmSSLEnabled.text":@"wfmSSLEnabled",
             @"wfmSSLPort":@"wfmSSLPort",
             @"wfmURL.text":@"wfmURL",
             @"QMusicsEnabled.text":@"qMusicsEnabled",
             @"QMusicsURL.text":@"qMusicsURL",
             @"QVideosEnabled.text":@"qVideosEnabled",
             @"QVideosURL.text":@"qVideosURL",
             @"QPhotosEnabled.text":@"qPhotosEnabled",
             @"QPhotosURL.text":@"qPhotosURL",
             @"stunnelEnabled.text":@"stunnelEnabled",
             @"stunnelPort.text":@"stunnelPort",
             @"forceSSL.text":@"forceSSL",
             @"HDAROOT_ALMOST_FULL.text":@"hdaRoot_ALMOST_FULL",
             @"serviceURL.text":@"serviceURL",
             };
}

-(NSDictionary *)convertAllKeysFromRKPropertInspectorToDictionary:(NSArray*)allKeys{
    NSMutableDictionary *mutablDic = [[NSMutableDictionary alloc] init];
    for (NSString *key in allKeys) {
        [mutablDic setValue:key forKey:[NSString stringWithFormat:@"%@.text",key]];
    }
    return (NSDictionary*)mutablDic;
}

@end
