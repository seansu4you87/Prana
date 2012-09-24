//
//  PRProjectsViewController.h
//  prana
//
//  Created by Sean Yu on 9/23/12.
//  Copyright (c) 2012 Sean Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IIViewDeckController.h"

@class AWorkspace;

@interface PRProjectsViewController : UITableViewController

@property (nonatomic, strong) AWorkspace *workspace;

//- (IBAction)revealWorkspaces:(id)sender;


@end
