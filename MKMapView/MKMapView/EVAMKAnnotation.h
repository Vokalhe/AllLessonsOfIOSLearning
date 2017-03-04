//
//  EVAMKAnnotation.h
//  MKMapView
//
//  Created by Admin on 10.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
#import "EVAStudent.h"


@interface EVAMKAnnotation : NSObject <MKAnnotation>
@property(assign, nonatomic) CLLocationCoordinate2D coordinate;
@property(copy, nonatomic) NSString *title;
@property(copy, nonatomic) NSString *subtitle;
@property (strong, nonatomic) EVAStudent *student;
- (id)initWithStudent:(EVAStudent*)student;
@end
