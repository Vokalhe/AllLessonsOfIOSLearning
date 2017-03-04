//
//  EVAStudentTableViewController.m
//  CoreDataIntro
//
//  Created by Admin on 18.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//
#pragma mark - Task -
/*
 Ученик.
 
 1. Создайте класс студента с пропертисами firstName, lastName, dateOfBirth, gender, grade
 2. Также создайте статическую таблицу куда все эти данные выводятся и где их можно менять (с текст филдами, сенгментед контролами и тд)
 3. Пропертисы вашего студента меняйте тем же образом что и в предыдущих уроках (через делегаты и акшины)
 +
 Студент.
 
 4. Повесте обсервера на все пропертисы студента и выводите в консоль каждый раз, когда проперти меняется+
 5. Также сделайте метод "сброс", который сбрасывает все пропертисы, а в самом методе не используйте сеттеры, сделайте все через айвары, но сделайте так, чтобы обсервер узнал когда и что меняется. (типо как в уроке)
 +
 Мастер.
 
 забудьте про UI
 
 6. Создайте несколько студентов и положите их в массив, но обсервер оставьте только на одном из них+
 7. У студентов сделайте weak проперти "friend". Сделайте цепочку из нескольких студентов, чтобы один был друг второму, второй третьему, тот четвертому, а тот первому :)+
 8. Используя метод setValue: forKeyPath: начните с одного студента (не того, что с обсервером) и переходите на его друга, меняя ему проперти, потом из того же студента на друга его друга и тд (то есть путь для последнего студента получится очень длинный)+
 9. Убедитесь что на каком-то из друзей, когда меняется какой-то проперти, срабатывает ваш обсервер
 +
 Супермен
 
 10. Добавьте побольше студентов
 11. Используя операторы KVC создайте массив имен всех студентов+
 12. Определите саммый поздний и саммый ранний годы рождения+
 13. Определите сумму всех баллов студентов и средний бал всех студентов+
 +
 */

#import "EVAStudentTableViewController.h"
#import "EVAStudent.h"
@interface EVAStudentTableViewController () <UITextFieldDelegate>
//@property (strong, nonatomic) EVAStudent *student;
@property (strong, nonatomic) EVAStudent *showStudent;
@property (assign, nonatomic) NSInteger count;
@property (strong, nonatomic) NSMutableArray *arrayOfStudents;
@end

@implementation EVAStudentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 1;
    self.arrayOfStudents = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        EVAStudent *student = [[EVAStudent alloc] init];
        student.firstName = [self randomString];
        student.lastName = [self randomString];
        student.dateOfBirth = [self randomDateOfBirth];
        student.gender = arc4random()%2 ? @"Men" : @"Women";
        student.grade = arc4random()%4 + 1;
        if (i == 7) {
            [student addObserver:self forKeyPath:@"firstName" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
            [student addObserver:self forKeyPath:@"lastName" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
            [student addObserver:self forKeyPath:@"dateOfBirth" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
            [student addObserver:self forKeyPath:@"grade" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
            [student addObserver:self forKeyPath:@"gender" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
            self.showStudent= student;
        }
        [self.arrayOfStudents addObject:student];
    }
    
    for (int i = 0; i < [self.arrayOfStudents count]; i++) {
        EVAStudent *std = [self.arrayOfStudents objectAtIndex:i];
        if (i == 9) {
            std.myFriend = [self.arrayOfStudents objectAtIndex:0];
        }else{
            std.myFriend = [self.arrayOfStudents objectAtIndex:i+1];
        }
    }
    
    NSInteger num = 0;
    self.showStudent = [self.arrayOfStudents objectAtIndex:num];
    self.ibFirstNameTextField.text = self.showStudent.firstName;
    self.ibLastNameTextField.text = self.showStudent.lastName;
    self.ibDateOfBirthTextField.text = self.showStudent.dateOfBirth;
    
    if ([self.showStudent.gender isEqualToString:@"Men"]){
        self.ibGenderSegmentedControl.selectedSegmentIndex = 0;
    }else{
        self.ibGenderSegmentedControl.selectedSegmentIndex = 1;
    }
    self.ibGradeTextField.text = [NSString stringWithFormat:@"%d", self.showStudent.grade];

   // NSArray *arrayAllStudents = [self.arrayOfStudents valueForKeyPath:@"@distinctUnionOfArrays.objects"];
    NSArray *arrayOfNames = [self.arrayOfStudents valueForKeyPath:@"@distinctUnionOfObjects.firstName"];
    for (int i = 0; i <[arrayOfNames count]; i++) {
       // NSLog(@"%@", [arrayOfNames objectAtIndex:i]);
    }
    
    NSNumber *sum = [self.arrayOfStudents valueForKeyPath:@"@sum.grade"];
   // NSLog(@"%@", sum);
    
    NSNumber *minDate = [self.arrayOfStudents valueForKeyPath:@"@min.dateOfBirth"];
    NSNumber *maxDate = [self.arrayOfStudents valueForKeyPath:@"@max.dateOfBirth"];
    NSLog(@"%@", minDate);
    NSLog(@"%@", maxDate);


    
    
    
    /*self.student = [[EVAStudent alloc] init];
    [self.student addObserver:self forKeyPath:@"firstName" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.student addObserver:self forKeyPath:@"lastName" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.student addObserver:self forKeyPath:@"dateOfBirth" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.student addObserver:self forKeyPath:@"grade" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.student addObserver:self forKeyPath:@"gender" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    self.student.gender = @"Men";
    */
    //self.student.firstName = self.ibFirstNameTextField.text;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [self.showStudent removeObserver:self forKeyPath:@"firstName"];
    [self.showStudent removeObserver:self forKeyPath:@"lastName"];
    [self.showStudent removeObserver:self forKeyPath:@"dateOfBirth"];
    [self.showStudent removeObserver:self forKeyPath:@"grade"];
    [self.showStudent removeObserver:self forKeyPath:@"gender"];

}

#pragma mark - Private Methods
//-(NSString*) randomGrade{
//    NSArray *array = [NSArray arrayWithObjects:@"colledge", @"school", @"universitet", @"nothing", nil];
//    return [NSString stringWithFormat:@"%@", [array objectAtIndex:arc4random()%4]];
//}
- (NSString*) randomDateOfBirth{
    NSDate *dateCurrent = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:dateCurrent];
    NSInteger yearCurrent = [components year];
    NSInteger birthdateYear = yearCurrent - (arc4random() % 25 + 18);
    NSInteger birthdateDay = arc4random() % 31 + 1;
    NSInteger birthdateMonth = arc4random() % 12 + 1;
    
    [components setDay:birthdateDay];
    [components setMonth:birthdateMonth];
    [components setYear:birthdateYear];
    //NSDate *date = [NSDate date];
    //dateCurrent = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@", [calendar dateFromComponents:components]]];
    NSString *strDate = [NSString stringWithFormat:@"%d.%d.%d", [components day], [components month], [components year]];
    return strDate;
}

-(NSString*) randomString{
    NSString *letters = @"qwerasdfzxcvQWERASDFZXCV";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:5];
    for (int i = 0 ; i < 5; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random()%[letters length]]];
    }
    return randomString;
}
#pragma mark - Observing
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    NSLog(@"1.%@\n 2.%@\n 3.%@", keyPath, object, change);
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
            if ([textField isEqual:self.ibGradeTextField]){
                [textField resignFirstResponder];
            }else {
                [[self.ibTextFieldsArray objectAtIndex:[self.ibTextFieldsArray indexOfObject:textField]+1] becomeFirstResponder];
            }
    return YES;
    
}
#pragma mark - Actions

- (IBAction)actionTextChangedNow:(UITextField *)sender {
    switch (sender.tag) {
        case 0:
            self.showStudent.firstName = sender.text;
            break;
        case 1:
            self.showStudent.lastName = sender.text;
            break;
        case 2:
            self.showStudent.dateOfBirth = sender.text;
            break;
        case 3:
            self.showStudent.grade = sender.text;
            break;
    }
}

- (IBAction)actionChangedGender:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.showStudent.gender = @"Men";
    }else{
        self.showStudent.gender = @"Women";
    }
}

- (IBAction)actionResetProperty:(UIButton *)sender {
    
    [self willChangeValueForKey:@"firstName"];
    _showStudent.firstName = @"";
    [self didChangeValueForKey:@"firstName"];
    
    [self willChangeValueForKey:@"lastName"];
    _showStudent.lastName = @"";
    [self didChangeValueForKey:@"lastName"];
    
    [self willChangeValueForKey:@"dateOfBirth"];
    _showStudent.dateOfBirth = @"";
    [self didChangeValueForKey:@"dateOfBirth"];
    
    [self willChangeValueForKey:@"grade"];
    _showStudent.grade = @"";
    [self didChangeValueForKey:@"grade"];
    
    [self willChangeValueForKey:@"gender"];
    _showStudent.gender = @"";
    [self didChangeValueForKey:@"gender"];
    
    for (UITextField *tf in self.ibTextFieldsArray) {
        tf.text = @"";
    }
    self.ibGenderSegmentedControl.selectedSegmentIndex = 0;
    
}

- (IBAction)actionNextStudent:(UIButton *)sender {
    if(self.count == [self.arrayOfStudents count]){
        self.count = 0;
    }
    EVAStudent *newStudent = [[EVAStudent alloc] init];
    //newStudent = [self.arrayOfStudents objectAtIndex:self.count];
    newStudent = [self.showStudent valueForKeyPath:@"myFriend"];
   // [self.showStudent setValue:newStudent forKey:@"myFriend"];
    //NSString *path = [NSString stringWithFormat:@"arrayOfStudents.@objectAtIndex[%d]", self.count];
    //NSLog(@"111111111111%@", path);
    
   // self.showStudent = [newStudent valueForKeyPath:@"myFriend"];
    
    self.showStudent.firstName = newStudent.firstName;
    self.showStudent.lastName = newStudent.lastName;
    self.showStudent.dateOfBirth = newStudent.dateOfBirth;
    self.showStudent.gender = newStudent.gender;
    self.showStudent.grade = newStudent.grade;

    
    
    self.ibFirstNameTextField.text = newStudent.firstName;
    NSLog(@"%@", self.ibFirstNameTextField.text);
    NSLog(@"%@", newStudent.firstName);

    self.ibLastNameTextField.text = newStudent.lastName;
    self.ibDateOfBirthTextField.text = newStudent.dateOfBirth;
    
    
    
    if ([newStudent.gender isEqualToString:@"Men"]){
        self.ibGenderSegmentedControl.selectedSegmentIndex = 0;
    }else{
        self.ibGenderSegmentedControl.selectedSegmentIndex = 1;
    }
    self.ibGradeTextField.text = [NSString stringWithFormat:@"%d", newStudent.grade];
    
    self.showStudent = newStudent;
    self.count++;
    //setValue: forKeyPath:
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
