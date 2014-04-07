//
//  BlogsTableViewController.m
//  BlogTableTutorial

#import "BlogsTableViewController.h"
#import "NewPostViewController.h"
#import "MBProgressHUD.h"
#import "BlogDetailViewController.h"
#import "AppDelegate.h"

@interface BlogsTableViewController ()

@property (nonatomic, strong) NSMutableArray *blogs;
@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

@implementation BlogsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.blogs = [NSMutableArray array];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setTitle:@"Posts"];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonHandler:)]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPostButtonHandler:)]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadBlogs) name:@"reloadBlogs" object:nil];
    
    [self loadBlogs];
}

-(void)loadBlogs{
    
    if (!self.progressHUD) {
        self.progressHUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    }else{
        [self.progressHUD show:YES];
    }
    self.progressHUD.dimBackground = YES;
    
    [self.blogs removeAllObjects];
    BuiltQuery *query = [BuiltQuery queryWithClassUID:@"blognote"];
    [query setCachePolicy:NETWORK_ELSE_CACHE];
    [query orderByDescending:@"created_at"];
    
    [query exec:^(QueryResult *result, ResponseType type) {
        [self.blogs addObjectsFromArray:[result getResult]];
        
        [self.progressHUD hide:YES afterDelay:2.0];
        [self.tableView reloadData];
    } onError:^(NSError *error, ResponseType type) {
        [self.progressHUD hide:YES afterDelay:2.0];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshButtonHandler:(id)sender{
    [self loadBlogs];
}

- (void)addPostButtonHandler:(id)sender{
    NewPostViewController *newPostViewController = [[NewPostViewController alloc] init];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:newPostViewController] animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.blogs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell with the textContent of the Post as the cell's text label
    BuiltObject *post = [self.blogs objectAtIndex:indexPath.row];
    [cell.textLabel setText:[post objectForKey:@"blogtext"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BlogDetailViewController *detailVC = [[BlogDetailViewController alloc]initWithNibName:nil bundle:nil];
    BuiltObject *post = [self.blogs objectAtIndex:indexPath.row];
    detailVC.blogObject = post;
    
    [[AppDelegate sharedAppDelegate].nc pushViewController:detailVC animated:YES];
}

@end
