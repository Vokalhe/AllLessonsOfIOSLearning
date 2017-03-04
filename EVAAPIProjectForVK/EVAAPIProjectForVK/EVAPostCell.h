//
//  EVAPostCell.h
//  EVAAPIProjectForVK
//
//  Created by Admin on 15.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EVAPost;

@interface EVAPostCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
//@property (weak, nonatomic) IBOutlet UILabel *postTextLabel;
//@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *imageURL;
@property (strong, nonatomic) UILabel *commentLabel;
@property (strong, nonatomic) UILabel *postTextLabel;
@property (strong, nonatomic) UILabel *likeLabel;
@property (strong, nonatomic) UIImageView *imageURL;
@property (strong, nonatomic) UIImageView *imagePostURL;

@property (strong, nonatomic) UILabel *nameOwnerLabel;
@property (strong, nonatomic) UILabel *dateLabel;
//@property (weak, nonatomic) IBOutlet UILabel *nameOwnerLabel;
//@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void) configureCellWithPostOnWall:(EVAPost*) postOnWall viewController: (UIViewController*) vc;
+(CGFloat) heightForText:(NSString *)text viewController: (UIViewController*) vc;
+ (CGFloat) heightForPostOnWall:(EVAPost*) postOnWall viewController: (UIViewController*) vc;

@end
