//
//  StudentsTableViewController.m
//  CoreData
//
//  Created by Admin on 29.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import "StudentsTableViewController.h"
#import "Students.h"
#import "DataManager.h"
#import "DetailsTableViewController.h"
@interface StudentsTableViewController ()

@end

@implementation StudentsTableViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - PrivateMethods

-(NSFetchedResultsController*) fetchedResultsController{
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;

    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Students" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *firstNameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor *lastNameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    [fetchRequest setSortDescriptors:@[firstNameSortDescriptor, lastNameSortDescriptor]];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];//studetn = @"university.name   cache - nil
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    NSError *error = nil;
    
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"%@ - %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    Students* student = (Students*)object;
    //Students *student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
    cell.detailTextLabel.text = nil;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {й
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailsTableViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsTableViewController"];
    
    vc.className = [Students class];
    vc.object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)actionAdd:(UIBarButtonItem*)sender {
    
    DetailsTableViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsTableViewController"];
    
    vc.className = [Students class];
    vc.object = nil;
    
    [self.navigationController pushViewController:vc animated:YES];
}
@end
