//
//  UITableViewCell+CellForContent.h
//  EVAAPIProjectForVK
//
//  Created by Admin on 01.03.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (CellForContent)
+ (UITableViewCell*) getParentCellFor:(UIView*) view;
@end
