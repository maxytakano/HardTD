//
//  HUD.h
//  HardTD
//
//  Created by Max Takano on 9/7/14.
//  Copyright (c) 2014 Max Takano. All rights reserved.
//
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "Building.h"
#import "Enemy.h"


@class GameScene;

//  HUD parent class, has a selected object which children use to display data or buttons.
@interface HUD : CCNode

// String holding the current selected object's name
@property (nonatomic, strong) id currentlySelected;
//@property (nonatomic, strong) NSString *currentlySelected;
@property (nonatomic, weak) GameScene *theGame;


- (id)initWithTheGame:(GameScene *)_game;


@end
