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
 * A simple tower spawn subclass.  A tower spawn that move to the enemy then on contact (within a 
 * certain radius of the enemy) dies and damages the enemy for a a damage amount.  Basically a 
 * kamikaze tower spawn.
 **/
@interface Bullet : TowerSpawn

@property (nonatomic, assign) CGPoint velocity;
@property (nonatomic, assign) CGPoint acceleration;
@property (nonatomic, assign) float maxVelocity;
@property (nonatomic, assign) float maxAcceleration;


@property (nonatomic, assign) int bulletDamage;
@property (nonatomic, strong) Enemy *currentEnemy;

@end
