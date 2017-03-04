//
//  EVACustomTableViewCell.h
//  EVAAPIProjectForVK
//
//  Created by Admin on 15.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EVACustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *postTextLabel;
+ (CGFloat) heightForText:(NSString*) text;

@end
