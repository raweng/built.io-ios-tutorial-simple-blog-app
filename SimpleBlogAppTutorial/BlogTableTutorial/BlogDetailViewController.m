//
//  BlogDetailViewController.m
//  BlogTableTutorial
//
//  Created by Sameer on 11/03/14.
//  Copyright (c) 2014 Sameer. All rights reserved.
//

#import "BlogDetailViewController.h"

@interface BlogDetailViewController ()

@end

@implementation BlogDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = [[UIScreen mainScreen]bounds].size.width;
    CGFloat height = [[UIScreen mainScreen]bounds].size.height;
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UITextView *blogLabel = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    blogLabel.editable = NO;
    blogLabel.text = [self.blogObject objectForKey:@"blogtext"];
    blogLabel.contentInset = UIEdgeInsetsMake(0, 0, 150, 0);
    [self.view addSubview:blogLabel];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
