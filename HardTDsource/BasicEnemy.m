//
//  BasicEnemy.m
//  HardTD
//
//  Created by Max Takano on 8/11/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------


#import "BasicEnemy.h"


@implementation BasicEnemy

+(id)nodeWithTheGame:(GameScene*)_game {
    return [[self alloc] initWithTheGame:_game];
}

-(id)initWithTheGame:(GameScene*)_game {
    // Note: will need to figure out sprite animation later, this code might help
    //NSString * spriteFrameName = [NSString stringWithFormat:@"icon_gold.png"];
    
    // Call super init
    if ((self = [super initWithTheGame:_game])) {
        
        // Note: will need to figure out sprite animation later, this code might help
        //if (self = [super initTheGameWithSprite:_game sprite:spriteFrameName]) {
        
        self.movementSpeed = 1.5;
        self.startingHp = 100;
        // Set current Hp to the starting Hp
        self.currentHp = self.startingHp;
        
        self.bounty = @[@120, @0, @0];    // init with three NSNumbers, one for each resource
        self.livesTaken = 2;
        self.isFlying = NO;
        
        
        self.artSpriteName = @"testArtEnemy.png";
        
        
        // For information box
        self.gameDescription = @"A weak enemy. Dangerous in numbers.";
        

        
    }
    return self;
}


@end
