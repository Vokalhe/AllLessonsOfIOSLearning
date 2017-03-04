//
//  EVAMessage.h
//  EVAAPIProjectForVK
//
//  Created by Admin on 05.03.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAObjectServer.h"

typedef enum{
    MessageTypeMine = 1,
    MessageTypeYour = 2
} MessageType;

@interface EVAMessage : EVAObjectServer

@property (strong, nonatomic) NSArray *messageID;
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSNumber *fromID;
@property (assign, nonatomic) MessageType type;

@end
