//
//  DetailViewController.h
//  CoreData
//
//  Created by Admin on 28.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

