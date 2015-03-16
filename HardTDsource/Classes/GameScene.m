//
//  GameScene.m
//  HardTD
//
//  Created by Max Takano on 8/11/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "GameScene.h"
#import "MenuScene.h"
#import "Waypoint.h"


#import "AppDelegate.h"   // Note: not sure if this does anything, try removing later

@implementation GameScene
{
    // Investigate: Why is this not in the .h
    CCSprite *_sprite;
}

@synthesize building_bases;
@synthesize waypoints;
@synthesize buildings;
@synthesize enemies;
@synthesize bullets;
@synthesize hudComponents;
@synthesize currentlySelected;



// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (GameScene *) scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommends assigning |self| with |super|'s return value
    self = [super init];
    if (!self) return(nil);
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    // Set the window size
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    
    // Initialize bullets array
    bullets = [[NSMutableArray alloc] init];
    
    // 1 - set background
    /*CCSprite * background = [CCSprite spriteWithImageNamed:@"bg.png"];
    [self addChild:background];
    [background setPosition:ccp(winSize.width/2,winSize.height/2)];*/
    
    // Note: temporary? white background
    CCNodeColor *colorLayer = [CCNodeColor nodeWithColor:[CCColor whiteColor]];
    [self addChild:colorLayer z:0];
    
    // 2 - add waypoints
    [self addWaypoints];
    
    // 3 - load tower positions
    [self loadTowerPositions];
    
    // initialize building array
    buildings = [[NSMutableArray alloc] init];

    // 4 - add enemies
    enemies = [[NSMutableArray alloc] init];
    [self loadWave];
    
    // Note: the positions on these should be adjusted to work with all screen sizes
    // 5 - create wave label
    ui_wave_lbl = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"WAVE: %d",wave] fntFile:@"font_red.fnt"];
    [self addChild:ui_wave_lbl z:10];
    [ui_wave_lbl setPosition:ccp(winSize.width - 100,winSize.height - 12)];
    [ui_wave_lbl setAnchorPoint:ccp(0,0.5)];
    
    // 6 - player lives
    playerHp = 5;
    ui_hp_lbl = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"HP: %d",playerHp] fntFile:@"goodfoot5.fnt"];
    ui_hp_lbl.scale = 0.5f;
    
    [self addChild:ui_hp_lbl z:10];
    [ui_hp_lbl setPosition:ccp(winSize.width - 430,winSize.height - 12)];
    
    // 7 - gold
    playerGold = 100000;
    ui_gold_lbl = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"GOLD: %d",playerGold] fntFile:@"font_red.fnt"];
    [self addChild:ui_gold_lbl z:10];
    [ui_gold_lbl setPosition:ccp(winSize.width - 320,winSize.height-12)];
    [ui_gold_lbl setAnchorPoint:ccp(0,0.5)];
    
    // 8 - HUD
    hudComponents = [[NSMutableDictionary alloc] init];
    
    // Button Panel:
    // Get button data from plist
    NSString* buttonPlistPath = [[NSBundle mainBundle] pathForResource:@"ButtonData" ofType:@"plist"];
    NSArray * buttonData = [NSArray arrayWithContentsOfFile:buttonPlistPath];
    
    ButtonPanel * buttonPanel = [ButtonPanel nodeWithTheGame:self withData:buttonData];
    [hudComponents setObject:buttonPanel forKey:@"buttonPanel"];
    
    // Image Panel:
    ImagePanel * imagePanel = [ImagePanel nodeWithTheGame:self];
    [hudComponents setObject:imagePanel forKey:@"imagePanel"];
    
    
    // Information Panel:
    InformationPanel * informationPanel = [InformationPanel nodeWithTheGame:self];
    [hudComponents setObject:informationPanel forKey:@"informationPanel"];
    
    // Initialize the hud to the currently selected button. (this is set in buttonPanel.m)
    [self selectObject:nil];
    
    
    // TODO: old example on how do do things, remove sooner rather than later
    /*
    // Add a sprite
    _sprite = [CCSprite spriteWithImageNamed:@"Icon-72.png"];
    _sprite.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    [self addChild:_sprite];
    
    // Animate sprite with action
    CCActionRotateBy* actionSpin = [CCActionRotateBy actionWithDuration:1.5f angle:360];
    [_sprite runAction:[CCActionRepeatForever actionWithAction:actionSpin]];
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
     */
    

    // done
	return self;
}

// Note: virtual screen size is 480x320

////////////////// HUD touch handling //////////////////
/*- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}*/

/*- (void)hudTouched:(id)sender
 {
     CCButton *mybutton = (CCButton *)(sender);
     NSLog(@"%@", mybutton.name);

     // Set currentlySelected by passing in the button name appended with _hudpage
     currentlySelected = [buttonToBuilding
                          objectForKey:[mybutton.name stringByAppendingFormat:@"_%d", hudPage]];
     
 }*/


// TODO: use pathfinding to generate the waypoints given the start and finish
// 30 px wide tiles
- (void)addWaypoints
{
    waypoints = [[NSMutableArray alloc] init];
    
    // old
    // TODO: see if you can store this data in a plist or other config file
    /*Waypoint * waypoint0 = [Waypoint nodeWithTheGame:self location:ccp(405,305)];
    [waypoints addObject:waypoint0];
    
    Waypoint * waypoint1 = [Waypoint nodeWithTheGame:self location:ccp(405,45)];
    [waypoints addObject:waypoint1];
    waypoint1.nextWaypoint =waypoint0;*/
    
    // new
    // TODO: see if you can store this data in a plist or other config file
    
    Waypoint * waypoint1 = [Waypoint nodeWithTheGame:self location:ccp(375,45)];
    [waypoints addObject:waypoint1];
    //waypoint1.nextWaypoint =waypoint0;
    
    
    
    Waypoint * waypoint2 = [Waypoint nodeWithTheGame:self location:ccp(345,45)];
    [waypoints addObject:waypoint2];
    waypoint2.nextWaypoint =waypoint1;
    
    Waypoint * waypoint3 = [Waypoint nodeWithTheGame:self location:ccp(345,285)];
    [waypoints addObject:waypoint3];
    waypoint3.nextWaypoint =waypoint2;
    
    Waypoint * waypoint4 = [Waypoint nodeWithTheGame:self location:ccp(105,285)];
    [waypoints addObject:waypoint4];
    waypoint4.nextWaypoint =waypoint3;
    
    Waypoint * waypoint5 = [Waypoint nodeWithTheGame:self location:ccp(105,195)];
    [waypoints addObject:waypoint5];
    waypoint5.nextWaypoint =waypoint4;
    
    Waypoint * waypoint6 = [Waypoint nodeWithTheGame:self location:ccp(285,195)];
    [waypoints addObject:waypoint6];
    waypoint6.nextWaypoint =waypoint5;
    
    Waypoint * waypoint11 = [Waypoint nodeWithTheGame:self location:ccp(285,15)];
    [waypoints addObject:waypoint11];
    waypoint11.nextWaypoint =waypoint6;
    
    Waypoint * waypoint12 = [Waypoint nodeWithTheGame:self location:ccp(195,15)];
    [waypoints addObject:waypoint12];
    waypoint12.nextWaypoint =waypoint11;
    
    Waypoint * waypoint13 = [Waypoint nodeWithTheGame:self location:ccp(195,135)];
    [waypoints addObject:waypoint13];
    waypoint13.nextWaypoint =waypoint12;
    
    Waypoint * waypoint14 = [Waypoint nodeWithTheGame:self location:ccp(105,135)];
    [waypoints addObject:waypoint14];
    waypoint14.nextWaypoint =waypoint13;
    
    Waypoint * waypoint15 = [Waypoint nodeWithTheGame:self location:ccp(105,15)];
    [waypoints addObject:waypoint15];
    waypoint15.nextWaypoint =waypoint14;
    
    Waypoint * waypoint16 = [Waypoint nodeWithTheGame:self location:ccp(45,15)];
    [waypoints addObject:waypoint16];
    waypoint16.nextWaypoint =waypoint15;
    
    Waypoint * waypoint17 = [Waypoint nodeWithTheGame:self location:ccp(45,255)];
    [waypoints addObject:waypoint17];
    waypoint17.nextWaypoint =waypoint16;
    
    Waypoint * waypoint18 = [Waypoint nodeWithTheGame:self location:ccp(-40,255)];
    [waypoints addObject:waypoint18];
    waypoint18.nextWaypoint =waypoint17;
}

// Load adds a tower base to every 30x30 spot the path doesn't touch.
- (void)loadTowerPositions
{
    // Note: old way of setting bases using a plist instead of covering all tiles
    //NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"TowersPosition" ofType:@"plist"];
    //NSArray * towerPositions = [NSArray arrayWithContentsOfFile:plistPath];
    
    NSMutableArray* towerPositions2 = [[NSMutableArray alloc] init];
    
    NSNumber *xPosition = [NSNumber numberWithInt: 15];
    NSNumber *yPosition = [NSNumber numberWithInt: 0];
    
    // image resolution gets halved 960 x 640 --> 480 x 320
    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 13; j++) {
            yPosition = @((i * 30) + 15);
            xPosition = @((j*30) + 15);
            
            // Investigate: use if block instead of iterating through waypoints
            // to save iterations? not much time is spent here so probably okay to leave it
            // the way it is
            /*if ([xPosition intValue] == 465 && [yPosition intValue] == 305) {
             continue;
             }*/
            
            BOOL pathPoint = NO;
            
            int previousX = -69;    // undefined -69
            int previousY = -69;    // undefined -69
            
            /*
             * Iterates through waypoints, checks to see if tower base placement
             * is between current and previous way point using simple if logic
             * for code speed.  If yes, dont place tower base here.
             */
            for (Waypoint *way in waypoints) {
                
                // initial waypoint pass, so skip first back check
                if (previousX == -69 && previousY == -69) {
                    // do nothing
                }
                else if (previousX < way.myPosition.x) {
                    if ([xPosition intValue] >= previousX && [xPosition intValue] <= way.myPosition.x) {
                        
                        if (previousY > way.myPosition.y) {
                            if ([yPosition intValue] <= previousY && [yPosition intValue] >= way.myPosition.y) {
                                pathPoint = YES;
                                break;
                            }
                        }
                        else if (previousY <= way.myPosition.y) {
                            if ([yPosition intValue] >= previousY && [yPosition intValue] <= way.myPosition.y) {
                                pathPoint = YES;
                                break;
                            }
                        }
                    }
                    else {
                        // do nothing
                    }
                }
                else if (previousX >= way.myPosition.x){
                    if ([xPosition intValue] <= previousX && [xPosition intValue] >= way.myPosition.x) {
                        
                        if (previousY > way.myPosition.y) {
                            if ([yPosition intValue] <= previousY && [yPosition intValue] >= way.myPosition.y) {
                                pathPoint = YES;
                                break;
                            }
                        }
                        else if (previousY <= way.myPosition.y) {  // <=
                            if ([yPosition intValue] >= previousY && [yPosition intValue] <= way.myPosition.y) {
                                pathPoint = YES;
                                break;
                            }
                        }
                    }
                    else {
                        // do nothing
                    }
                }
                
                previousY = way.myPosition.y;   // Save previous waypoint coordinates
                previousX = way.myPosition.x;
            }
            
            
            // If pathPoint flag got set, dont place a tower base here
            if (pathPoint) {
                continue;
            }
            
            // Otherwise create a tower base
            NSDictionary *towerXY = @{
                                      @"x" : xPosition,
                                      @"y" : yPosition,
                                      };
            
            [towerPositions2 addObject:towerXY];
        }
    }
    
    //  Debug: print out waypoints
    /*for (Waypoint *way in waypoints) {
     NSLog(@"%f: x", way.myPosition.x);
     NSLog(@"%f: y", way.myPosition.y);
     }*/
    
    
    building_bases = [[NSMutableArray alloc] initWithCapacity:10];
    
    
    for(NSDictionary * towerPos in towerPositions2)
    {
        CCSprite * building_base = [CCSprite spriteWithImageNamed:@"pink1.png"];
        [self addChild:building_base];
        [building_base setPosition:ccp([[towerPos objectForKey:@"x"] intValue],[[towerPos objectForKey:@"y"] intValue])];
        [building_bases addObject:building_base];
    }
}

// Todo: Rename this to remove TowerSpawn (probably) possibly make it be able to remove buildings as well
- (void)removeGameObject:(TowerSpawn *)gameObject {
    [self.bullets removeObject:gameObject];
    [gameObject removeFromParentAndCleanup:YES];
}

- (BOOL)loadWave {
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Waves" ofType:@"plist"];
    NSArray * waveData = [NSArray arrayWithContentsOfFile:plistPath];
    
    if(wave >= [waveData count])
    {
        return NO;
    }
    
    NSArray * currentWaveData =[NSArray arrayWithArray:[waveData objectAtIndex:wave]];
    
    for(NSDictionary * enemyData in currentWaveData)
    {
        // Use the enemyType string in Waves plist to create an enemy object of that type
        Enemy * enemy = [NSClassFromString([enemyData objectForKey:@"enemyType"]) nodeWithTheGame:self];
        [enemies addObject:enemy];
        [enemy schedule:@selector(doActivate) interval:[[enemyData objectForKey:@"spawnTime"]floatValue]];
    }
    
    wave++;
    [ui_wave_lbl setString:[NSString stringWithFormat:@"WAVE: %d",wave]];
    return YES;
    
}

- (void)enemyGotKilled {
    if ([enemies count]<=0) //If there are no more enemies.
    {
        if(![self loadWave])
        {
            NSLog(@"You win!");
            
            [[CCDirector sharedDirector] replaceScene:[GameScene scene]
                                       withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.5f]];
        }
    }
}

// Subtracts lives from the player based on the amount the enemy that reached the
// last waypoint specified
- (void)getHpDamage:(int)livesTaken {
    //[[SimpleAudioEngine sharedEngine] playEffect:@"life_lose.wav"];
    playerHp = playerHp - livesTaken;
    [ui_hp_lbl setString:[NSString stringWithFormat:@"HP: %d",playerHp]];
    
    // Check if lives is less than or equal to 0, if it is the player has lost
    if (playerHp <=0) {
        [self doGameOver];
    }
}

- (void)doGameOver {
    if (!gameEnded) {
        gameEnded = YES;
        
        // Note: currently replacing to GameScene, this is a restart
        [[CCDirector sharedDirector] replaceScene:[GameScene scene]
                                   withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.5f]];
        //[[CCDirector sharedDirector] replaceScene:[CCTransition transitionCrossFadeWithDuration:1.0]];
        
    }
}

- (void)awardGold:(int)gold resource2:(int)r2 resource3:(int)r3 {
    // TODO: Rename these to different resources
    playerGold += gold;
    playerResource2 += r2;
    playerResource3 += r3;
    [ui_gold_lbl setString:[NSString stringWithFormat:@"GOLD: %d",playerGold]];
}

// TODO: update for other resources
-(BOOL)canBuyBuilding:(NSString *)buildingName {
    if (playerGold - [NSClassFromString(buildingName) getCost] >=0)
        return YES;
    return NO;
}

-(BOOL)circle:(CGPoint) circlePoint withRadius:(float) radius collisionWithCircle:(CGPoint) circlePointTwo collisionCircleRadius:(float) radiusTwo {
    float xdif = circlePoint.x - circlePointTwo.x;
    float ydif = circlePoint.y - circlePointTwo.y;
    
    float distance = sqrt(xdif*xdif+ydif*ydif);
    
    if(distance <= radius+radiusTwo)
        return YES;
    
    return NO;
}

// -----------------------------------------------------------------------

// Note: this might just be removed later, not used currently
//- (void)dealloc
//{
//     clean up code goes here
//}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInteractionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// Debug:
/*- (void)update:(CCTime)delta {
    NSLog(@"theGame: %@", currentlySelected);
}*/


// TODO: try to move this method to HUD replace all self with self.theGame or something like that
// Note: if need to check class type later use:
// [[currentlySelected class] isSubclassOfClass:[Enemy class]]
- (void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint location = [touch locationInNode:self];
    
    // if we are in confirm mode
        // check if touch was in the same bb as the confirm building
        // if yes build,
        // else if on an empty tb, move the confirm building there
        // else if on anything else do nothing
    
    // Check if we are touching a building or a building_base
    for(CCSprite *bb in building_bases) {
        // touching an empty |building_base|, enter building confirm mode
        if(CGRectContainsPoint([bb boundingBox],location) && !bb.userObject) {
            // For cases where something is already selected (Enemy or building currently),
            // deselect
            if ([[currentlySelected class] isSubclassOfClass:[Enemy class]]) {
                [currentlySelected getUnselected];
                [self selectObject:nil];
                return;
            } else if ([[currentlySelected class] isSubclassOfClass:[Building class]]) {
                [currentlySelected getUnselected];
                // TODO: if building tech, try place tech?
                [self selectObject:nil];
                return;
            } else if (!currentlySelected) {
                // For cases where nothing is selected, try to place the selected tower.
                // if have enough gold
                // TODO: change block into method: tryPlaceBuilding.
                if ([self canBuyBuilding:[[hudComponents objectForKey:@"buttonPanel"] selectedButton]]) {
                    
                    // enter confirm mode
                        // switch button hud to the giant cancel button
                        // tint game screen slightly grey
                    // confirmbuilding b = confirmbuilding withrange: objfor key.range
                    // bb.userObject = confirm building
                    // return
                    
                    // place building on confirm
                    // TODO: add confirm
                    // TODO: update for other resources
                    playerGold -= [NSClassFromString([[hudComponents objectForKey:@"buttonPanel"] selectedButton]) getCost];
                    [ui_gold_lbl setString:[NSString stringWithFormat:@"GOLD: %d",playerGold]];
                    
                    //[[SimpleAudioEngine sharedEngine] playEffect:@"tower_place.wav"];
                    Building *building = [NSClassFromString([[hudComponents objectForKey:@"buttonPanel"] selectedButton]) nodeWithTheGame:self location:bb.position];
                    
                    // Investigate: what is buildings used for also
                    // maybe buildings will be useful for global buffs/debuffs
                    // Investigate: "!!!!this wasn't doing anything" message
                    [buildings addObject:building];
                    
                    bb.userObject = (building);
                    return;
                } else {
                    // Didn't have enough money for the tower
                    NSLog(@"you broke son");
                    return;
                }
            }
        } else if (CGRectContainsPoint([bb boundingBox],location) && bb.userObject) {
            // elif bb has building
            if (currentlySelected) {
                [currentlySelected getUnselected];
            }
            
            // select the x
            [self selectObject:bb.userObject];
            
            // send x info to hudImage and hudInfomation
            // [hud x: x] (update hud buttons)
            // change bb sprite to selected sprite
            [currentlySelected getSelected];
            
            return;
        }
    }
    
    
    // for |enemy| in |enemies|
    for (Enemy *enemy in enemies) {
        // if location in enemies bounding box
        if (CGRectContainsPoint([enemy.mySprite boundingBox],location)) {
            // if nothing is selected
            if (!currentlySelected) {
                [self selectObject:enemy];
                //currentlySelected = enemy;
                
                // send enemy info to hudImage and hudInformation
                
                // change enemy to selected state (so its image updates to have a circle)
                [currentlySelected getSelected];
                return;
            } else {
                // Something is selected, unselect it and select the enemy instead.
                [currentlySelected getUnselected];
                
                [self selectObject:enemy];
                //currentlySelected = enemy;
                // send enemy info to hudImage and hudInformation
                
                // change enemy to selected state (so its image updates to have a circle)
                [currentlySelected getSelected];
                return;
            }
        }
    }
    
    
    if (currentlySelected != nil) {
        [currentlySelected getUnselected];
        [self selectObject:nil];
    }
    
    //[currentlySelected getUnselected];
    //[self selectObject:nil];
    
    // display button info and image
//    NSLog(@"reached the end of placed");    // Debug: check if reached the end
    
}


- (void)selectObject:(id)selectedObject {
    
    currentlySelected = selectedObject;
    
    // If nothing is selected, show the selected button's art and information
    // Otherwise update to the selectedObject's art and information
    if (!currentlySelected) {
        
        // Update the art image in the ImagePanel
        [[hudComponents objectForKey:@"imagePanel"] updateImage:[NSClassFromString([[hudComponents objectForKey:@"buttonPanel"] selectedButton]) getArt]];
        
        // Update the information in the InformationPanel
        [[hudComponents objectForKey:@"informationPanel"] updateInformationFromButton:NSClassFromString([[hudComponents objectForKey:@"buttonPanel"] selectedButton])];
        
        // Switch back to main page button view.
        [[hudComponents objectForKey:@"buttonPanel"] switchToPage];
        
        // Make the button selection sprite visibile
        [[[hudComponents objectForKey:@"buttonPanel"] selectionSprite] setVisible:YES];
        
        
    } else {
        
        // Update the art image in the ImagePanel
        [[hudComponents objectForKey:@"imagePanel"] updateImage:[currentlySelected artSpriteName]];
        
        // Update the information in the InformationPanel using theGame's currentlySelected id
        [[hudComponents objectForKey:@"informationPanel"] updateInformationFromSelected];
        
        // If currentlySelected is a building, update the button panel to the building's buttons
        // and enable them.
        // Else if its an enemy, disable all buttons
        if ([[currentlySelected class] isSubclassOfClass:[Building class]]) {
            [[hudComponents objectForKey:@"buttonPanel"] updateButtonPanelWithButtons:[currentlySelected buttons]];
            
            // Make the button selection sprite invisible
            [[[hudComponents objectForKey:@"buttonPanel"] selectionSprite] setVisible:NO];
            
        } else if ([[currentlySelected class] isSubclassOfClass:[Enemy class]]) {
            [[hudComponents objectForKey:@"buttonPanel"] disableButtons];
            
            // Make the button selection sprite invisible
            [[[hudComponents objectForKey:@"buttonPanel"] selectionSprite] setVisible:NO];
        }
        
    }
}


/*
// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

// Note: old back button code, remove sooner rather than later
- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// -----------------------------------------------------------------------
 */


@end
