//
//  EVAAnnotationMeeting.h
//  MKMapView
//
//  Created by Admin on 14.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface EVAAnnotationMeeting : NSObject <MKAnnotation>
@property(assign, nonatomic) CLLocationCoordinate2D coordinate;
@property(copy, nonatomic) NSString *title;
@property(copy, nonatomic) NSString *subtitle;
- (id)initWithNameMeeting:(NSString*) name andCLLocation:(CLLocationCoordinate2D) coordinate;
@end
