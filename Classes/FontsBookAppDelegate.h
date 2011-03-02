//
//  FontsBookAppDelegate.h
//  FontsBook
//
//  Created by Giovambattista Fazioli on 23/02/11.
//  Copyright 2011 Saidmade Srl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontsBookAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

