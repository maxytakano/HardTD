//
//  ButtonPanel.h
//  HardTD
//
//  Created by Max Takano on 9/6/14.
//  Copyright (c) 2014 Max Takano. All rights reserved.
//
#import "HUD.h"
#import "ButtonHandler.h"
//#import "cocos2d-ui.h" !! might need this

// Note: this currently must be even
#define PAGE_COUNT 8


@interface ButtonPanel : HUD {
    CGPoint selectionPosition;
    
}

// Dictionary taking the buttonName_currentState and returning associated building Name
//@property (nonatomic, strong) NSDictionary *buttonToBuilding;

// TODO: check if this is used
// Which page the right hand hud is currently on
//@property (nonatomic, assign) int hudPage;

// holds the data from the passed in plist
@property (nonatomic, strong) NSArray *buttonData;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSString *selectedButton;
@property (nonatomic, strong) CCSprite *selectionSprite;
@property (nonatomic, assign) int currentPage;
// gesture set up
@property (nonatomic, assign) CGRect mySensitiveRect;
@property (nonatomic, strong) ButtonHandler *buttonHandler;

//@property (nonatomic, assign) int movecounter;

+(id)nodeWithTheGame:(GameScene*)_game withData:(NSArray *)data;
-(id)initWithTheGame:(GameScene*)_game withData:(NSArray *)data;

- (void)assignButtonWithID:(int)buttonID
                toButton:(NSString *)buttonName
                toImage:(NSString *)imageString;
- (void)unassignButtonWithID:(int)buttonID;
- (void)setPageTo:(int)page;

- (void)updateButtonPanelWithButtons:(NSMutableArray *)buildingButtons;

- (void)switchToPage;
- (void)disableButtons;


@end
