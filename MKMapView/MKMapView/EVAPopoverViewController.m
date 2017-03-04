//
//  EVAPopoverViewController.m
//  MKMapView
//
//  Created by Admin on 13.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import "EVAPopoverViewController.h"

@interface EVAPopoverViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) CLGeocoder *geoCoder;

@end

@implementation EVAPopoverViewController


-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.geoCoder = [[CLGeocoder alloc] init];
    CLLocationCoordinate2D coordinate = self.student.location;
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    __weak EVAPopoverViewController *weakSelf = self;

    dispatch_async(dispatch_get_main_queue(),  ^{
        [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError * _Nullable error) {
            
            NSString *messega = nil;
            
            if (error) {
                messega = [error localizedDescription];
            }else{
                if ([placemarks count] > 0) {
                    MKPlacemark *placeMark = [placemarks firstObject];
                    messega = [placeMark.addressDictionary descriptionInStringsFileFormat];
                }else{
                    messega = @"No placemarks found";
                }
                
            }
            weakSelf.ibAddressLabel.text = messega;
            weakSelf.ibAddressTextView.text = messega;
            NSLog(@"1%@", messega);
            [weakSelf.tableView reloadData];
        }];

    });
    
    
    self.ibFirstNameLabel.text = self.student.firstName;
    self.ibLastNameLabel.text = self.student.lastName;
    
    NSString *gender;
    if (self.student.gender == 0) {
        gender = @"Men";
    } else {
        gender = @"Women";
    }
    self.ibGenderLabel.text = gender;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc{
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
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
