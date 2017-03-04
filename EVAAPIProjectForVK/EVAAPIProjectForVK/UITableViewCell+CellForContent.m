//
//  UITableViewCell+CellForContent.m
//  EVAAPIProjectForVK
//
//  Created by Admin on 01.03.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "UITableViewCell+CellForContent.h"

@implementation UITableViewCell (CellForContent)
+ (UITableViewCell*) getParentCellFor:(UIView*) view {
    
    UIView* superView = [view superview];
    
    if (!superView) {
        return nil;
    } else if (![superView isKindOfClass:[UITableViewCell class]]) {
        return [self getParentCellFor:superView];
    } else {
        return (UITableViewCell*)superView;
    }
    return nil;
}

@end
