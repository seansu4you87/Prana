//
//  PRWorkspacesViewController.m
//  prana
//
//  Created by Sean Yu on 9/23/12.
//  Copyright (c) 2012 Sean Yu. All rights reserved.
//

#import "PRWorkspacesViewController.h"

#import "PRProjectsViewController.h"

#import "Ardha.h"

@interface PRWorkspacesViewController ()

@property(nonatomic, strong) AUser *me;
@property(nonatomic, strong) UIView *headerView;

- (AWorkspace *)workspaceAtIndex:(NSInteger)index;

@end

@implementation PRWorkspacesViewController

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
	
    [AUser meWithBlock:^(AUser *me) {
		_me = me;
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AWorkspace *)workspaceAtIndex:(NSInteger)index
{
	NSArray *keyArray = [[_me workspaces] allKeys];
    AWorkspace *workspace = [[_me workspaces] objectForKey:[keyArray objectAtIndex:index]];
	
	return workspace;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_me.workspaces count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WorkspaceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    AWorkspace *workspace = [self workspaceAtIndex:indexPath.row];
	
	cell.textLabel.text = workspace.name;
    
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
	/*ECSlidingViewController *layer2 = (ECSlidingViewController *)self.slidingViewController.topViewController;
	PRProjectsViewController *projectsViewController = (PRProjectsViewController *)layer2.underLeftViewController;
	projectsViewController.workspace = [self workspaceAtIndex:indexPath.row];
	
	[self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
		[self.slidingViewController resetTopView];
		[projectsViewController.tableView reloadData];
	}];*/
	
	PRProjectsViewController *projectsViewController = [[PRProjectsViewController alloc] init];
	projectsViewController.workspace = [self workspaceAtIndex:indexPath.row];
	[self.navigationController pushViewController:projectsViewController animated:YES];
}

@end
