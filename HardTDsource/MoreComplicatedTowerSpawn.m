//
//  AppDelegate.h
//  HardTD
//
//  Created by Max Takano on 8/11/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------


#import "MoreComplicatedTowerSpawn.h"
#import "GameScene.h"

//#import "SimpleAudioEngine.h"
//#import "Laser.h"


@implementation MoreComplicatedTowerSpawn {
    BOOL _aoeDamageCaused;
}

-(void)updateMove:(CCTime)delta {
    // Debug: info on current enemy.  Use with caution, _currentEnemy was tricky
    //NSLog(@"%d %@ %@", _currentEnemy.alive, self, _currentEnemy);
    
    if (self.maxAcceleration <= 0 || self.maxVelocity <= 0) return;
    
    // distance from the bullet to the enemy
    float distance = ccpDistance(self.position, _currentEnemy.mySprite.position);
    
    
    // If the bullet is within 2.0 of the enemy, damage enemy and set bullet hp to 0
    if (distance < 2.0f ) {
        // Check if the enemy is alive
        if (_currentEnemy.alive) {
            // TODO: pass damage in or something
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


-(void)updateMelee:(CCTime)delta {
    
    /*if (!self.isMelee) return;
     
     NSArray * enemies = [self.layer enemiesOfTeam:self.team];
     _aoeDamageCaused = FALSE;
     for (GameObject * enemy in enemies) {
     [self checkCollision:enemy];
     }
     [self checkCollision:[self.layer playerForTeam:[self.layer oppositeTeam:self.team]]];
     
     // Special case for AOE damage - let it attack multiple things before we
     // reset the last damage time
     if (_aoeDamageCaused) {
     self.meleeLastDamageTime = CACurrentMediaTime();
     }*/
}

-(void)updateRanged:(CCTime)delta {
    
    /*if (!self.isRanged) return;
     
     GameObject * enemy = [self.layer closestEnemyToGameObject:self];
     if (!enemy) {
     enemy = [self.layer playerForTeam:[self.layer oppositeTeam:self.team]];
     }
     if (!enemy) return;
     
     float distance = ccpDistance(self.position, enemy.position);
     static float WIGGLE_ROOM = 5;
     if (ABS(distance) <= (self.rangedRange + WIGGLE_ROOM) && CACurrentMediaTime() - self.rangedLastDamageTime > self.rangedDamageRate) {
     
     //[[SimpleAudioEngine sharedEngine] playEffect:self.rangedSound];
     
     self.rangedLastDamageTime = CACurrentMediaTime();
     
     Laser * laser = [self.layer createLaserForTeam:self.team];
     laser.position = self.position;
     laser.meleeDamage = self.rangedDamage;
     
     CGPoint direction = ccpNormalize(ccpSub(enemy.position, self.position));
     static float laserPointsPerSecond = 100;
     static float laserDistance = 1000;
     
     CGPoint target = ccpMult(direction, laserDistance);
     float duration = laserDistance / laserPointsPerSecond;
     
     laser.rotation = -1 * CC_RADIANS_TO_DEGREES(ccpToAngle(direction));
     
     [laser runAction:
     [CCSequence actions:
     [CCMoveBy actionWithDuration:duration position:target],
     [CCCallBlock actionWithBlock:^{
     [laser removeFromParentAndCleanup:YES];
     }], nil]];
     }*/
    
}

-(void)update:(CCTime)delta {
    
    // Investigate: see if this is needed, might not ever get here
    if (!self.alive) return;
    
    // Note: other updates will be used for other projectile types (swarm, aoe, minion)
    //[self updateMelee:dt];
    //[self updateRanged:dt];
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
