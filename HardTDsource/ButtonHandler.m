//
//  ButtonHandler.m
//  HardTD
//
//  Created by Max Takano on 10/4/14.
//  Copyright 2014 Max Takano. All rights reserved.
//
#import "ButtonHandler.h"
#import "GameScene.h"

@implementation ButtonHandler

+(id)nodeWithTheGame:(GameScene*)_game {
    return [[self alloc] initWithTheGame:_game];
}

-(id)initWithTheGame:(GameScene*)_game {
    // Call super init
    if ((self = [super initWithTheGame:_game])) {
        // initialize stuff here
    }
    return self;
}

// !!! right now ButtonHandler isn't initted as a node, checking to see if we need to do that.
- (BOOL)handleButton:(NSString *)buttonName {
    if ([buttonName isEqual: @"Sell"]) {
        NSLog(@"sellinnnn");
        [self _sell];
        return true;
    }
    if ([buttonName isEqual: @"Upgrade"]) {
        NSLog(@"Upgradin a sentry!");
        [self _upgrade];
        return true;
    }
    return false;
}

- (void)_sell {
    [((Building *)self.theGame.currentlySelected) sell];
    
    // !! this isn't really doing anything
    [self.theGame.buildings removeObject:self.theGame.currentlySelected];
    
    // TODO: consider moving this to building classes
    // Look for the tower base the selected building is on, then remove it and update the hud.
    for(CCSprite * tb in self.theGame.building_bases) {
        if (CGPointEqualToPoint(tb.position, ((Building *)self.theGame.currentlySelected).mySprite.position)) {
            // set the tb array for that building to nil
            tb.userObject = nil;
            
            //[self.theGame.currentlySelected getUnselected];
            [self.theGame selectObject:nil];
        }
    }
}

// Call the selected building's upgrade method
- (void)_upgrade {
    // 1. Upgrade the building
    [((Building *)self.theGame.currentlySelected) upgrade];
    
    // 2. Update the HUD to display new building information
    [[self.theGame.hudComponents objectForKey:(@"informationPanel")] updateInformationFromSelected];
    
    
}

@end








