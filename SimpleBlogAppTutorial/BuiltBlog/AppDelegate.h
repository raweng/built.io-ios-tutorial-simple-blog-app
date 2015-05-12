//
//  AppDelegate.h
//  BuiltBlog
//
//  Created by Sameer on 27/02/14.
//  Copyright (c) 2014 Sameer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) BuiltApplication *application;

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UINavigationController *nc;

+(AppDelegate *)sharedAppDelegate;

@end
