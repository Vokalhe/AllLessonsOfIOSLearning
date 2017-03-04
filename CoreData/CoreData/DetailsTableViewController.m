//
//  DetailsTableViewController.m
//  CoreData
//
//  Created by Admin on 06.12.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import "DetailsTableViewController.h"

#import "DetailTableViewCell.h"
#import "UIView+SuperTableViewCell.h"
#import "DataManager.h"
#import "Students.h"
#import "Teachers.h"
#import "Courses.h"

@interface DetailsTableViewController ()

@property (strong, nonatomic) NSArray* students;
@property (strong, nonatomic) NSArray* teachers;
@property (strong, nonatomic) NSArray* courses;

@property (assign, nonatomic) BOOL allowInteraction;
@property (assign, nonatomic) BOOL isAddedSuccessfully;

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSString* email;

@end

@implementation DetailsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.students = [self studentsRequest];
    self.teachers = [self teachersRequest];
    self.courses = [self coursesRequest];
    
    self.allowInteraction = NO;
    self.isAddedSuccessfully = NO;
    
    [self.navigationItem setTitle:[NSString stringWithFormat: @"%@ details",self.className]];
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(actionAdd:)];
    if (!self.object) {
        
        if ([self.className isSubclassOfClass:[Courses class]]) {
            Courses* course = [NSEntityDescription insertNewObjectForEntityForName:@"Courses"
                                                           inManagedObjectContext:
                              [[DataManager sharedManager] managedObjectContext]];
            course.nameOfCourse = @"";
        
            self.object = course;
            
        } else if ([self.className isSubclassOfClass:[Students class]]) {
            Students* student = [NSEntityDescription insertNewObjectForEntityForName:@"Students"
                                                             inManagedObjectContext:
                                [[DataManager sharedManager] managedObjectContext]];
            student.firstName = @"";
            student.lastName = @"";
            student.email = @"";
            
            self.object = student;
            
        } else if ([self.className isSubclassOfClass:[Teachers class]]) {
            Teachers* teacher = [NSEntityDescription insertNewObjectForEntityForName:@"Teachers"
                                                             inManagedObjectContext:
                                [[DataManager sharedManager] managedObjectContext]];
            teacher.firstName = @"";
            teacher.lastName = @"";
            
            self.object = teacher;
        }
        
        self.navigationItem.rightBarButtonItem = addButton;
        self.allowInteraction = YES;
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    
    if (!self.isAddedSuccessfully && self.allowInteraction) {
        [[[DataManager sharedManager] managedObjectContext] deleteObject:self.object];
        [[[DataManager sharedManager] managedObjectContext] save:nil];
    }
    [self.navigationController popViewControllerAnimated:YES];
    self.object = nil;
    self.className = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

-(void)actionAdd:(UIBarButtonItem*)sender {
    
    BOOL willNotAddNewEntity = NO;
    
    if ([self.object isKindOfClass:[Courses class]]) {
        
        Courses* course = (Courses*)self.object;
        willNotAddNewEntity = [course.nameOfCourse isEqualToString:@""];
        
    } else if ([self.object isKindOfClass:[Students class]]) {
        
        Students* student = (Students*)self.object;
                    willNotAddNewEntity = !([student.firstName isEqualToString:@""] ||
                                            [student.lastName isEqualToString:@""]);// ||
                             //[student.email isEqualToString:@""]);
        NSLog(@"%d", [student.firstName isEqualToString:@""]);
        
        NSLog(@"%@", student.firstName);
        NSLog(@"%@", student.lastName);
        NSLog(@"%@", student.email);

    } else if ([self.object isKindOfClass:[Teachers class]]) {
        
        Teachers* teacher = (Teachers*)self.object;
        willNotAddNewEntity = ([teacher.firstName isEqualToString:@""] ||
                             [teacher.lastName isEqualToString:@""]);
    }
    
    if (!willNotAddNewEntity) {
        
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"There are empty fields!"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        
    } else {
        //[[DataManager sharedManager] saveContext];
        [[[DataManager sharedManager] managedObjectContext] save:nil];
        [[[UIAlertView alloc] initWithTitle:@"Success!"
                                    message:[NSString stringWithFormat:@"%@ added", self.className]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        self.isAddedSuccessfully = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - Requests

-(NSArray*)studentsRequest {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Students"
                                                   inManagedObjectContext:[[DataManager sharedManager] managedObjectContext]];
    
    [request setEntity:description];
    
    NSSortDescriptor* firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor* lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    
    [request setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
    
    return [[[DataManager sharedManager] managedObjectContext]
            executeFetchRequest:request
            error:nil];
}

-(NSArray*)teachersRequest {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Teachers" inManagedObjectContext:[[DataManager sharedManager] managedObjectContext]];
    
    [request setEntity:description];
    
    NSSortDescriptor* firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor* lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    
    [request setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
    
    return [[[DataManager sharedManager] managedObjectContext]
            executeFetchRequest:request
            error:nil];
}

-(NSArray*)coursesRequest {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Courses"
                                                   inManagedObjectContext:[[DataManager sharedManager] managedObjectContext]];
    
    [request setEntity:description];
    
    NSSortDescriptor* nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nameOfCourse" ascending:YES];
    
    [request setSortDescriptors:@[nameDescriptor]];
    
    return [[[DataManager sharedManager] managedObjectContext]
            executeFetchRequest:request
            error:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.className isSubclassOfClass:[Courses class]] ? 3 : 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if ([self.className isSubclassOfClass:[Courses class]]) {
        
        switch (section) {
            case 0:
                return 1;
                break;
            case 1:
                return [self.teachers count];
                break;
            case 2:
                return [self.students count];
                break;
            default:
                break;
        }
    } else if ([self.className isSubclassOfClass:[Students class]]) {
        
        return section ? [self.courses count] : 3;
        
    } else if ([self.className isSubclassOfClass:[Teachers class]]) {
        
        return section ? [self.courses count] : 2;
        
    }
    return 1;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self.className isSubclassOfClass:[Courses class]]) {
        switch (section) {
            case 0:
                return @"General";
                break;
            case 1:
                return @"Teachers";
                break;
            case 2:
                return @"Students";
                break;
            default:
                break;
        }
    } else if ([self.className isSubclassOfClass:[Students class]]) {
        return section ? @"Attends courses" : @"General";
    } else if ([self.className isSubclassOfClass:[Teachers class]]) {
        return section ? @"Teaches courses" : @"General";
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = nil;
    DetailTableViewCell* detailsCell = nil;
    
    //init cell
    
    if (indexPath.section == 0) {
        detailsCell = [tableView dequeueReusableCellWithIdentifier:@"detailsCell"
                                                      forIndexPath:indexPath];
        
        if (!detailsCell) {
            detailsCell = [[DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailsCell"];
        }
        
        detailsCell.textField.delegate = self;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                               forIndexPath:indexPath];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
    }
    
    //fill with data
    
    if ([self.className isSubclassOfClass:[Courses class]]) {
        
        Courses* course = (Courses*)self.object;
        
        
        if (indexPath.section == 0) {
            
            [detailsCell.label setText: @"Course name"];
            [detailsCell.textField setText: course.nameOfCourse];
            
        } else if (indexPath.section == 1) {
            Teachers* teacher = [self.teachers objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", teacher.firstName, teacher.lastName];
            
            if (course) {
                if ([course.teachersOfCourse containsObject:teacher]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            }
        } else if (indexPath.section == 2) {
            
            Students* student = [self.students objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
            
            if (course) {
                if ([course.studentsInCourse containsObject:student]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            }
        }
        
    } else if ([self.className isSubclassOfClass:[Students class]]) {
        
        Students* student = (Students*)self.object;
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                [detailsCell.label setText: @"First Name"];
                [detailsCell.textField setText: student.firstName];
                
            } else if (indexPath.row == 1) {
                [detailsCell.label setText: @"Last Name"];
                [detailsCell.textField setText: student.lastName];
            } else if (indexPath.row == 2) {
                [detailsCell.label setText: @"E-mail"];
                [detailsCell.textField setText: student.email];
                [detailsCell.textField setFont:[UIFont systemFontOfSize:14]];
            }
        } else {
            Courses* course = [self.courses objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@", course.nameOfCourse];
            
            if (student) {
                if ([student.courses containsObject:course]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            }
        }
    } else if ([self.className isSubclassOfClass:[Teachers class]]) {
        
        Teachers* teacher = (Teachers*)self.object;
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                [detailsCell.label setText: @"First Name"];
                [detailsCell.textField setText: teacher.firstName];
            } else if (indexPath.row == 1) {
                [detailsCell.label setText: @"Last Name"];
                [detailsCell.textField setText: teacher.lastName];
            }
            
        } else {
            Courses* course = [self.courses objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@", course.nameOfCourse];
            
            if (teacher) {
                if ([teacher.courses containsObject:course]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            }
        }
    }
    
    if(detailsCell) {
        [detailsCell.textField setUserInteractionEnabled:self.allowInteraction];
        return detailsCell;
    }
    
    return cell;
}//adasd

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BOOL isAdded = YES;
    
    if (indexPath.section != 0) {
        
        if ([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryNone) {
            [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
            isAdded = NO;
        }
        
        if ([self.object isKindOfClass:[Courses class]]) {
            if (indexPath.section == 1 && isAdded) {
                
                [(Courses*)self.object addTeachersOfCourseObject:[self.teachers objectAtIndex:indexPath.row]];
                
            } else if (indexPath.section == 1 && !isAdded) {
                
                [(Courses*)self.object removeTeachersOfCourseObject:[self.teachers objectAtIndex:indexPath.row]];
                
            } else if (indexPath.section == 2 && isAdded) {
                
                [(Courses*)self.object addStudentsInCourseObject:[self.students objectAtIndex:indexPath.row]];
                
            } else if (indexPath.section == 2 && !isAdded) {
                
                [(Courses*)self.object removeStudentsInCourseObject:[self.students objectAtIndex:indexPath.row]];
                
            }
        } else if ([self.object isKindOfClass:[Students class]]) {
            if (isAdded) {
                
                [(Students*)self.object addCoursesObject:[self.courses objectAtIndex:indexPath.row]];
                
            } else {
                [(Students*)self.object removeCoursesObject:[self.courses objectAtIndex:indexPath.row]];
            }
            
        } else if ([self.object isKindOfClass:[Teachers class]]) {
            if (isAdded) {
                [(Teachers*)self.object addCoursesObject:[self.courses objectAtIndex:indexPath.row]];
            } else {
                [(Teachers*)self.object removeCoursesObject:[self.courses objectAtIndex:indexPath.row]];
            }
        }
        [[DataManager sharedManager] saveContext];
    }
}

#pragma mark - TextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    self.tableView.scrollEnabled = NO;
}
//текст
-(void)textFieldDidEndEditing:(UITextField *)textField {
    self.tableView.scrollEnabled = YES;
    
    DetailTableViewCell* cell = [textField superTableViewCell];
    
    if ([self.object isKindOfClass:[Students class]]) {
        if ([cell.label.text isEqualToString:@"First Name"]) {
            [(Students*)self.object setFirstName:textField.text];
        } else if ([cell.label.text isEqualToString:@"Last Name"]) {
            [(Students*)self.object setLastName:textField.text];
        } else {
            [(Students*)self.object setEmail:textField.text];
        }
    } else if ([self.object isKindOfClass:[Teachers class]]) {
        if ([cell.label.text isEqualToString:@"First Name"]) {
            [(Teachers*)self.object setFirstName:textField.text];
        } else {
            [(Teachers*)self.object setLastName:textField.text];
        }
    } else {
        [(Courses*)self.object setNameOfCourse:textField.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    
    NSIndexPath* currentPath = [self.tableView indexPathForCell:[sender superTableViewCell]];
    if (currentPath.row < [self tableView:self.tableView numberOfRowsInSection:0] - 1) {
        
        [[(DetailTableViewCell*)[self.tableView cellForRowAtIndexPath:
                                  [NSIndexPath indexPathForRow:currentPath.row + 1 inSection:0]] textField] becomeFirstResponder];
        
    } else {
        
        [sender resignFirstResponder];
    }
    
    return YES;
}

@end
