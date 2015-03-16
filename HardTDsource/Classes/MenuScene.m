//
//  MenuScene.m
//  HardTD
//
//  Created by Max Takano on 8/11/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "MenuScene.h"
#import "GameScene.h"

// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation MenuScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (MenuScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Create a colored background (Dark Grey)
    /*CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];*/
    
    CGSize size = [[CCDirector sharedDirector] viewSize];   // Get the View Size
    
    
    CCSprite *background;
    
    // Check if iphone, else use ipad image
    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
        background = [CCSprite spriteWithImageNamed:@"infoImage.png"];
        background.rotation = 90;
    } else {
        background = [CCSprite spriteWithImageNamed:@"Default-Landscape~ipad.png"];
    }
    background.position = ccp(size.width/2, size.height/2);
    
    // add the sprite as a child to this Layer
    [self addChild: background];
    
    
    // Hello world
//    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Chalkduster" fontSize:36.0f];
//    label.positionType = CCPositionTypeNormalized;
//    label.color = [CCColor redColor];
//    label.position = ccp(0.5f, 0.5f); // Middle of screen
//    [self addChild:label];
    
    // GameScene scene button
//    CCButton *helloWorldButton = [CCButton buttonWithTitle:@"[ Start ]" fontName:@"Verdana-Bold" fontSize:18.0f];
//    helloWorldButton.positionType = CCPositionTypeNormalized;
//    helloWorldButton.position = ccp(0.5f, 0.35f);
//    [helloWorldButton setTarget:self selector:@selector(onSpinningClicked:)];
//    [self addChild:helloWorldButton];

    // done
	return self;
}

// Use buttons for a menu later
/*
// -----------------------------------------------------------------------
#pragma marks - Button Callbacks
// -----------------------------------------------------------------------

- (void)onSpinningClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[HelloWorldScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

// -----------------------------------------------------------------------
*/

-(void) onEnter
{
	[super onEnter];
	[[CCDirector sharedDirector] replaceScene:[GameScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.5f]];
}
@end
