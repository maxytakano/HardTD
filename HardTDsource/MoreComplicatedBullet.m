//
//  AppDelegate.h
//  HardTD
//
//  Created by Max Takano on 8/11/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------


#import "MoreComplicatedBullet.h"

@implementation MoreComplicatedBullet


+(id)nodeWithTheGame:(GameScene*)_game enemy:(Enemy *)curEnemy{
    return [[self alloc] initWithTheGame:_game enemy:curEnemy];
}


- (id)initWithTheGame: (GameScene *)_game enemy:(Enemy *)curEnemy {
    // Note: will need to figure out sprite animation later, this code might help
    //NSString * spriteFrameName = [NSString stringWithFormat:@"icon_gold.png"];
    
    // Call super init
    if ((self = [super initWithTheGame:_game])) {
        
        // Note: will need to figure out sprite animation later, this code might help
        //if (self = [super initTheGameWithSprite:_game sprite:spriteFrameName]) {
        
        // Note: remove unneccesary stats later on, once other projectiles implemented
        self.curHp = 5;
        self.maxHp = 5;
        // Velocity currently only thing determing bullet move speed
        self.maxVelocity = 100;
        self.maxAcceleration = 100;
        self.isMelee = YES;
        self.meleeDamage = 1.25;
        self.meleeDestroySelf = NO;
        self.meleeDamageRate = 0.5;
        self.meleeAoe = NO;
        self.currentEnemy = curEnemy;
        
        self.bulletDamage = 1;
        //self.meleeSound = @"smallHit.wav";
    }
    return self;
}

@end
