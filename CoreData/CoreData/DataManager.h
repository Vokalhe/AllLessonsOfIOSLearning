//
//  DataManager.h
//  CoreData
//
//  Created by Admin on 29.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Teachers, Students, Courses;
@interface DataManager : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(DataManager*) sharedManager;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

-(Students*)addRandomStudent;
-(Teachers*)addRandomTeacher;
-(Courses*)addCourseWithName:(NSString*)name;

-(void)generateEducationSphere;

@end


