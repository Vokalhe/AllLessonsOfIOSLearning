//
//  WallTextTableViewCell.h
//  APIBasicsVK
//
//  Created by Admin on 06.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WallTextTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UILabel *date;

//@property (weak, nonatomic) IBOutlet UIImageView *copyPhoto;
//@property (weak, nonatomic) IBOutlet UILabel *copyFullName;
//@property (weak, nonatomic) IBOutlet UILabel *copyDate;

@property (weak, nonatomic) IBOutlet UITextView *superText;

@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *repostLabel;
@end
