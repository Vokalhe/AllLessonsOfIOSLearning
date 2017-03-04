//
//  MKAnnotationView+UIView.m
//  MKMapView
//
//  Created by Admin on 13.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import "MKAnnotationView+UIView.h"
#import <MapKit/MKAnnotationView.h>
@implementation MKAnnotationView (UIView)
-(MKAnnotationView*) superAnnoatationView{
    if ([self isKindOfClass:[MKAnnotationView class]]) {
        return (MKAnnotationView*)self;
    }
    if (!self.superview) {
        return nil;
    }
    return [self.superview superAnnoatationView];
}


@end
