#import "Tower.h"
#import "Enemy.h"
#import "BasicBullet.h"
#import "GameScene.h"

@implementation Tower

-(void)update:(CCTime)delta {
    
    // 2 steps, look for new enemies, then attack them
    
    // 1: If there are less current enemies than the max check if each enemy is in the
    // Tower's range, if it is attack it
    if ([self.currentEnemies count] < self.maxEnemies) {
        for(Enemy * enemy in self.theGame.enemies)
        {
            if([self.theGame circle:self.mySprite.position withRadius:self.towerRange
                collisionWithCircle:enemy.mySprite.position collisionCircleRadius:1]
               && enemy.active == YES && ![self.currentEnemies containsObject:enemy])
            {
                if ([self.currentEnemies count] == 0) {
                    [self attackEnemies];
                }
                if ([self.currentEnemies count] < self.maxEnemies) {
                    [self chosenEnemyForAttack:enemy];
                }
                
            }
        }
    }
    
    // 2: rotate to face the first enemy then attack each current enemy, if they are out of
    // range, stop firing at them.
    if ([self.currentEnemies count] != 0) {
        
        // Rotate to aim at the first enemy in currentEnemies
        if ([self.currentEnemies count] == 1) {
            Enemy *firstEnemy = [self.currentEnemies firstObject];
            CGPoint normalized = ccpNormalize(ccp(firstEnemy.mySprite.position.x-self.mySprite.position.x,
                                                  firstEnemy.mySprite.position.y-self.mySprite.position.y));
            self.mySprite.rotation = CC_RADIANS_TO_DEGREES(atan2(normalized.y,-normalized.x))+90;
        }
        else {    // If more than 1 enemy, take the average between first and last and aim there
            Enemy *firstEnemy = [self.currentEnemies firstObject];
            Enemy *lastEnemy = [self.currentEnemies lastObject];
            CGPoint aimPosition;
            aimPosition.x = (firstEnemy.mySprite.position.x + lastEnemy.mySprite.position.x) / 2.0;
            aimPosition.y = (firstEnemy.mySprite.position.y + lastEnemy.mySprite.position.y) / 2.0;
            
            CGPoint normalized = ccpNormalize(ccp(aimPosition.x-self.mySprite.position.x,
                                                  aimPosition.y-self.mySprite.position.y));
            self.mySprite.rotation = CC_RADIANS_TO_DEGREES(atan2(normalized.y,-normalized.x))+90;
        }
        
        
        // Iterate through all enemies to see if any are out of range
        for (Enemy *enemy in self.currentEnemies) {
            if(![self.theGame circle:self.mySprite.position withRadius:self.towerRange
                 collisionWithCircle:enemy.mySprite.position collisionCircleRadius:1])
            {
                [self lostSightOfEnemy:enemy];
                return;     // return so that can't modify array and attack in the same update
            }
        }
    }
    
}


-(void)attackEnemies
{
    //[self spawnTowerSpawn];   // Note: this would attack the enemies instantly ?
    [self schedule:@selector(spawnTowerSpawn) interval:self.spawnRate];
}

-(void)chosenEnemyForAttack:(Enemy *)enemy
{
    [self.currentEnemies addObject:enemy];
    
    // Note: kept here in case of memory issues
    //self.chosenEnemy = nil;
    //self.chosenEnemy = enemy;
    
    [enemy getAttacked:self];
}


- (void)targetKilled:(Enemy *)enemy
{
    if ([self.currentEnemies containsObject:enemy]) {
        [self.currentEnemies removeObject:enemy];
    }
    
    // Investigate: Check if chosenEnemy is already dead, might not need this
    //if(self.chosenEnemy)
    //    self.chosenEnemy = nil;
    
    // Stop spawning bullets
    if ([self.currentEnemies count] == 0) {
        [self unschedule:@selector(spawnTowerSpawn)];
    }
}

- (void)lostSightOfEnemy:(Enemy *)enemy
{
    [enemy gotLostSight:self];
    // Investiage: what were these 2 lines were doing
    //if(enemy)
    //    enemy =nil;
    [self.currentEnemies removeObject:enemy];
    if ([self.currentEnemies count] == 0) {
        [self unschedule:@selector(spawnTowerSpawn)];
    }
}

- (void)sell {
    
    // Give the player resources based on sell value
    [self.theGame awardGold:self.sellValue resource2:0 resource3:0];
    
    for (Enemy *enemy in self.currentEnemies) {
        [enemy gotLostSight:self];
    }
    [self unschedule:@selector(spawnTowerSpawn)];

    [self removeFromParentAndCleanup:YES];
}


// Note: spawnTowerSpawn is implemented in children towers.  unique to each tower
/*-(void)spawnTowerSpawn
 {
 
 }*/

@end