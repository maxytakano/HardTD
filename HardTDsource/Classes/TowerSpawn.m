//
//  AppDelegate.h
//  HardTD
//
//  Created by Max Takano on 8/11/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------
#import "TowerSpawn.h"
#import "GameScene.h"
//#import "SimpleAudioEngine.h"
//#import "Laser.h"

@implementation TowerSpawn

@synthesize theGame;
@synthesize mySprite;

-(id)initWithTheGame:(GameScene *)_game {
	if ((self=[super init])) {
		theGame = _game;
        mySprite = [CCSprite spriteWithImageNamed:@"icon_gold.png"];
		[self addChild:mySprite];
        self.alive = YES;
        [theGame addChild:self];
	}
	return self;
}

// Investigate: figure out how to use animated sprites, or pass images in
/*- (id)initWithSpriteFrameName:(NSString *)spriteFrameName layer:(GameScene *)layer {
    if ((self = [super initWithSpriteFrameName:spriteFrameName])) {
        self.theGame = layer;
        //theGame = _game;
        self.alive = YES;
    }
    return self;
}*/


-(void)update:(CCTime)delta {
    
    if (!self.alive) return;
    if (self.maxHp == 0) return;
    
    // If curHp <= 0 a projectile needs to be removed, it's dead
    if (self.curHp <= 0) {
        // Note: remove sound should be unique to each projectile (dont play sound here)
        //[[SimpleAudioEngine sharedEngine] playEffect:@"boom.wav"];
        
        self.alive = FALSE;
        
        // Note: Might need to remove children if projectile has sub projectiles
        //[self removeAllChildrenWithCleanup:YES];
        
        // Remove the game object from theGame scene
        [self.theGame removeGameObject:self];
        
        
        // Investigate: figure out how to animate before removing
        /*[self runAction:
         [CCActionSequence actions:
          [CCActionFadeOut actionWithDuration:0.5],
          [CCActionCallBlock actionWithBlock:^{
             [self.theGame removeGameObject:self];
         }], nil]];*/
        
    }    
}

@end
