//
//  InformationPanel.h
//  HardTD
//
//  Created by Max Takano on 9/11/14.
//  Copyright (c) 2014 Max Takano. All rights reserved.
//
#import "HUD.h"
//#import "cocos2d-ui.h" !! might need this


@interface InformationPanel : HUD

@property (nonatomic, strong) CCSprite *informationBackground;
@property (nonatomic, strong) CCLabelBMFont *information;

// button selected information
@property (nonatomic, assign) int damage;
@property (nonatomic, assign) int towerRange;
@property (nonatomic, assign) float speed;
@property (nonatomic, assign) int cost;
@property (nonatomic, strong) NSString *gameDescription;

// tower selected information
@property (nonatomic, assign) int level;
@property (nonatomic, assign) int upgradeCost;
@property (nonatomic, assign) int sellValue;

// enemy selected information
@property (nonatomic, assign) int currentHealth;
@property (nonatomic, assign) float currentSpeed;     // Note: might not want this
@property (nonatomic, assign) int lifeDamage;

+(id)nodeWithTheGame:(GameScene*)_game;
-(id)initWithTheGame:(GameScene*)_game;

// Updates the properties based on the selected button's building class type then displays it.
- (void)updateInformationFromButton:(id)button;
// Updates the properties based on theGame's currentlySelected id.  Checks what type of object
// the id is, then based on the type displays different information about the object.
- (void)updateInformationFromSelected;

@end
