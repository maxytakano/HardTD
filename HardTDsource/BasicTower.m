//
//  BasicTower.m
//  HardTD
//
//  Created by Max Takano on 8/11/14.
//  Copyright Max Takano 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "BasicTower.h"
#import "BasicBullet.h"
#import "GameScene.h"

@implementation BasicTower

// Note: Might want to make these constant int's
// Static variable declarations
static int myCost = 200;
static NSString *buttonArt = @"tower.png";
static NSString *Art = @"testArt.png";

static int myDamage = 1;
static int myRange = 200;
static float mySpeed = 0.9f;
static NSString *myDescription = @"Basic Tower Description";

// Static variable getters
+(int)getCost {
    return myCost;
}

+(NSString *)getButtonArt {
    return buttonArt;
}

+(NSString *)getArt {
    return Art;
}

// button information
+(int)getDamage {
    return myDamage;
}

+(int)getRange {
    return myRange;
}

+(float)getSpeed {
    return mySpeed;
}

+(NSString *)getDescription {
    return myDescription;
}


+(id)nodeWithTheGame:(GameScene*)_game location:(CGPoint)myLocation {
    return [[self alloc] initWithTheGame:_game location:myLocation];
}

-(id)initWithTheGame:(GameScene*)_game location:(CGPoint)myLocation {
    // Note: will need to figure out sprite animation later, this code might help
    //NSString * spriteFrameName = [NSString stringWithFormat:@"icon_gold.png"];
    
    // Call super init
    if ((self = [super initWithTheGame:_game location:myLocation])) {
        
        // Note: will need to figure out sprite animation later, this code might help
        //if (self = [super initTheGameWithSprite:_game sprite:spriteFrameName]) {
        
        self.mySprite = [CCSprite spriteWithImageNamed:@"tower.png"];
		[self addChild:self.mySprite];
        
        [self.mySprite setPosition:myLocation];
        
        // Set art sprite
        self.artSpriteName = @"testArt.png";
        
        
        // Set buttons
        self.buttons = [[NSMutableArray alloc] init];
        //[self.buttons addObject:@"Upgrade"];
        //[self.buttons addObject:@"Sell"];
        
        NSArray *button1 = @[ @"Upgrade",
                              @"Upgrade.png"];
        NSArray *button2 = @[ @"Sell",
                              @"Sell.png"];
        [self.buttons addObject:button1];
        [self.buttons addObject:button2];
        

        
        // Initialize variables
        self.upgradeLevel = 0;
        self.sellValue = 100;
        
        // *upgradeCosts;
        // transform into;
        // int transformCost;
        // *upgradeData;
        
        self.damage = myDamage;
        self.towerRange = myRange;
        self.spawnRate = mySpeed;
        self.velocity = 130.0;
        self.maxEnemies = 1;
        self.currentEnemies = [[NSMutableArray alloc] initWithCapacity:self.maxEnemies];
        
        // Draw the range of the tower out
        CCDrawNode *circle = [[CCDrawNode alloc] init];
        
        // Investigate: could use segments to connect the dots
        // Note: Decrease the angle for more dots in the circle, increase for less
        for (float angle = 0; angle <= 2 * M_PI; angle += 0.2)
        {
            // Simple circle parametric equation
            [circle drawDot:CGPointMake(self.towerRange * cos(angle) + myLocation.x,
                                        self.towerRange * sin(angle) + myLocation.y)
                                        radius:1
                                        color:[CCColor redColor]];
        }
        [self addChild:circle];
        
        
    }
    return self;
}

-(void)spawnTowerSpawn
 {
     // Iterate through all current Enemies and spawn for each one
     for (Enemy *curEnemy in self.currentEnemies) {
         
         // Initialize new bullet
         BasicBullet * bullet = [BasicBullet nodeWithTheGame:self.theGame enemy:curEnemy
                                                bulletDamage:self.damage maxVelocity:self.velocity];
         
         // Initialize bullet position to tower center
         [bullet setPosition:self.mySprite.position];
         
         // the game has one giant bullet array
         [self.theGame.bullets addObject:bullet];
         
         // Pass each bullet into the current enemy (Goes into enemie's bullets array)
         [curEnemy takeBullet: bullet];
     }
     
 }

- (void)upgrade {
    self.upgradeLevel++;
    self.sellValue += 100;
    
    self.damage += 1;
    self.towerRange -= 0;
    self.spawnRate -= 0.2f;
    
    float colorIncrement = 1.0f - ((self.upgradeLevel*3.0f)/10.0f);
    
    [self.mySprite setColor:[CCColor colorWithRed:colorIncrement
                                              green:colorIncrement
                                              blue:colorIncrement]];
    
    // Lose sight of targets to begin firing with new stats
    for (Enemy *enemy in self.currentEnemies) {
        [self lostSightOfEnemy:enemy];
    }
    
}

@end
