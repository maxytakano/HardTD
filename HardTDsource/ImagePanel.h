//
//  ImagePanel.h
//  HardTD
//
//  Created by Max Takano on 9/10/14.
//  Copyright (c) 2014 Max Takano. All rights reserved.
//
#import "HUD.h"
//#import "cocos2d-ui.h" !! might need this


// The imagePanel displays the art for the currently selected object.
@interface ImagePanel : HUD

@property (nonatomic, strong) CCSprite *currentSprite;

// Default node ctor. Calls init.
+(id)nodeWithTheGame:(GameScene*)_game;
// Inits the CCSpriteFrame to hold the art images.
-(id)initWithTheGame:(GameScene*)_game;

// Updates the SpriteFrame to a different image.
- (void)updateImage:(NSString *)imageString;

@end

