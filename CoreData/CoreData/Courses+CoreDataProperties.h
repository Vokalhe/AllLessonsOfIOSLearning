//
//  Courses+CoreDataProperties.h
//  CoreData
//
//  Created by Admin on 06.12.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Courses.h"

NS_ASSUME_NONNULL_BEGIN

@interface Courses (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *nameOfCourse;
@property (nullable, nonatomic, retain) NSSet<Students *> *studentsInCourse;
@property (nullable, nonatomic, retain) NSSet<Teachers *> *teachersOfCourse;

@end

@interface Courses (CoreDataGeneratedAccessors)

- (void)addStudentsInCourseObject:(Students *)value;
- (void)removeStudentsInCourseObject:(Students *)value;
- (void)addStudentsInCourse:(NSSet<Students *> *)values;
- (void)removeStudentsInCourse:(NSSet<Students *> *)values;

- (void)addTeachersOfCourseObject:(Teachers *)value;
- (void)removeTeachersOfCourseObject:(Teachers *)value;
- (void)addTeachersOfCourse:(NSSet<Teachers *> *)values;
- (void)removeTeachersOfCourse:(NSSet<Teachers *> *)values;

@end

NS_ASSUME_NONNULL_END
