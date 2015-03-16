//
//  BasicTower.h
//  HardTD
//
//  Created by Max Takano on 8/11/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "Tower.h"
#import "Enemy.h"

/**
 * A basic tower that shoots one target only.  Has a tower damange and and tower spawn velocity
 * property.
 */
@interface BasicTower : Tower

@property (nonatomic, assign) int damage;
@property (nonatomic, assign) float velocity;


+(id)nodeWithTheGame:(GameScene*)_game location:(CGPoint)myLocation;
-(id)initWithTheGame:(GameScene*)_game location:(CGPoint)myLocation;


// Static variable getters
+(int)getCost;
+(NSString *)getButtonArt;
+(NSString *)getArt;

// Static button information
+(int)getDamage;
+(int)getRange;
+(float)getSpeed;
+(NSString *)getDescription;

// Methods
-(void)spawnTowerSpawn;

@end