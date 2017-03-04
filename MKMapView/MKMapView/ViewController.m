//
//  ViewController.m
//  MKMapView
//
//  Created by Admin on 10.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "EVAStudent.h"
#import "EVAMKAnnotation.h"
#import "EVAAnnotationMeeting.h"
#import "EVAPopoverViewController.h"
#import "UIView+MKAnnotationView.h"
#import "EVAInfoView.h"
@interface ViewController () <MKMapViewDelegate, UIPopoverControllerDelegate>
@property (strong, nonatomic) NSMutableArray *arrayOfStudents;
@property (strong, nonatomic) UIPopoverController *popover;
@property (strong, nonatomic) EVAMKAnnotation *studentAnnotation;
@property (strong, nonatomic) MKAnnotationView *myAnnotationView;
@property (strong, nonatomic) EVAInfoView *infoView;
@property (strong, nonatomic) MKDirections *directions;
@property (strong, nonatomic) EVAAnnotationMeeting *meeting;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    EVAInfoView *info = [[EVAInfoView alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];// (30, 90, 200, 100)];
    
    self.infoView = info;
    
    [self.ibMapView addSubview:self.infoView];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc{
    if ([self.directions isCalculating]) {
        [self.directions cancel];
    }
}
#pragma mark - PrivateMethods
- (NSArray *)countStudentInCircleCoordinate:(CLLocationCoordinate2D)location forRadius:(int)radius {
    
    CLLocation *startLocation = [[CLLocation alloc]initWithLatitude:location.latitude longitude:location.longitude];
    
    int count = 0;
    
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    
    for (id <MKAnnotation> annotation in self.ibMapView.annotations) {
        
        if ([annotation isKindOfClass:[EVAMKAnnotation class]]) {
            
            CLLocation *tempLocation = [[CLLocation alloc]initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
            
            CLLocationDistance dist = [startLocation distanceFromLocation:tempLocation];
            
            if (radius > dist) {
                count++;
                [tempArray addObject:annotation];
            }
            
        }
        
    }
    
    if (radius == 150000) {
        self.infoView.infoLabel1.text = [NSString stringWithFormat:@"radius %d student %d",radius,count];
    } else if (radius == 300000) {
        self.infoView.infoLabel2.text = [NSString stringWithFormat:@"radius %d student %d",radius,count];
    } else if (radius == 450000) {
        self.infoView.infoLabel3.text = [NSString stringWithFormat:@"radius %d student %d",radius,count];
    }
    
    return tempArray;
}

-(void) addRouteForAnotationCoordinate:(CLLocationCoordinate2D)endCoordinate startCoordinate:(CLLocationCoordinate2D)startCoordinate {
    
    MKDirectionsRequest* request = [[MKDirectionsRequest alloc] init];
    
    MKPlacemark* startPlacemark = [[MKPlacemark alloc] initWithCoordinate:startCoordinate
                                                        addressDictionary:nil];
    
    MKMapItem* startDestination = [[MKMapItem alloc] initWithPlacemark:startPlacemark];
    
    request.source = startDestination;
    
    MKPlacemark* endPlacemark = [[MKPlacemark alloc] initWithCoordinate:endCoordinate
                                                      addressDictionary:nil];
    
    MKMapItem* endDestination = [[MKMapItem alloc] initWithPlacemark:endPlacemark];
    
    request.destination = endDestination;
    request.transportType = MKDirectionsTransportTypeAutomobile;
    request.requestsAlternateRoutes = YES;
    
    self.directions = [[MKDirections alloc] initWithRequest:request];
    
    [self.directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        
        if (error) {
            
        } else if ([response.routes count] == 0) {
            
        } else {
            NSMutableArray *array = [NSMutableArray array];
            for (MKRoute *route in response.routes){
                [array addObject:route.polyline];
            }
            [self.ibMapView addOverlays:array level:MKOverlayLevelAboveRoads];
        }
    }];
    
}


-(void) drawCircle:(EVAAnnotationMeeting*) annotation{
    
    MKCircle *circle1 = [MKCircle circleWithCenterCoordinate:annotation.coordinate radius:450000];
    MKCircle *circle2 = [MKCircle circleWithCenterCoordinate:annotation.coordinate radius:300000];
    MKCircle *circle3 = [MKCircle circleWithCenterCoordinate:annotation.coordinate radius:150000];

    [self countStudentInCircleCoordinate:annotation.coordinate forRadius:450000];
    [self countStudentInCircleCoordinate:annotation.coordinate forRadius:300000];
    [self countStudentInCircleCoordinate:annotation.coordinate forRadius:150000];

    [self.ibMapView addOverlays:@[circle1, circle2, circle3]];
    
}
-(void) showConroller:(UIViewController*) vc inPopoverFromSender:(UIButton*) sender{
    
    if (!sender) {
        return;
    }
    vc.preferredContentSize = CGSizeMake(300, 300);
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:vc];
    popover.delegate = self;
    self.popover = popover;
    
    [popover presentPopoverFromRect:[(UIButton*)sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:NO];
    });

}
-(void) showConrollerAsModal:(UIViewController*) vc{
    
    [self presentViewController:vc animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
    
}

-(void) showDescription:(UIButton*) sender{
    
    MKAnnotationView *an = [sender superAnnoatationView];
    EVAStudent *student = [(EVAMKAnnotation*)an.annotation student];
    
    EVAPopoverViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PopoverViewController"];
    vc.student = student;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self showConroller:vc inPopoverFromSender:sender];
    } else {
        [self showConrollerAsModal:vc];
    }
    
}
-(void) createStudents:(CLLocationCoordinate2D) coordinate{
    
    for (int i = 0; i < 25; i++) {
        EVAStudent *student = [[EVAStudent alloc] init];
        student.firstName = [student randomString];
        student.lastName = [student randomString];
        student.location = [student randomLocation:coordinate];
        student.gender = [student randomGender];
        [self.arrayOfStudents addObject:student];
    }
    
}

#pragma mark - Actions
- (IBAction)actionSearch:(UIBarButtonItem *)sender {
    
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in self.ibMapView.annotations) {
        CLLocationCoordinate2D location = annotation.coordinate;
        MKMapPoint center = MKMapPointForCoordinate(location);
        static double delta = 10000;
        MKMapRect rect = MKMapRectMake(center.x-delta, center.y-delta, delta*2, delta*2);
        zoomRect = MKMapRectUnion(zoomRect, rect);
    }
    zoomRect = [self.ibMapView mapRectThatFits:zoomRect];
    [self.ibMapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(50, 50, 50, 50) animated:YES];
    
}

- (IBAction)actionAddStudents:(UIBarButtonItem *)sender {
    
    for (EVAStudent *std in self.arrayOfStudents) {
        EVAStudent* student = std;
        EVAMKAnnotation* annotation = [[EVAMKAnnotation alloc] initWithStudent:student];
        [self.ibMapView addAnnotation:annotation];
    }
    
}

- (IBAction)actionAdd:(UIBarButtonItem *)sender {
    
    self.arrayOfStudents = [[NSMutableArray alloc] init];
    EVAStudent *student = [[EVAStudent alloc] init];
    student.firstName = @"My location";
    student.lastName = @"Victor";
    student.location = self.ibMapView.region.center;
    student.gender = Men;
    [self.arrayOfStudents addObject:student];

    EVAMKAnnotation *annotation = [[EVAMKAnnotation alloc] initWithStudent:student];

    [self.ibMapView addAnnotation:annotation];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        [self createStudents:annotation.coordinate];
    });
    
}

- (IBAction)actionAddMeeting:(UIBarButtonItem *)sender {
    
    EVAStudent *student = [[EVAStudent alloc] init];
    CLLocationCoordinate2D location = [student randomLocation:self.ibMapView.region.center];
    EVAAnnotationMeeting *meeting = [[EVAAnnotationMeeting alloc] initWithNameMeeting:@"Meetimg"
                                                                        andCLLocation:location];
    self.meeting = meeting;
    [self.ibMapView addAnnotation:self.meeting];
    
    [self drawCircle:self.meeting];
    
}

- (IBAction)actionDrawRoute:(UIBarButtonItem *)sender {
    
    if ([self.directions isCalculating]) {
        [self.directions cancel];
    }

    for (id <MKAnnotation> obj in [self countStudentInCircleCoordinate:self.meeting.coordinate forRadius:450000]) {
        
        [self addRouteForAnotationCoordinate:[obj coordinate] startCoordinate:self.meeting.coordinate];
        
    }
    
}

#pragma mark - UIPopoverControllerDelegate
-(void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    self.popover = nil;
}
#pragma mark - MKMapViewDelegate
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
 
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    if ([annotation isKindOfClass:[EVAMKAnnotation class]]) {
        
        static NSString* identifier = @"StudentAnnotation";
        
        MKAnnotationView* studentAnnotation = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (!studentAnnotation) {
            studentAnnotation = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            
            studentAnnotation.canShowCallout = YES;
            studentAnnotation.draggable = NO;
            
            UIButton* descriptionButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [descriptionButton addTarget:self
                                  action:@selector(showDescription:)
                        forControlEvents:UIControlEventTouchUpInside];
            
            studentAnnotation.rightCalloutAccessoryView = descriptionButton;
            self.myAnnotationView = studentAnnotation;
        } else {
            studentAnnotation.annotation = annotation;
        }
        
        EVAStudent* student = [(EVAMKAnnotation*)annotation student];
       
        if (student.gender == Men) {
            studentAnnotation.image = [UIImage imageNamed:@"men.png"];
        }else if (student.gender == Women){
            studentAnnotation.image = [UIImage imageNamed:@"women.png"];
        }
        return studentAnnotation;
        
    }
    else if ([annotation isKindOfClass:[EVAAnnotationMeeting class]]){
        static NSString* identifier = @"MeetingAnnotation";
        
        MKAnnotationView* meetingAnnotation = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (!meetingAnnotation) {
            meetingAnnotation = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            
            meetingAnnotation.canShowCallout = YES;
            meetingAnnotation.draggable = YES;
            meetingAnnotation.image = [UIImage imageNamed:@"meeting.png"];
            self.myAnnotationView = meetingAnnotation;
        } else {
            meetingAnnotation.annotation = annotation;
        }
        
        return meetingAnnotation;

    }
    return nil;

}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState{
    
    if ([self.myAnnotationView isKindOfClass:[EVAMKAnnotation class]]) {
        
    EVAMKAnnotation *annotationNew = view.annotation;
    [self createStudents:annotationNew.coordinate];
        
    }else {
        
        EVAAnnotationMeeting *annotationNew = view.annotation;
        [self.ibMapView removeOverlays:mapView.overlays];
        [self drawCircle:annotationNew];
        
    }
}

 - (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
     
     if ([overlay isKindOfClass:[MKCircle class]]) {
         
         MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithCircle:(MKCircle *)overlay];
         circleRenderer.strokeColor = [UIColor greenColor];
         circleRenderer.lineWidth = 3.f;
         return circleRenderer;
         
     }
     if ([overlay isKindOfClass:[MKPolyline class]]) {
         
         MKPolylineRenderer* lineRenderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
         lineRenderer.lineWidth = 3.f;
         lineRenderer.strokeColor = [UIColor redColor];
         return lineRenderer;
         
     }
     
     return nil;

 }


#pragma mark - TheTask
/*
 Ученик.
 
 1. Создайте массив из 10 - 30 рандомных студентов, прямо как раньше, только в этот раз пусть у них наряду с именем и фамилией будет еще и координата. Можете использовать структуру координаты, а можете просто два дабла - лонгитюд и латитюд.
 
 2. Координату генерируйте так, установите центр например в вашем городе и просто генерируйте небольшие отрицательные либо положительные числа, чтобы рандомно получалась координата от центра в пределах установленного радиуса.
 
 (Ну а если совсем не получается генерировать координату, то просто ставьте им заготовленные координаты - это не главное)
 
 3. После того, как вы сгенерировали своих студентов, покажите их всех на карте, причем в титуле пусть будет Имя и Фамилия а в сабтитуле год рождения. Можете для каждого студента создать свою аннотацию, а можете студентов подписать на протокол аннотаций и добавить их на карту напрямую - как хотите :)
 +
 Студент.
 
 4. Добавьте кнопочку, которая покажет всех студентов на экране.+
 
 5. Вместо пинов на карте используйте свои кастомные картинки, причем если студент мужского пола, то картинка должна быть одна, а для девушек другая.+
 +
 Мастер
 
 6. У каждого колаута (этого облачка над пином) сделайте кнопочку информации справа так, что когда я на нее нажимаю вылазит поповер, в котором в виде статической таблицы находится имя и фамилия студента, год рождения, пол и самое главное адрес.
 
 7. В случае если это телефон, то вместо поповера контроллер должен вылазить модально.
 +
 Супермен
 
 8. Создайте аннотацию для места встречи и показывайте его на карте новымой соответствующей картинкой+
 
 9. Место встречи можно перемещать по карте, а студентов нет+
 
 10. Когда место встречи бросается на карту, то вокруг него надо рисовать 3 круга, с радиусами 5 км, 10 км и 15 км (используйте оверлеи)+
 
 11. На какой-то полупрозрачной вьюхе в одном из углов вам надо показать сколько студентов попадают в какой круг. Суть такая, чем дальше студент живет, тем меньше вероятность что он придет на встречу. Расстояние от студента до места встречи рассчитывайте используя функцию для расчета расстояния между точками, поищите ее в фреймворке :)
 +
 12. Сделайте на навигейшине кнопочку, по нажатию на которую, от рандомных студентов до нее будут проложены маршруты (типо студенты идут на сходку), притом вероятности генератора разные, зависит от круга, в котором они находятся, если он близко, то 90%, а если далеко - то 10%+
 */

@end
