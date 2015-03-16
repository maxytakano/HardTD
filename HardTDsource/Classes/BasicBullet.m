//
//  AppDelegate.h
//  HardTD
//
//  Created by Max Takano on 8/11/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------


#import "BasicBullet.h"


@implementation BasicBullet


+(id)nodeWithTheGame:(GameScene*)_game enemy:(Enemy *)curEnemy
        bulletDamage:(int)damage maxVelocity:(float)velocity {
    return [[self alloc] initWithTheGame:_game enemy:curEnemy
                            bulletDamage:damage maxVelocity:velocity];
}

- (id)initWithTheGame: (GameScene *)_game enemy:(Enemy *)curEnemy
         bulletDamage:(int)damage maxVelocity:(float)velocity {
    // Note: will need to figure out sprite animation later, this code might help
    //NSString * spriteFrameName = [NSString stringWithFormat:@"icon_gold.png"];
    
    // Call super init
    if ((self = [super initWithTheGame:_game])) {
        
    // Note: will need to figure out sprite animation later, this code might help
    //if (self = [super initTheGameWithSprite:_game sprite:spriteFrameName]) {
        
        self.curHp = 1;     // curHp for bullets is either 0 for dead or 1 for alive
        self.maxHp = 1;     // curHp for bullets is either 0 for dead or 1 for alive
        
        // Velocity currently only thing determing bullet move speed
        self.maxVelocity = velocity;
        
        // TODO add in acceleration possibly for arrive at movement implementation
        self.maxAcceleration = 100;
     
        // Set damage using tower's damage stat
        self.bulletDamage = damage;
        
        // Set the current enemy using enemy's current enemy pointer
        self.currentEnemy = curEnemy;
        
    }
    return self;
}

@end
