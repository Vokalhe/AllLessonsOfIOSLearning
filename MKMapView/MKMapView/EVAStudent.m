//
//  EVAStudent.m
//  MKMapView
//
//  Created by Admin on 10.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import "EVAStudent.h"

@implementation EVAStudent
-(NSString*) randomString{
    NSString *letters = @"qweasdzxcRTYFGHVBN";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:5];
    for (int i = 0; i < 5; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random()%[letters length]]];
    }
    return randomString;
}
-(CLLocationCoordinate2D) randomLocation:(CLLocationCoordinate2D) ourCoordinate{
    double latitude;
    double longitude;
    int num = arc4random()%4;
    if (num == 0) {
        latitude = ourCoordinate.latitude + arc4random()%5;
        longitude = ourCoordinate.longitude + arc4random()%5;
    } else if(num == 1){
        latitude = ourCoordinate.latitude - arc4random()%5;
        longitude = ourCoordinate.longitude - arc4random()%5;
    } else if(num == 2){
        latitude = ourCoordinate.latitude + arc4random()%5;
        longitude = ourCoordinate.longitude - arc4random()%5;
    } else if(num == 3){
        latitude = ourCoordinate.latitude - arc4random()%5;
        longitude = ourCoordinate.longitude + arc4random()%5;
    }
    

    CLLocationCoordinate2D randomLocation;
    randomLocation.latitude = latitude;
    randomLocation.longitude = longitude;
    return randomLocation;
}

-(Gender) randomGender{
    Gender gender;
    int num = arc4random()%2;
    if (num == 0) {
        gender = Men;
    } else {
        gender = Women;
    }
    NSLog(@"%d", num);
    return gender;
}
@end
