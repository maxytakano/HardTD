//
//  HUD.m
//  HardTD
//
//  Created by Max Takano on 9/7/14.
//  Copyright (c) 2014 Max Takano. All rights reserved.
//
#import "HUD.h"
#import "GameScene.h"

@implementation HUD

@synthesize theGame;

-(id)initWithTheGame:(GameScene *)_game {
	if ((self=[super init])) {
		theGame = _game;
        self.currentlySelected = nil;
        [theGame addChild:self];
	}
	return self;
}

@end
