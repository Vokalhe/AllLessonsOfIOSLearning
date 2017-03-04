//
//  EVAInfoView.m
//  MKMapView
//
//  Created by Admin on 14.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import "EVAInfoView.h"

@implementation EVAInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.layer.cornerRadius = 10.f;
        self.backgroundColor = [UIColor grayColor];
        self.alpha = 0.5;
        
        UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200, 33)];
        UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 200, 33)];
        UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 65, 200, 33)];
        
        self.infoLabel1 = lb1;
        self.infoLabel2 = lb2;
        self.infoLabel3 = lb3;
        
        [self addSubview:self.infoLabel1];
        [self addSubview:self.infoLabel2];
        [self addSubview:self.infoLabel3];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
