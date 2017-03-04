//
//  EVAStudent.h
//  MKMapView
//
//  Created by Admin on 10.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef enum{
    Men = 0,
    Women = 1
}Gender;

@interface EVAStudent : NSObject
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) CLLocationCoordinate2D location;
@property (assign, nonatomic) Gender gender;

-(NSString*) randomString;
-(Gender) randomGender;
-(CLLocationCoordinate2D) randomLocation:(CLLocationCoordinate2D) ourCoordinate;

@end
