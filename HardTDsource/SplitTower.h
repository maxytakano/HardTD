//
//  SplitTower.h
//  HardTD
//
//  Created by Max Takano on 9/04/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "Tower.h"
#import "Enemy.h"


/**
 * This tower shoots three targets at once. Has a damage and a velocity.
 **/
@interface SplitTower : Tower

@property (nonatomic, assign) int damage;
@property (nonatomic, assign) float velocity;


+(id)nodeWithTheGame:(GameScene*)_game location:(CGPoint)myLocation;
-(id)initWithTheGame:(GameScene*)_game location:(CGPoint)myLocation;



// Static variable getters
+(int)getCost;
+(NSString *)getButtonArt;
+(NSString *)getArt;

// Methods
-(void)spawnTowerSpawn;

@end