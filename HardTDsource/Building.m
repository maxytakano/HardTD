#import "Building.h"
#import "GameScene.h"
#import "Enemy.h"

@implementation Building

@synthesize theGame;
@synthesize mySprite;

-(id) initWithTheGame:(GameScene *)_game location:(CGPoint)location
{
	if( (self=[super init])) {
		theGame = _game;
        
        // Initialize selection sprite, starts invisible until selected
        self.selectionSprite = [CCSprite spriteWithImageNamed:@"greenBox.png"];
        self.selectionSprite.visible = NO;
        [self.selectionSprite setPosition:location];
        [self.selectionSprite setZOrder:1];
        
        [self addChild:self.selectionSprite];
        
        [theGame addChild:self];
	}
	
	return self;
}

// don't need, upgrade is implemented in towers not here
//- (void)upgrade {
//    NSLog(@"gettin swole");
//}

// Depricated: decided to just sell from the button handler instead (might be bad)
- (void)sell {
    NSLog(@"selling");
    
    // Give the player resources based on sell value
    [self.theGame awardGold:self.sellValue resource2:0 resource3:0];
    
    [self removeFromParentAndCleanup:YES];
}

// TODO: implement transform
/*- (void)transform:intothis {

}*/

- (void)getSelected {
    self.selectionSprite.visible = YES;
}
- (void)getUnselected {
    self.selectionSprite.visible = NO;
}

@end