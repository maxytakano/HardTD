//
//  AppDelegate.h
//  HardTD
//
//  Created by Max Takano on 8/11/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "cocos2d.h"

@class GameScene;

/**
 * This is the highest level object that all towers create, Towers can create any type of 
 * projectile or minion to aid the tower
 **/
//@interface GameObject : CCSprite
@interface TowerSpawn : CCNode




@property (nonatomic, assign) float curHp;
@property (nonatomic, assign) float maxHp;
@property (nonatomic, assign) BOOL alive;

@property (nonatomic, assign) BOOL attacking;

// TODO: Still need to figure out the differnce on strong/weak
@property (nonatomic, weak) GameScene *theGame;
//@property (strong) GameScene *theGame;

@property (nonatomic, strong) CCSprite *mySprite;

// TODO: will need to have some sort of image passed into it
-(id)initWithTheGame:(GameScene *)_game;

//- (id)initWithSpriteFrameName:(NSString *)spriteFrameName layer:(GameScene *)layer;


@end
