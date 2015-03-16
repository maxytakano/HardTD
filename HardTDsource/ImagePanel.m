//
//  ImagePanel.m
//  HardTD
//
//  Created by Max Takano on 9/10/14.
//  Copyright (c) 2014 Max Takano. All rights reserved.
//
#import "ImagePanel.h"
#import "GameScene.h"

@implementation ImagePanel

+(id)nodeWithTheGame:(GameScene*)_game {
    return [[self alloc] initWithTheGame:_game];
}

// Note: Currently size of the frame is 168x168
-(id)initWithTheGame:(GameScene*)_game {
    // Call super init
    if ((self = [super initWithTheGame:_game])) {
        CCSpriteFrame *initFrame = [CCSpriteFrame frameWithImageNamed:@"testArt.png"];
        self.currentSprite = [CCSprite spriteWithSpriteFrame:initFrame];
    
        [self.currentSprite setPosition:
            ccp([[CCDirector sharedDirector] viewSize].width -
            [self.currentSprite boundingBox].size.width/2.0f,
            [[CCDirector sharedDirector] viewSize].height -
            [self.currentSprite boundingBox].size.height/2.0f)];
        [self addChild:self.currentSprite];
    }
    return self;
}

- (void)updateImage:(NSString *)imageString {
    CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:imageString];
    [self.currentSprite setSpriteFrame:spriteFrame];
}

@end

