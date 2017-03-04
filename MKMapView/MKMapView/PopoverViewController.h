//
//  PopoverViewController.h
//  MKMapView
//
//  Created by Admin on 13.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import "ViewController.h"
#import "EVAStudent.h"
@interface PopoverViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

- (instancetype)initWithStudent:(EVAStudent*) student;
-(void) showText:(EVAStudent*) student;
@end
