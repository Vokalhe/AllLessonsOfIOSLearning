//
//  UIView+SuperTableViewCell.m
//  CoreData
//
//  Created by Admin on 07.12.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import "UIView+SuperTableViewCell.h"

@implementation UIView (SuperTableViewCell)
-(UITableViewCell*) superTableViewCell {
    
    if ([self isKindOfClass:[UITableViewCell class]]) {
        return (UITableViewCell*)self;
    }
    
    if (!self.superview) {
        return nil;
    }
    
    return [self.superview superTableViewCell];
}

@end
