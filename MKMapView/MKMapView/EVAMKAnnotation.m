//
//  EVAMKAnnotation.m
//  MKMapView
//
//  Created by Admin on 10.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import "EVAMKAnnotation.h"

@implementation EVAMKAnnotation
- (id)initWithStudent:(EVAStudent*)student
{
    self = [super init];
    if (self) {
        self.student = student;
        self.title = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
        self.subtitle = [NSString stringWithFormat:@"%u", student.gender];
        self.coordinate = student.location;
    }
    return self;
}

@end
