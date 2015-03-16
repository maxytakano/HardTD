//
//  AppDelegate.h
//  HardTD
//
//  Created by Max Takano on 8/11/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "Bullet.h"
#import "Enemy.h"

/**
 * The most basic Bullet Tower Spawn.  Has a damage and a velocity.
 **/
@interface BasicBullet : Bullet

+(id)nodeWithTheGame:(GameScene *)_game enemy:(Enemy *)curEnemy
        bulletDamage:(int)damage maxVelocity:(float)velocity;
-(id)initWithTheGame:(GameScene *)_game enemy:(Enemy *)curEnemy
        bulletDamage:(int)damage maxVelocity:(float)velocity;

@end
