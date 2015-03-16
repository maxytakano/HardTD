//
//  AppDelegate.h
//  HardTD
//
//  Created by Max Takano on 8/11/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "TowerSpawn.h"
#import "Enemy.h"

@class GameScene;

/**
 * Class Description: A more complicated TowerSpawn example, to be made into minions and other
 * Tower spawns later
 **/
@interface MoreComplicatedTowerSpawn : TowerSpawn

@property (assign) CGPoint velocity;
@property (assign) CGPoint acceleration;
@property (assign) float maxVelocity;
@property (assign) float maxAcceleration;

@property (assign) BOOL isRanged;
@property (assign) float rangedRange;
@property (assign) float rangedDamage;
@property (assign) float rangedDamageRate;
@property (assign) float rangedLastDamageTime;
//@property (strong) NSString * rangedSound;

@property (assign) BOOL isMelee;
@property (assign) float meleeDamage;
@property (assign) BOOL meleeDestroySelf;
@property (assign) float meleeDamageRate;
@property (assign) float meleeLastDamageTime;
@property (assign) BOOL meleeAoe;
//@property (strong) NSString * meleeSound;

@property (assign) int bulletDamage;
@property (assign) Enemy *currentEnemy;

@end
