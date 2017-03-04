//
//  EVAPostCell.m
//  EVAAPIProjectForVK
//
//  Created by Admin on 15.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAPostCell.h"
#import "EVAPost.h"

@implementation EVAPostCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+(CGFloat) heightForText:(NSString *)text viewController: (UIViewController*) vc{
    CGFloat widthView = CGRectGetWidth(vc.view.bounds);

    CGFloat offset = 10.0;
    UIFont *font = [UIFont systemFontOfSize:14.f];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0, -1);
    shadow.shadowBlurRadius = 0.5;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraph setAlignment:NSTextAlignmentCenter];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                font, NSFontAttributeName,
                                paragraph, NSParagraphStyleAttributeName, nil];
    
    CGRect rect = [text boundingRectWithSize: CGSizeMake(widthView-2*offset, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    
    return CGRectGetHeight(rect);
    
}
////


+ (CGFloat) heightForPostOnWall:(EVAPost*) postOnWall viewController: (UIViewController*) vc {
    
    CGFloat widthView = CGRectGetWidth(vc.view.bounds);
    
    CGFloat heightLikeLabel = 20.0;
    CGFloat heightImageLabel = widthView/8;//50.0;
    
    CGFloat separatorHeight = 5;
    
    CGFloat height = separatorHeight + heightImageLabel + 15 + heightLikeLabel + 10;
    
    
    if (postOnWall.postImageURL) {
        
        CGFloat postImageHeigth = widthView - 20;
        height += postImageHeigth + 5;
    }
    
    if (postOnWall.text) {
        CGFloat heightForText = [EVAPostCell heightForText:postOnWall.text viewController:vc];
        height += heightForText + 5;
    }
    return height;
}


- (void) configureCellWithPostOnWall:(EVAPost*) postOnWall viewController: (UIViewController*) vc {
    
    for (UIView* view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    // Separator
    CGRect frameForSeparator = CGRectMake(0, 0, self.frame.size.width, 5);
    UIView* separator = [[UIView alloc] initWithFrame:frameForSeparator];
    separator.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:separator];
    
    CGFloat originY = CGRectGetHeight(frameForSeparator);
    
    // Owner Image View
    CGRect frameForOwnerPhoto = CGRectMake(5, originY + 10,
                                           CGRectGetWidth(self.bounds)/8, CGRectGetWidth(self.bounds)/8);
    
    self.imageURL = [[UIImageView alloc] initWithFrame:frameForOwnerPhoto];
    [self.contentView addSubview:self.imageURL];
    
    
    // Owner Name Label
    CGRect frameForOwnerName = CGRectMake(CGRectGetWidth(frameForOwnerPhoto)+15, originY + 10, CGRectGetWidth(self.bounds)/2, 21.f);
    self.nameOwnerLabel = [[UILabel alloc] initWithFrame:frameForOwnerName];
    [self.contentView addSubview:self.nameOwnerLabel];
    
    
    // Owner Date Label
    CGRect frameForDateLabel = CGRectMake(CGRectGetWidth(frameForOwnerPhoto)+15, originY + 10 + CGRectGetHeight(frameForOwnerName),
                                          CGRectGetWidth(self.bounds)/2, 21.f);
    
    self.dateLabel = [[UILabel alloc] initWithFrame:frameForDateLabel];
    [self.contentView addSubview:self.dateLabel];
    
    originY += CGRectGetHeight(self.imageURL.bounds)+10;
    
    
    if (postOnWall.text) {
        
        CGFloat heightForText = [EVAPostCell heightForText:postOnWall.text viewController:vc];
        CGRect frameForTextLabel = CGRectMake(10, originY+10, CGRectGetWidth(vc.view.bounds)-20, heightForText);
        self.postTextLabel = [[UILabel alloc] initWithFrame:frameForTextLabel];
        self.postTextLabel.numberOfLines = 0;
        self.postTextLabel.font = [self.postTextLabel.font fontWithSize:14];
        
        [self.contentView addSubview:self.postTextLabel];
        originY += CGRectGetHeight(self.postTextLabel.bounds)+10;
    }
    
    if (postOnWall.postImageURL) {
        
        CGRect frameForImageView = CGRectMake(5, originY+5,
                                              CGRectGetWidth(vc.view.bounds)-20, CGRectGetWidth(vc.view.bounds)-20);
        
        self.imagePostURL = [[UIImageView alloc] initWithFrame:frameForImageView];
        [self.contentView addSubview:self.imagePostURL];
        
        originY += CGRectGetHeight(self.imagePostURL.bounds)+5;
    }
    
    
    CGRect frameForLikesLabel = CGRectMake(5, originY+10, CGRectGetWidth(vc.view.bounds)/2-20, 21.f);
    CGRect frameForRepostLabel = CGRectMake(CGRectGetWidth(vc.view.bounds)/2+5, originY+10, CGRectGetWidth(vc.view.bounds)/2-20, 21.f);
    
    self.likeLabel = [[UILabel alloc] initWithFrame:frameForLikesLabel];
    [self.contentView addSubview:self.likeLabel];
    
    self.commentLabel = [[UILabel alloc] initWithFrame:frameForRepostLabel];
    [self.contentView addSubview:self.commentLabel];
    
}

@end
