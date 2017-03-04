//
//  Teachers+CoreDataProperties.h
//  CoreData
//
//  Created by Admin on 06.12.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Teachers.h"

NS_ASSUME_NONNULL_BEGIN

@interface Teachers (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSSet<Courses *> *courses;

@end

@interface Teachers (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(Courses *)value;
- (void)removeCoursesObject:(Courses *)value;
- (void)addCourses:(NSSet<Courses *> *)values;
- (void)removeCourses:(NSSet<Courses *> *)values;

@end

NS_ASSUME_NONNULL_END
