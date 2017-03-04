//
//  CoursesTableViewController.m
//  CoreData
//
//  Created by Admin on 07.12.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import "CoursesTableViewController.h"
#import "Courses.h"
#import "DataManager.h"
#import "DetailsTableViewController.h"
@interface CoursesTableViewController ()

@end

@implementation CoursesTableViewController
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
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Courses" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *firstNameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nameOfCourse" ascending:YES];
    [fetchRequest setSortDescriptors:@[firstNameSortDescriptor]];
    
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
    Courses* course = (Courses*)object;
    //Students *student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", course.nameOfCourse];
    cell.detailTextLabel.text = nil;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailsTableViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsTableViewController"];
    
    vc.className = [Courses class];
    vc.object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)actionAdd:(UIBarButtonItem*)sender {
    
    DetailsTableViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsTableViewController"];
    
    vc.className = [Courses class];
    vc.object = nil;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
