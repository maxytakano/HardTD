//
//  InformationPanel.m
//  HardTD
//
//  Created by Max Takano on 9/11/14.
//  Copyright (c) 2014 Max Takano. All rights reserved.
//

//#import "InformationPanel.h"
#import "GameScene.h"
//#import "ImagePanel.h"

@implementation InformationPanel

+(id)nodeWithTheGame:(GameScene*)_game {
    return [[self alloc] initWithTheGame:_game];
}

-(id)initWithTheGame:(GameScene*)_game {
    // Note: will need to figure out sprite animation later, this code might help
    //NSString * spriteFrameName = [NSString stringWithFormat:@"icon_gold.png"];
    
    // Call super init
    if ((self = [super initWithTheGame:_game])) {
        // Set up the background for the information box
        self.informationBackground = [[CCSprite alloc] initWithImageNamed:@"infoImage.png"];
        [self.informationBackground setPosition:ccp([[CCDirector sharedDirector] viewSize].width -
                                            [self.informationBackground boundingBox].size.width/2.0f,
                                            [[CCDirector sharedDirector] viewSize].height -
                                            [self.informationBackground boundingBox].size.height/2.0f - [[[[self.theGame hudComponents] objectForKey:@"imagePanel"] currentSprite] boundingBox].size.height)];
        
        [self addChild:self.informationBackground];
    }
    return self;
}

- (void)updateInformationFromButton:(id)button {
    // button selected information
    self.damage = [button getDamage];
    self.towerRange = [button getRange];
    self.speed = [button getSpeed];
    self.cost = [button getCost];
    self.gameDescription = [button getDescription];
    
    
    [self setHUDInformationWithString:[NSString stringWithFormat:@"%@\nDmg: %d\nRNG: %d\nSPD: %.2f\nCost: %d\n%@", button, self.damage, self.towerRange, self.speed, self.cost, self.gameDescription]];
}

- (void)updateInformationFromSelected {
    // Check if the game's currently selected object is an enemy, tower, farm, or tech structure
    // then display corresponding data for that object.
    if ([[self.theGame.currentlySelected class] isSubclassOfClass:[Enemy class]]) {
        // Update properties with currentlySelected Enemy stats
        self.currentHealth = [self.theGame.currentlySelected currentHp];
        self.currentSpeed = [self.theGame.currentlySelected movementSpeed];     // Note: might not want this
        self.lifeDamage = [self.theGame.currentlySelected livesTaken];
        self.gameDescription = [self.theGame.currentlySelected gameDescription];
        
        // Update the Label with the new information
        [self setHUDInformationWithString:[NSString stringWithFormat:@"%@\nHP: %d\nSPD: %.2f\n<3-DMG: %d\n%@", [self.theGame.currentlySelected class], self.currentHealth, self.currentSpeed, self.lifeDamage, self.gameDescription]];
    } else if ([[self.theGame.currentlySelected class] isSubclassOfClass:[Tower class]]) {
        // Update properties with currentlySelected Tower stats
        self.damage = [self.theGame.currentlySelected damage];
        self.towerRange = [self.theGame.currentlySelected towerRange];
        self.speed = [self.theGame.currentlySelected spawnRate];

        self.level = [self.theGame.currentlySelected upgradeLevel];
        // TODO: add upgrade cost
        // TODO: these two should handle all three resources
        //self.upgradeCost = [self.theGame.currentlySelected ];
        self.sellValue = [self.theGame.currentlySelected sellValue];
        
        // Update the Label with the new information
        [self setHUDInformationWithString:[NSString stringWithFormat:@"%@\nDMG: %d\nRNG: %d\nSPD: %.2f\nLVL: %d\n$VAL: %d\n", [self.theGame.currentlySelected class], self.damage, self.towerRange, self.speed, self.level, self.sellValue]];
    }
    
    // TODO: add different handling for different types of buildings (farms, tech)
    
}


/**
 * Function updates the label with a new string.
 *
 * Note: The label is completely recreated due to a bug (just updating the instance's string
 * does not work, the letters become squished).  Instead the label most be re instanciated
 * scaled and positioned.
 **/
- (void)setHUDInformationWithString:(NSString *)newString {
    [self removeChild:self.information cleanup:YES];
    
    self.information = [[CCLabelBMFont alloc] initWithString:newString fntFile:@"font_red.fnt"];
    
    
    [self.information setScale:0.40f];
    
    // TODO: Is there a way to quantify the + 40?
    // Note: multiply width by 2 because hd doubles the pixels?
    [self.information setWidth:[self.informationBackground boundingBox].size.width*2.0f + 40.0f];
    
    [self.information setAlignment:CCTextAlignmentCenter];
    
    
    [self.information setPosition:ccp([[CCDirector sharedDirector] viewSize].width -
                                      [self.informationBackground boundingBox].size.width/2.0f,
                                      [[CCDirector sharedDirector] viewSize].height -
                                      [self.informationBackground boundingBox].size.height/2.0f - [[[[self.theGame hudComponents] objectForKey:@"imagePanel"] currentSprite] boundingBox].size.height)];
    [self addChild:self.information];
}


@end