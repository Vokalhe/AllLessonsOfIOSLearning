//
//  ViewController.m
//  Gestures
//
//  Created by Admin on 13.09.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//
/*
 Ученик
 1. Добавьте квадратную картинку на вьюху вашего контроллера
 2. Если хотите, можете сделать ее анимированной
 
 Студент
 3. По тачу анимационно передвигайте картинку со ее позиции в позицию тача
 4. Если я вдруг делаю тач во время анимации, то картинка должна двигаться в новую точку без рывка (как будто она едет себе и все)
 
 Мастер
 5. Если я делаю свайп вправо, то давайте картинке анимацию поворота по часовой стрелке на 360 градусов
 6. То же самое для свайпа влево, только анимация должна быть против часовой (не забудьте остановить предыдущее кручение)
 7. По двойному тапу двух пальцев останавливайте анимацию
 
 Супермен
 8. Добавьте возможность зумить и отдалять картинку используя пинч
 9. Добавьте возможность поворачивать картинку используя ротейшн
 */
#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>
@property (assign, nonatomic) UIView *viewMain;
@property (assign, nonatomic) CGFloat viewScale;
@property (assign, nonatomic) CGFloat viewRotation;

#define piP 3.14
#define piM -3.14

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *viewImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds)-50,
                                                                        CGRectGetMidY(self.view.bounds)-50, 100, 100)];
    viewImage.backgroundColor = [UIColor clearColor];
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    viewImage.image = image;
    [self.view addSubview:viewImage];
    self.viewMain = viewImage;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tap];
    
    
    UISwipeGestureRecognizer *swipeLeftGorizontal = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(handleLeftSwipe:)];
    swipeLeftGorizontal.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftGorizontal];
    
    UISwipeGestureRecognizer *swipeRightGorizontal = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(handleRightSwipe:)];
    swipeRightGorizontal.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightGorizontal];
    
    UITapGestureRecognizer *doubleTapDoubleTouch = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self action:@selector(handleDoubleTapDoubleTouch:)];
    doubleTapDoubleTouch.numberOfTapsRequired = 2;
    doubleTapDoubleTouch.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:doubleTapDoubleTouch];
    
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(handleRotation:)];
    rotation.delegate = self;
    [self.view addGestureRecognizer:rotation];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self
                                                                             action:@selector(handlePinch:)];
    pinch.delegate = self;
    [self.view addGestureRecognizer:pinch];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - GestureRecognizer
-(void) handleTap:(UITapGestureRecognizer*) tap{
    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.viewMain.center = [tap locationInView:self.view];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

-(void) handleDoubleTapDoubleTouch:(UITapGestureRecognizer*) tapTouch{
    [self.viewMain.layer removeAllAnimations];
}

-(void) handleLeftSwipe:(UISwipeGestureRecognizer*) swipe{
    CGAffineTransform currentTransform = self.viewMain.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, piM);
    [UIView animateWithDuration:3 delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.viewMain.transform = newTransform;
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"1");
                     }];
}
-(void) handleRightSwipe:(UISwipeGestureRecognizer*) swipe{
    CGAffineTransform currentTransform = self.viewMain.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, piP);
    [UIView animateWithDuration:3 delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.viewMain.transform = newTransform;
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"2");
                     }];
}

-(void) handleRotation:(UIRotationGestureRecognizer*) rotation{
    if (rotation.state == UIGestureRecognizerStateBegan) {
        self.viewRotation = 0.f;
    }
    CGFloat newRotation = rotation.rotation - self.viewRotation;
    CGAffineTransform currentTransform = self.viewMain.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, newRotation);
    self.viewMain.transform = newTransform;
    self.viewRotation = rotation.rotation;
}

-(void) handlePinch:(UIPinchGestureRecognizer*) pinch{
    if (pinch.state == UIGestureRecognizerStateBegan) {
        self.viewScale = 1.f;
    }
    CGFloat newScale = 1.f + pinch.scale - self.viewScale;
    CGAffineTransform currentTransform = self.viewMain.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    self.viewMain.transform = newTransform;
    self.viewScale = pinch.scale;
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return  YES;
}
@end
