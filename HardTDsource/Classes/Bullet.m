//
//  AppDelegate.h
//  HardTD
//
//  Created by Max Takano on 8/11/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------


#import "Bullet.h"
#import "GameScene.h"

//#import "SimpleAudioEngine.h"
//#import "Laser.h"


@implementation Bullet

-(void)updateMove:(CCTime)delta {
    // Debug: info on current enemy.  Use with caution, _currentEnemy was tricky
    //NSLog(@"%d %@ %@", _currentEnemy.alive, self, _currentEnemy);
    
    if (self.maxAcceleration <= 0 || self.maxVelocity <= 0) return;
    
    // distance from the bullet to the enemy
    float distance = ccpDistance(self.position, _currentEnemy.mySprite.position);
    
    // If the bullet is within 5.0 of the enemy, damage enemy and set bullet hp to 0
    if (distance < 5.0f ) {
        // Check if the enemy is alive
        if (_currentEnemy.alive) {
            [_currentEnemy getDamaged:self.bulletDamage];   // If YES damage it
        }
        
        // Remove self from current enemie's incomingBullets array
        [_currentEnemy.incomingBullets removeObject:self];
        self.curHp = 0;
        return;     // Return since bullet needs to be deallocated
    }
    
    
    // If the bullet has not yet reached target, update its position
    
    BOOL hasTarget = FALSE;
    CGPoint moveTarget;
    
    moveTarget = _currentEnemy.mySprite.position;
    hasTarget = YES;
    
    // Move bullet towards enemy
    if (hasTarget) {
        // Find direction vector and normalize
        CGPoint direction = ccpNormalize(ccpSub(moveTarget, self.position));
        
       
        // Multiply direction vector by delta (time passed since the last update)
        // and add it to get the new position
        CGPoint newPosition = ccpAdd(self.position, ccpMult(direction, self.maxVelocity * delta));
        
        // Clamp the position based on screen size
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        newPosition.x = MAX(MIN(newPosition.x, winSize.width), 0);
        newPosition.y = MAX(MIN(newPosition.y, winSize.height), 0);
        
        // Assign the new position
        self.position = newPosition;
    }
    
}


-(void)update:(CCTime)delta {
    // Investigate: see if this is needed, might not ever get here
    if (!self.alive) return;
    
    [self updateMove:delta];
    [super update:delta];
}

// TODO: Experiment using this for other projectile types
- (CGPoint)arriveWithTarget:(CGPoint)target {
    
    // 1
    CGPoint vector = ccpSub(target, self.position);
    float distance = ccpLength(vector);
    
    // 2
    float targetRadius = 5;
    float slowRadius = targetRadius + 25;
    static float timeToTarget = 0.1;
    
    // 3
    if (distance < targetRadius) {
        self.velocity = CGPointZero;
        self.acceleration = CGPointZero;
        return CGPointZero;
    }
    
    // 4
    float targetSpeed;
    if (distance > slowRadius) {
        targetSpeed = self.maxVelocity;
    } else {
        targetSpeed = self.maxVelocity * distance / slowRadius;
    }
    
    // 5
    CGPoint targetVelocity = ccpMult(ccpNormalize(vector), targetSpeed);
    CGPoint acceleration = ccpMult(ccpSub(targetVelocity, self.velocity), 1/timeToTarget);
    
    // 6
    if (ccpLength(acceleration) > self.maxAcceleration) {
        acceleration = ccpMult(ccpNormalize(acceleration), self.maxAcceleration);
    }
    return acceleration;
}


@end
