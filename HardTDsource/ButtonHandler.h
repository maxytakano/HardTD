//
//  ButtonHanlder.h
//  HardTD
//
//  Created by Max Takano on 10/4/14.
//  Copyright 2014 Max Takano. All rights reserved.
//
#import "HUD.h"


// Handles building's buttons, performs actions depending on which button was pressed
@interface ButtonHandler : HUD

+(id)nodeWithTheGame:(GameScene*)_game;
-(id)initWithTheGame:(GameScene*)_game;

// Determines which button in the HUD was pressed
- (BOOL)handleButton:(NSString *)buttonName;

@end



