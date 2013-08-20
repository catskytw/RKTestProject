//
//  QNViewController.h
//  RKTestProject
//
//  Created by Change.Liao on 13/8/15.
//  Copyright (c) 2013年 Change.Liao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
@interface QNViewController : UIViewController
@property(nonatomic, strong) RKObjectManager *myObjectManager;
@property(nonatomic, strong) IBOutlet UITextView *textView;

-(IBAction)getVlinkTest:(id)sender;
-(IBAction)loginTest:(id)sender;
@end
