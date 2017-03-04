//
//  ViewController.h
//  MKMapView
//
//  Created by Admin on 10.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKMapView;
@interface ViewController : UIViewController 
@property (weak, nonatomic) IBOutlet MKMapView *ibMapView;
- (IBAction)actionSearch:(UIBarButtonItem *)sender;
- (IBAction)actionAddStudents:(UIBarButtonItem *)sender;
- (IBAction)actionAdd:(UIBarButtonItem *)sender;
- (IBAction)actionAddMeeting:(UIBarButtonItem *)sender;
- (IBAction)actionDrawRoute:(UIBarButtonItem *)sender;

@end

