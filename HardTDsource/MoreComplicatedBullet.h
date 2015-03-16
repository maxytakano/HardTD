//
//  AppDelegate.h
//  HardTD
//
//  Created by Max Takano on 8/11/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "MoreComplicatedTowerSpawn.h"
#import "Enemy.h"


@interface MoreComplicatedBullet : MoreComplicatedTowerSpawn


+(id)nodeWithTheGame:(GameScene *)_game enemy:(Enemy *)curEnemy;
-(id)initWithTheGame:(GameScene *)_game enemy:(Enemy *)curEnemy;

@end
