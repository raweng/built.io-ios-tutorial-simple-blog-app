//
//***********************************************************************************************************
// This ViewController allows to create a new post with access constraints.
// BuiltACL is set to allow/disallow read/write/delete permissions to users and public.
//***********************************************************************************************************
#import "NewPostViewController.h"
#import "MBProgressHUD.h"


@interface NewPostViewController()<UIAlertViewDelegate>
@property(nonatomic, strong)MBProgressHUD *progressHUD;
@end

@implementation NewPostViewController

@synthesize textView;

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTitle:@"Add new post"];
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, 310, 186)];
    [textView setFont:[UIFont systemFontOfSize:16]];
    [textView becomeFirstResponder];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(addButtonTouchHandler:)]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonTouchHandler:)]];
    
    [self.view addSubview:textView];
}


#pragma mark - Button handlers

- (void)addButtonTouchHandler:(id)sender 
{
    if (![BuiltUser currentUser]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Do you want other to read your blog?" delegate:self cancelButtonTitle:@"Not this time!" otherButtonTitles:@"OK", nil];
        
        [alertView show];
    }else{
        [self addNote:1];
    }
    

}

- (void)cancelButtonTouchHandler:(id)sender 
{
    [self dismissViewControllerAnimated:YES completion:nil]; // Dismiss the viewController upon cancel
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self addNote:buttonIndex];
}

-(void)addNote:(NSInteger)buttonIndex{
    if (!self.progressHUD) {
        self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }else{
        [self.progressHUD show:YES];
    }
    
    [textView resignFirstResponder];
    
    self.progressHUD.dimBackground = YES;
    
    BuiltObject *object = [BuiltObject objectWithClassUID:@"blognote"];
    
    [object setObject:[textView text] forKey:@"blogtext"];
    
    //***********************************************************************************************************
    // Set ACL to blog object prior to creation.
    // BuiltACL offers control access to object so that public or individual.
    //***********************************************************************************************************
    
    BuiltACL *acl = [BuiltACL ACL];
    
    // public are given no write and delete access
    [acl setPublicWriteAccess:NO];
    [acl setPublicDeleteAccess:NO];
    
    // read/write/delete access if given to self
    if ([BuiltUser currentUser]) {
        [acl setReadAccess:YES forUserId:[BuiltUser currentUser].uid];
        [acl setWriteAccess:YES forUserId:[BuiltUser currentUser].uid];
        [acl setDeleteAccess:YES forUserId:[BuiltUser currentUser].uid];
    }
    
    // depending on whether user choosing to give read access to public ACL is set accordingly.
    if (buttonIndex == 0) {
        [acl setPublicReadAccess:NO];
        
    }else if (buttonIndex == 1){
        [acl setPublicReadAccess:YES];
    }
    // BuiltACL object created is set on BuiltObject and save method creates the BuiltObject with specified ACL.
    [object setACL:acl];
    [object saveOnSuccess:^{
        textView.text = nil;
        [self.progressHUD hide:YES afterDelay:2.0];
        
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadBlogs" object:nil];
        }];
    } onError:^(NSError *error) {
        [self.progressHUD hide:YES afterDelay:2.0];
    }];
}

@end
