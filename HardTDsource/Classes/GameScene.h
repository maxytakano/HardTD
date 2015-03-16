//
//  GameScene.h
//  HardTD
//
//  Created by Max Takano on 8/11/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------

//#import <GameKit/GameKit.h>   // dont think I need this

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using Cocos2D v3
#import "cocos2d.h"
#import "cocos2d-ui.h"

// Import HUD
#import "HUD.h"

// TODO: import folders instead of individual files

// Import Enemies
#import "BasicEnemy.h"

// Import Buildings
#import "BasicTower.h"
#import "SplitTower.h"

// Import Tower Spawns
#import "BasicBullet.h"

// Import HUD
#import "ImagePanel.h"
#import "InformationPanel.h"
#import "ButtonPanel.h"

@class TowerSpawn;
@class Building;

// The main scene
// TODO: split a lot of methods in this file into separate files/classes
@interface GameScene : CCScene {
    int wave;
    int playerHp;
    BOOL gameEnded;
    int playerGold;
    int playerResource2;
    int playerResource3;
    CCLabelBMFont *ui_gold_lbl;
    CCLabelBMFont *ui_hp_lbl;
    CCLabelBMFont *ui_wave_lbl;

    
    // String holding the current selected object's name
    /*
    
    // Dictionary taking the buttonName_currentState and returning associated building Name
    NSDictionary *buttonToBuilding;
    
    // Which page the right hand hud is currently on
    int hudPage;
     */
}

@property (nonatomic, strong) NSMutableArray *building_bases;
@property (nonatomic, strong) NSMutableArray *buildings;
@property (nonatomic, strong) NSMutableArray *waypoints;
@property (nonatomic, strong) NSMutableArray *enemies;
@property (nonatomic, strong) NSMutableArray *bullets;
@property (nonatomic, strong) NSMutableDictionary *hudComponents;
// String holding the current selected object's name
@property (nonatomic,strong) id currentlySelected;

+ (GameScene *)scene;
- (id)init;     // Note: this was commented out why?
- (BOOL)circle:(CGPoint)circlePoint withRadius:(float)radius
        collisionWithCircle:(CGPoint)circlePointTwo collisionCircleRadius:(float)radiusTwo;
- (void)enemyGotKilled;
- (void)getHpDamage:(int)livesTaken;
- (void)doGameOver;
- (void)awardGold:(int)gold resource2:(int)r2 resource3:(int)r3;
- (void)removeGameObject:(TowerSpawn *)gameObject;
- (void)selectObject:(id)selectedObject;

// -----------------------------------------------------------------------
@end