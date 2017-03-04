//
//  DetailsTableViewController.h
//  CoreData
//
//  Created by Admin on 06.12.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsTableViewController : UITableViewController <UITextFieldDelegate, UITableViewDelegate>

@property (strong, nonatomic) Class className;
@property (strong, nonatomic) NSObject *object;

@end
