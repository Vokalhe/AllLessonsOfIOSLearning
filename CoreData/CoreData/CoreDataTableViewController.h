//
//  CoreDataTableViewController.h
//  CoreData
//
//  Created by Admin on 29.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"


@interface CoreDataTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
