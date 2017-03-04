//
//  ViewController.m
//  UIWebView
//
//  Created by Admin on 15.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import "ViewController.h"
#import "EVAWebViewController.h"
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) NSArray *arrayOfPDF;
@property (strong, nonatomic) NSArray *arrayOfURL;
@property (strong, nonatomic) EVAWebViewController *webVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayOfPDF = [[NSArray alloc] initWithObjects:@"iOSVidmetest.pdf", @"Lecture 6.pdf", nil];
    self.arrayOfURL = [[NSArray alloc] initWithObjects:@"http://stackoverflow.com/questions/409259/having-a-uitextfield-in-a-uitableviewcell", @"http://www.imaladec.com/story/content-lessons", nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return [self.arrayOfPDF count];
    } else {
        return [self.arrayOfURL count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:identifier];
        if ([indexPath section] == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.arrayOfPDF objectAtIndex:indexPath.row]];
        } else if ([indexPath section] == 1) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.arrayOfURL objectAtIndex:indexPath.row]];
        }
        
    }
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"PDF";
    } else {
        return @"URL";
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.webVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EVAWebViewController"];
    NSString *path;
    
    //EVAWebViewController *webViewController = [[EVAWebViewController alloc] init];
    if (indexPath.section == 0) {
        path = [NSString stringWithFormat:@"%@",[self.arrayOfPDF objectAtIndex:indexPath.row]];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:nil];
        self.webVC.address = [NSURL fileURLWithPath:filePath];
    } else if (indexPath.section == 1) {
        path = [NSString stringWithFormat:@"%@", [self.arrayOfURL objectAtIndex:indexPath.row]];
        self.webVC.address = [NSURL URLWithString:path];

    }

    [self.navigationController pushViewController:self.webVC animated:YES];
    
}

#pragma mark - Task
/*
 1. Сделайте один контроллер с таблицей, в ней две секции: pdf и url+
 2. Присоедините к проекту парочку pdf файлов, их имена должны быть в таблице+
 3. Добавьте парочку web сайтов во вторую секцию+
 4. Когда я нажимаю на ячейку, то через пуш навигейшн должен отобразиться либо пдф либо web+
 5. Надеюсь понятно что для загрузки того либо другого мы используем один и тот же контроллев с UIWebView и иницианизируем его нужным NSURL+
 6. На веб вью должна быть крутилка, а в навигейшине кнопки назад и вперед+
 */
@end
