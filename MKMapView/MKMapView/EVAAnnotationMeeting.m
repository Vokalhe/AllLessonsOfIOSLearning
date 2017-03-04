//
//  EVAAnnotationMeeting.m
//  MKMapView
//
//  Created by Admin on 14.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import "EVAAnnotationMeeting.h"

@implementation EVAAnnotationMeeting
- (id)initWithNameMeeting:(NSString*) name andCLLocation:(CLLocationCoordinate2D) coordinate{
    self = [super init];
    if (self) {
        
        self.coordinate = coordinate;
        
        self.title = name;
        
    }
    return self;

}

@end
