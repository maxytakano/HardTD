//
//  MenuScene.h
//  HardTD
//
//  Created by Max Takano on 8/11/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using cocos2d-v3
#import "cocos2d.h"
#import "cocos2d-ui.h"

// -----------------------------------------------------------------------

/**
 *  Future MenuScene, currently just transitions to the game scene.
 */
@interface MenuScene : CCScene

// -----------------------------------------------------------------------

+ (MenuScene *)scene;
- (id)init;

// -----------------------------------------------------------------------
@end