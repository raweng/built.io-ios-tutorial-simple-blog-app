//
//  AppDelegate.m
//  BlogTableTutorial

//***********************************************************************************************************
//    BlogTableTutorial is an example that gives an insight into built.io 's Access Control List(ACL). 
//    BuiltACL provides a way to restrict user content.
//    BlogTableTutorial is about publishing a sample blog post and control who all users can read the post. Or whether to make it avaiable to others.
//***********************************************************************************************************

#import "AppDelegate.h"
#import "BlogsTableViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    
    //***********************************************************************************************************
    // Initialize Built class with your application's API-KEY and APP-UID
    //[Built initializeWithApiKey:@"your-API-key" andUid:@"your-app-UID"];
    //***********************************************************************************************************
    [Built initializeWithApiKey:@"bltdfcc61830fb5b32b" andUid:@"notesapp"];
    
    
    //***********************************************************************************************************
    // We should login in order to get BuiltUser object with uid.
    // BuildUser's uid is useful to constrain permissions while creating or updating objects.
    //***********************************************************************************************************
    
    
//    BuiltUser *user = [BuiltUser user];
//
//    [user loginWithEmail:@"<your-email-id>" andPassword:@"<your-password>" OnSuccess:^{
//        [user saveSession];
//        NSLog(@"loginWithEmail %@",user);
//    } onError:^(NSError *error) {
//        NSLog(@"loginWithEmail error %@",error);
//    }];

    
    BlogsTableViewController *test = [[BlogsTableViewController alloc]initWithNibName:nil bundle:nil];
    self.nc = [[UINavigationController alloc]  initWithRootViewController:test];
    self.window.rootViewController = self.nc;
    
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+(AppDelegate *)sharedAppDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

@end
