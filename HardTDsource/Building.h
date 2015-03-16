//
//  AppDelegate.h
//  HardTD
//
//  Created by Max Takano on 8/11/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "cocos2d.h"

//#define BUILDING_COST 300

@class GameScene;

@interface Building: CCNode


// a list of buttons a building has
@property (nonatomic, strong) NSMutableArray *buttons;


@property (nonatomic, assign) int upgradeLevel;
//@property (strong) NSMutableArray *upgradeCosts;
@property (nonatomic, assign) int sellValue;
//@property (strong) transform into;
@property (nonatomic, assign) int transformCost;
//@property (strong) NSMutableArray *upgradeData;


@property (nonatomic, weak) GameScene *theGame;
@property (nonatomic, strong) CCSprite *mySprite;
@property (nonatomic, strong) CCSprite *selectionSprite;

@property (nonatomic, strong) NSString *artSpriteName;


// TODO: will need to have some sort of image passed into it
- (id)initWithTheGame:(GameScene *)_game location:(CGPoint)location;
- (void)upgrade;
- (void)sell;       // Depricated: decided to just sell from the button handler instead (might be bad)
- (void)getSelected;
- (void)getUnselected;
//- (void)transform:intothis;   // TODO: implement transform


@end