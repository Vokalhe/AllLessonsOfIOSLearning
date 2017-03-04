//
//  EVAStudent.h
//  CoreDataIntro
//
//  Created by Admin on 19.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
//typedef enum{
//    Men,
//    Women
//} Gender;
@interface EVAStudent : NSObject
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *dateOfBirth;
@property (strong, nonatomic) NSString *gender;
@property (assign, nonatomic) NSInteger grade;
@property (weak, nonatomic) id myFriend;
@end
