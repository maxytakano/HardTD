#import "cocos2d.h"

@class GameScene, Waypoint, Tower, BasicBullet;

@interface Enemy: CCNode

@property (nonatomic, assign) int startingHp;
@property (nonatomic, assign) int currentHp;
@property (nonatomic, assign) int livesTaken;

@property (nonatomic, assign) float movementSpeed;
@property (nonatomic, assign) BOOL isFlying;

@property (nonatomic, assign) BOOL alive;
@property (nonatomic, assign) BOOL active;

@property (nonatomic, assign) CGPoint myPosition;
@property (nonatomic, strong) NSArray *bounty;    // array holds int values for 3 resources
@property (nonatomic, strong) Waypoint *destinationWaypoint;



@property (strong) NSMutableArray *attackedBy;
@property (nonatomic, strong) NSMutableArray *incomingBullets;

@property (nonatomic, weak) GameScene *theGame;
@property (nonatomic, strong) CCSprite *mySprite;
@property (nonatomic, strong) CCProgressNode *healthBar;
@property (nonatomic, strong) CCSprite *selectionSprite;

@property (nonatomic, strong) NSString *artSpriteName;


// For information box

// Overide the description property to set a description
@property (nonatomic, strong) NSString *gameDescription;


- (id)initWithTheGame:(GameScene *)_game;
- (void)doActivate;
- (void)getRemoved;
- (void)getAttacked:(Tower *)attacker;
- (void)gotLostSight:(Tower *)attacker;
- (void)getDamaged:(int)damage;
- (void)takeBullet:(BasicBullet *)incomingBullet;
- (void)getSelected;
- (void)getUnselected;

@end