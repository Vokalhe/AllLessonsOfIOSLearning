//
//  DataManager.m
//  CoreData
//
//  Created by Admin on 29.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import "DataManager.h"
#import "Students.h"
#import "Courses.h"
#import "Teachers.h"

static NSString* firstNames[] = {
    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie"
};

static NSString* lastNames[] = {
    
    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
    @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
    @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
    @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook"
};

/*static NSString* email[] = {
    @"@yandex.ru", @"@google.com", @"@icloud.com", @"@mail.ru"
};*/

static int namesCount = 50;

@implementation DataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Singleton
+(DataManager*) sharedManager{
    static DataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
       // [manager generateEducationSphere];

    });
    return manager;
}

#pragma mark - Standart Methods
-(NSURL*) applicationDocumentsDirectory{
    return[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreData" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {

    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreData.sqlite"];
    NSError *error = nil;
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {

    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Save
- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
    
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
            
        }
    }
}

#pragma mark - AddObjects
-(Teachers*)addRandomTeacher {
    
    Teachers* teacher = [NSEntityDescription insertNewObjectForEntityForName:@"Teachers"
                                                     inManagedObjectContext:self.managedObjectContext];
    
    teacher.firstName = firstNames[arc4random_uniform(namesCount)];
    teacher.lastName = lastNames[arc4random_uniform(namesCount)];
    
    return teacher;
    
}

-(Students*) addRandomStudent {
    
    Students* student = [NSEntityDescription insertNewObjectForEntityForName:@"Students"
                                                     inManagedObjectContext:self.managedObjectContext];
    
    student.firstName = firstNames[arc4random_uniform(namesCount)];
    student.lastName = lastNames[arc4random_uniform(namesCount)];
    student.email = [[NSString stringWithFormat:@"%@-%@@gmail.com", student.firstName, student.lastName] lowercaseString];
    
    return student;
    
}

-(Courses*) addCourseWithName:(NSString*)name {
    
    Courses* course = [NSEntityDescription insertNewObjectForEntityForName:@"Courses" inManagedObjectContext:self.managedObjectContext];
    
    course.nameOfCourse = name;
    
    return course;
}

-(void)generateEducationSphere{
    
    [self deleteAllObjects];
    
    NSArray* courses = @[[self addCourseWithName:@"iOS"],
                         [self addCourseWithName:@"Android"],
                         [self addCourseWithName:@"PHP"],
                         [self addCourseWithName:@"JavaScript"],
                         [self addCourseWithName:@"HTML"]];
    
    
    for (int i = 0; i < 100; i++) {
        Students* student = [self addRandomStudent];
        
        NSInteger numberOfCourses = 1 + arc4random_uniform(5);
        
        while ([student.courses count] < numberOfCourses) {
            Courses* course = [courses objectAtIndex:arc4random_uniform(5)];
            
            if (![student.courses containsObject:course]) {
                [student addCoursesObject:course];
            }
        }
    }
    
    for (int i = 0; i < 7; i++) {
        
        Teachers* teacher = [self addRandomTeacher];
        
        NSInteger numberOfCourses = 1 + arc4random_uniform(3);
        
        while ([teacher.courses count] < numberOfCourses) {
            Courses* course = [courses objectAtIndex:arc4random_uniform(5)];
            
            if (![teacher.courses containsObject:course]) {
                [teacher addCoursesObject:course];
            }
        }
    }
    
    [self.managedObjectContext save:nil];
    [self printAllObjects];
}

#pragma mark - RemoveObjects

-(void) deleteAllObjects {
    
    for (id object in [self allObjects]) {
        [self.managedObjectContext deleteObject:object];
    }
    
    [self.managedObjectContext save:nil];
}

-(NSArray*)allObjects {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Object"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    
    NSError* error = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    return resultArray;
}

#pragma mark - Print

-(void)printArray:(NSArray*)array {
    
    for (id object in array) {
        
        if ([object isKindOfClass:[Teachers class]]) {
            
            Teachers* teacher = (Teachers*)object;
            NSLog(@"TEACHER: %@ %@, NUMBER OF COURSES: %lu", teacher.firstName, teacher.lastName, [teacher.courses count]);
            
        } else if ([object isKindOfClass:[Students class]]) {
            
            Students* student = (Students*)object;
            NSLog(@"STUDENT: %@ %@, COURSES: %lu",
                  student.firstName, student.lastName,
                  [student.courses count]);
            
        } else if ([object isKindOfClass:[Courses class]]) {
            
            Courses* course = (Courses*)object;
            NSLog(@"COURSE: %@, %lu students", course.nameOfCourse, [course.studentsInCourse count]);
        }
    }
    
    NSLog(@"COUNT: %lu", (unsigned long)[array count]);
}


-(void) printAllObjects {
    
    NSArray* allObjects = [self allObjects];
    
    [self printArray:allObjects];
    
}


@end
