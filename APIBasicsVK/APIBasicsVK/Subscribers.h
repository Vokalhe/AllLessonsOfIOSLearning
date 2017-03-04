//
//  Subscribers.h
//  APIBasicsVK
//
//  Created by Admin on 02.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Subscribers : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSURL *imageURL;
-(id) initWithServerResponse:(NSDictionary *)responseObject;
@end
