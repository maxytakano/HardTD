//
//  BasicEnemy.h
//  HardTD
//
//  Created by Max Takano on 8/11/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "Enemy.h"

/**
 * A Basic Enemy, medium health and medium speed
 **/
@interface BasicEnemy : Enemy

+(id)nodeWithTheGame:(GameScene*)_game;
-(id)initWithTheGame:(GameScene*)_game;


@end