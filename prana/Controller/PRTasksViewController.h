//
//  PRTasksViewController.h
//  prana
//
//  Created by Sean Yu on 9/23/12.
//  Copyright (c) 2012 Sean Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IIViewDeckController.h"

@class AProject;

@interface PRTasksViewController : UITableViewController

@property(nonatomic, strong) AProject *project;

- (IBAction)revealBase:(id)sender;

@end
