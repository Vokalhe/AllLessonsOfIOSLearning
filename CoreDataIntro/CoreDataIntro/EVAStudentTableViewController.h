//
//  EVAStudentTableViewController.h
//  CoreDataIntro
//
//  Created by Admin on 18.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EVAStudentTableViewController : UITableViewController  
@property (weak, nonatomic) IBOutlet UITextField *ibLastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ibFirstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ibDateOfBirthTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ibGenderSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *ibGradeTextField;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *ibTextFieldsArray;

- (IBAction)actionTextChangedNow:(UITextField *)sender;

- (IBAction)actionChangedGender:(UISegmentedControl *)sender;
- (IBAction)actionResetProperty:(UIButton *)sender;
- (IBAction)actionNextStudent:(UIButton *)sender;

@end
