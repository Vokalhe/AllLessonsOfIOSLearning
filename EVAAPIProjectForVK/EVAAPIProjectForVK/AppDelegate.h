//
//  AppDelegate.h
//  EVAAPIProjectForVK
//
//  Created by Admin on 11.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//
/*
 Ученик:
 
 1. Логин
 2. Отображение стены группы (посты)+
 3. Отображение количества лайков и комментариев на каждом посте (только цифры)+
 4. Добавление своего текста+
 
 Студент
 
 5. Отображение аватарки и имени и фамилии создателя поста, а также даты поста+
 6. По нажатию на аватарку юзера иметь возможность отправить ему личное сообщение
 7. Как следствие нужно иметь возможность читать свои сообщения и отвечать на них
 
 Мастер
 
 6. По нажатию на ячейку поста переход на контроллер, где видно сам пост + все комменты и все лайки.
 7. В том же контролере иметь возможность комментировать данный пост и ставить лайки
 
 Супермен
 
 8. Иметь возможность загружать фотографии с камеры или из библиотеки в фотоальбом группы
 9. Иметь возможность проигрывать видео урок
 */
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

