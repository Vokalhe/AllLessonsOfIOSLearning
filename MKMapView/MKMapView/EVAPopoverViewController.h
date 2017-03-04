//
//  EVAPopoverViewController.h
//  MKMapView
//
//  Created by Admin on 13.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EVAStudent.h"

@interface EVAPopoverViewController : UITableViewController 
@property (weak, nonatomic) IBOutlet UILabel *ibFirstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ibLastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ibGenderLabel;
@property (weak, nonatomic) IBOutlet UILabel *ibAddressLabel;
@property (weak, nonatomic) IBOutlet UITextView *ibAddressTextView;
@property (strong, nonatomic) EVAStudent *student;
@end
