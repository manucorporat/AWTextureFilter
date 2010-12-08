//
//  AWTextureFilterAppDelegate.h
//  AWTextureFilter
//
//  Created by Manuel Martinez-Almeida on 08/12/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AWTextureFilterAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
