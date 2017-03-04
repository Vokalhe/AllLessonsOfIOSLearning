//
//  PopoverViewController.m
//  MKMapView
//
//  Created by Admin on 13.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import "PopoverViewController.h"

@implementation PopoverViewController 
- (instancetype)initWithStudent:(EVAStudent*) student
{
    self = [super init];
    if (self) {
        self.firstNameLabel.text = student.firstName;

    }
    return self;
}
-(void) showText:(EVAStudent *)student{
    self.firstNameLabel.text = student.firstName;
}
@end
