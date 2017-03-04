//
//  PostWallTableViewCell.h
//  APIBasicsVK
//
//  Created by Admin on 05.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Wall.h"
@interface PostWallTableViewCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *ownerImageView;
@property (strong, nonatomic)  UILabel *ownerNameLabel;
@property (strong, nonatomic)  UILabel *dateLabel;

@property (strong, nonatomic)  UIImageView *ownerCopyImageView;
@property (strong, nonatomic) UILabel *ownerCopyNameLabel;
@property (strong, nonatomic) UILabel *ownerCopyDateLabel;

@property (strong, nonatomic) UIImageView *imageViewInPost;
@property (strong, nonatomic) UITextView *textInPostTextView;
@property (strong, nonatomic) UILabel *likesLabel;
@property (strong, nonatomic) UILabel *repostLabel;

- (void) configureCellWithPostOnWall:(Wall*) postOnWall viewController: (UIViewController*) vc;

+ (CGFloat) heightForPostOnWall:(Wall*) postOnWall viewController: (UIViewController*) vc;

@end
