//
//  PRProjectsViewController.m
//  prana
//
//  Created by Sean Yu on 9/23/12.
//  Copyright (c) 2012 Sean Yu. All rights reserved.
//

#import "PRProjectsViewController.h"

#import "PRTasksViewController.h"

#import "Ardha.h"

@interface PRProjectsViewController ()

@property (nonatomic, strong) IBOutlet UINavigationBar *navBar;

- (AProject *)projectAtIndex:(NSInteger)index;

@end

@implementation PRProjectsViewController

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

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setWorkspace:(AWorkspace *)workspace
{
	if (self.workspace == workspace)
		return;
	_workspace = workspace;
	
	self.title = self.workspace.name;
}

- (AProject *)projectAtIndex:(NSInteger)index
{
	NSArray *keyArray = [[[self workspace] projects] allKeys];
    AProject *project = [[[self workspace] projects] objectForKey:[keyArray objectAtIndex:index]];
	
	return project;
}

#pragma mark - Actions

- (IBAction)revealWorkspaces:(id)sender
{
	[self.slidingViewController.slidingViewController anchorTopViewTo:ECRight];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self workspace] projects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProjectCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    AProject *project = [self projectAtIndex:indexPath.row];
    
    [[cell textLabel] setText:[project name]];
    
    return cell;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UINavigationController *topNav = (UINavigationController *)self.slidingViewController.topViewController;
	PRTasksViewController *tasksViewController = (PRTasksViewController *)topNav.topViewController;
	tasksViewController.project = [self projectAtIndex:indexPath.row];
	tasksViewController.title = tasksViewController.project.name;
	
	[self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
		[self.slidingViewController resetTopView];
		[tasksViewController.tableView reloadData];
	}];
}

@end
