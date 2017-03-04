//
//  ViewController.m
//  UIViewAnimations
//
//  Created by Admin on 06.09.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//
/*
 Ученик.
 
 1. Создайте 4 вьюхи у левого края ипада.
 2. Ваша задача всех передвинуть горизонтально по прямой за одно и тоже время
 3. Для каждой вьюхи используйте свою интерполяцию (EasyInOut, EasyIn и т.д.). Это для того, чтобы вы увидели разницу своими собственными глазами :)
 4. Добавте реверсивную анимацию и бесконечные повторения
 5. добавьте смену цвета на рандомный
 
 Студент
 
 5. Добавьте еще четыре квадратные вьюхи по углам - красную, желтую, зеленую и синюю
 6. За одинаковое время и при одинаковой интерполяции двигайте их всех случайно, либо по, либо против часовой стрелки в другой угол.
 7. Когда анимация закончиться повторите все опять: выберите направление и передвиньте всех :)
 8. Вьюха должна принимать в новом углу цвет той вьюхи, что была здесь до него ;)
 
 Мастер
 
 8. Нарисуйте несколько анимационных картинок человечка, который ходит.
 9. Добавьте несколько человечков на эту композицию и заставьте их ходить
 
 Супермена на этот раз нет, ничего сверхъестественного не смог придумать :(
 */
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) UIView *testView1;
@property (weak, nonatomic) UIView *testView2;
@property (weak, nonatomic) UIView *testView3;
@property (weak, nonatomic) UIView *testView4;

@property (weak, nonatomic) UIView *randView1;
@property (weak, nonatomic) UIView *randView2;
@property (weak, nonatomic) UIView *randView3;
@property (weak, nonatomic) UIView *randView4;

@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) NSArray *arrayImages;

@property (assign, nonatomic) CGFloat minNum;
@property (weak, nonatomic) UIImageView *viewImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.minNum = MIN(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    self.testView1 = [self createViewSize:self.minNum/10 andWidth:0 andHeight:self.minNum*0.4 andColor:[UIColor grayColor]];
    self.testView2 = [self createViewSize:self.minNum/10 andWidth:0 andHeight:self.minNum*0.5 andColor:[UIColor grayColor]];;
    self.testView3 = [self createViewSize:self.minNum/10 andWidth:0 andHeight:self.minNum*0.6 andColor:[UIColor grayColor]];;
    self.testView4 = [self createViewSize:self.minNum/10 andWidth:0 andHeight:self.minNum*0.7 andColor:[UIColor grayColor]];;
    
    
    self.randView1 = [self createViewSize:self.minNum/10 andWidth:0 andHeight:0 andColor:[UIColor redColor]];
    self.randView2 = [self createViewSize:self.minNum/10 andWidth:CGRectGetWidth(self.view.bounds)-self.minNum/10 andHeight:0 andColor:[UIColor yellowColor]];;
    self.randView3 = [self createViewSize:self.minNum/10 andWidth:0 andHeight:CGRectGetHeight(self.view.bounds)-self.minNum/10 andColor:[UIColor greenColor]];;
    self.randView4 = [self createViewSize:self.minNum/10 andWidth:CGRectGetWidth(self.view.bounds)-self.minNum/10 andHeight:CGRectGetHeight(self.view.bounds)-self.minNum/10 andColor:[UIColor blueColor]];;
    
    UIImageView *viewI = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    viewI.backgroundColor = [UIColor clearColor];
    UIImage *image1 = [UIImage imageNamed:@"1.png"];
    UIImage *image2 = [UIImage imageNamed:@"2.png"];
    UIImage *image3 = [UIImage imageNamed:@"3.png"];
    self.arrayImages = [NSArray arrayWithObjects:image1, image2, image3, nil];
    viewI.animationImages = self.arrayImages;
    viewI.animationDuration = 3.f;
    [viewI startAnimating];
    [self.view addSubview:viewI];
    self.viewImage = viewI;

    // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self moveView:self.testView1 andX:self.minNum - CGRectGetWidth(self.testView1.frame)/2 andY:self.testView1.center.y andOptions:UIViewAnimationOptionCurveEaseInOut];
    [self moveView:self.testView2 andX:self.minNum - CGRectGetWidth(self.testView2.frame)/2 andY:self.testView2.center.y andOptions:UIViewAnimationOptionCurveEaseIn];
    [self moveView:self.testView3 andX:self.minNum - CGRectGetWidth(self.testView2.frame)/2 andY:self.testView3.center.y andOptions:UIViewAnimationOptionCurveEaseOut];
    [self moveView:self.testView4 andX:self.minNum - CGRectGetWidth(self.testView2.frame)/2 andY:self.testView4.center.y andOptions:UIViewAnimationOptionCurveLinear];
    
    /*[self moveRandView:self.randView1];
    [self moveRandView:self.randView2];
    [self moveRandView:self.randView3];
    [self moveRandView:self.randView4];*/
    self.array = [NSArray arrayWithObjects:self.randView1, self.randView2, self.randView3, self.randView4, nil];
    [self moveView:self.array withClockwiseDirection:arc4random() % 2];
    [self moveRandView:self.viewImage];

}

#pragma mark - New View
-(UIView*) createViewSize:(CGFloat) size andWidth:(CGFloat) x andHeight:(CGFloat) y andColor:(UIColor*) color{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(x, y, size, size)];
    //view.backgroundColor = [self randomColor];
    view.backgroundColor = color;
    [self.view addSubview:view];
    return view;
}
#pragma mark - Animations
-(void) moveView:(UIView*) view andX:(CGFloat) x andY:(CGFloat) y andOptions:(UIViewAnimationOptions) curve{
    [UIView animateWithDuration:8
                          delay:0
                        options:curve | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{
                            view.center = CGPointMake(x, y);
                            view.backgroundColor = [self randomColor];
                        } completion:^(BOOL finished) {
                            __weak UIView *v = view;
                            [self moveView:v andX:x andY:y andOptions:curve];
                        }];
}

- (void) moveView:(NSArray*) views withClockwiseDirection:(BOOL) clockwiseDirection {
    [UIView animateWithDuration:4
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         UIView* firstView = views[0];
                         UIView* lastView = views[[views count] - 1];
                         if (clockwiseDirection) {
                             CGPoint center = firstView.center;
                             UIColor* color = firstView.backgroundColor;
                             for (int i = 0; i < [views count] - 1; i++) {
                                 UIView* view = views[i];
                                 UIView* nextView = views[i + 1];
                                 view.backgroundColor = nextView.backgroundColor;
                                 view.center = nextView.center;
                                 
                             }
                             lastView.backgroundColor = color;
                             lastView.center = center;
                         } else {
                             CGPoint center = lastView.center;
                             UIColor* color = lastView.backgroundColor;
                             for (int i = [views count] - 1; i > 0; i--) {
                                 UIView* view = views[i];
                                 UIView* previousView = views[i - 1];
                                 view.backgroundColor = previousView.backgroundColor;
                                 view.center = previousView.center;
                             }
                             firstView.backgroundColor = color;
                             firstView.center = center;
                         }
                     }
                     completion:^(BOOL finished) {
                         __weak NSArray* v = views;
                         [self moveView:v withClockwiseDirection:arc4random() % 2];
                     }];
}

-(void) moveRandView:(UIView*) view{
    CGRect rect = self.view.bounds;
    rect = CGRectInset(rect, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(CGRectGetWidth(self.view.bounds), 0);
    CGPoint point3 = CGPointMake(0, CGRectGetHeight(self.view.bounds));
    CGPoint point4 = CGPointMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    NSArray *array = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:point1], [NSValue valueWithCGPoint:point2], [NSValue valueWithCGPoint:point3], [NSValue valueWithCGPoint:point4], nil];
    //__block NSInteger i = 0;
    //CGFloat x = arc4random()%(int)(CGRectGetWidth(rect) + CGRectGetMinX(rect));
    //CGFloat y = arc4random()%(int)(CGRectGetHeight(rect) + CGRectGetMinY(rect));
    [UIView animateWithDuration:3
                          delay:1
                        options:UIViewAnimationOptionCurveLinear //| UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{
                             CGPoint p = [[array objectAtIndex:arc4random()%4] CGPointValue];
                             view.center = p;
                    }
                     completion:^(BOOL finished) {
                             __weak UIView *v = view;
                             [self moveRandView:v];
                     }];
}
#pragma mark - Random Color
-(UIColor*) randomColor{
    CGFloat red = (CGFloat)(arc4random()%256)/255.f;
    CGFloat green = (CGFloat)(arc4random()%256)/255.f;
    CGFloat blue = (CGFloat)(arc4random()%256)/255.f;

    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    return color;
}
/*-(void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self viewDidAppear:YES];
}*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
