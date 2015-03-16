#import "Enemy.h"
#import "Tower.h"
#import "Waypoint.h"
#import "BasicBullet.h"
#import "GameScene.h"

//#import "SimpleAudioEngine.h"     // Note: Add sound back in later

// Note: remove or modify these constants
//#define HEALTH_BAR_WIDTH 20
#define HEALTH_BAR_ORIGIN 20

@implementation Enemy

@synthesize mySprite;
@synthesize theGame;
@synthesize incomingBullets;
//@synthesize mySprite2;    // Note: for hp bar


-(id)initWithTheGame:(GameScene *)_game {
	if ((self=[super init])) {
        
        self.alive = YES;
		theGame = _game;
        
        // Set to inactive until all enemies in the wave are allocated
        self.active = NO;
        
        // Initialize enemy sprite
        mySprite = [CCSprite spriteWithImageNamed:@"enemy.png"];
		[self addChild:mySprite];
    
        // Initialize the health bar progressNode
        self.healthBar = [CCProgressNode progressWithSprite:[CCSprite spriteWithImageNamed:@"GreenHealthBar.png"]];
        self.healthBar.type = CCProgressNodeTypeBar;
        self.healthBar.midpoint = ccp(0.0f, 0.0f);
        self.healthBar.barChangeRate = ccp(1.0f, 0.0f);
        self.healthBar.percentage = 100.0f;
        self.healthBar.scale = 0.6f;
        [self addChild:self.healthBar];
        
        // Initialize selection sprite, starts invisible until selected
        self.selectionSprite = [CCSprite spriteWithImageNamed:@"greenBox.png"];
        self.selectionSprite.visible = NO;
        [self.selectionSprite setZOrder:-1];
        [self addChild:self.selectionSprite];
        
        
        Waypoint * waypoint = (Waypoint *)[theGame.waypoints objectAtIndex:([theGame.waypoints count]-1)];
        self.destinationWaypoint = waypoint.nextWaypoint;
        
        // Set starting position to the position of the first waypoint
        CGPoint pos = waypoint.myPosition;
        self.myPosition = pos;
        
        // Set health bar position above enemy position
        CGPoint healthBarPosition = ccp(pos.x, pos.y + HEALTH_BAR_ORIGIN);
        
        
        self.attackedBy = [[NSMutableArray alloc] initWithCapacity:5];
        incomingBullets = [[NSMutableArray alloc] init];
        
       
        // Initialize the sprite's positions
        [mySprite setPosition:pos];
        [self.healthBar setPosition:healthBarPosition];
        [self.selectionSprite setPosition:pos];

		
        [theGame addChild:self];
        
	}
	
	return self;
}

-(void)doActivate
{
    self.active = YES;
}

-(void)update:(CCTime)delta
{
    if(!self.active)return;

    // Debug: Check for when there are no more incoming bullets and are dead
    if (incomingBullets.count == 0 && self.alive == NO) {
        [self getRemoved];
        return;
    }

    if([theGame circle:self.myPosition withRadius:1 collisionWithCircle:self.destinationWaypoint.myPosition collisionCircleRadius:1])
    {
        if(self.destinationWaypoint.nextWaypoint)
        {
            self.destinationWaypoint = self.destinationWaypoint.nextWaypoint;
        }else
        {
            //Reached the end of the road. Damage the player
            [theGame getHpDamage:self.livesTaken];
            [self getRemoved];
            return;
        }
    }
    
    
    CGPoint targetPoint = self.destinationWaypoint.myPosition;
    float currentMovementSpeed = self.movementSpeed;
    
    CGPoint normalized = ccpNormalize(ccp(targetPoint.x-self.myPosition.x,targetPoint.y-self.myPosition.y));
    mySprite.rotation = CC_RADIANS_TO_DEGREES(atan2(normalized.y,-normalized.x));
    
    // Calculate the current enemy position
    self.myPosition = ccp(self.myPosition.x+normalized.x * currentMovementSpeed,self.myPosition.y+normalized.y * currentMovementSpeed);
    
    // Set health bar position above enemy position
    CGPoint healthBarPosition = ccp(self.myPosition.x, self.myPosition.y + HEALTH_BAR_ORIGIN);
    
    // Update the sprite's Positions
    [mySprite setPosition:self.myPosition];
    [self.healthBar setPosition:healthBarPosition];
    [self.selectionSprite setPosition:self.myPosition];
}


-(void)getRemoved
{
    [self removeFromParentAndCleanup:YES];
    
    // Note: might need to remove children? probably not
    //[self.parent removeChild:self cleanup:YES];
    
    
    // Notify the game that we killed an enemy so we can check if we can send another wave
    [theGame enemyGotKilled];
}

-(void)getkilled
{
    for(Tower * attacker in self.attackedBy)
    {
        [attacker targetKilled:self];
    }
    [theGame.enemies removeObject:self];
    
    self.alive = NO;
    mySprite.visible = NO;
    self.movementSpeed = 0.0;
}

-(void)getAttacked:(Tower *)attacker
{
    [self.attackedBy addObject:attacker];
}

-(void)gotLostSight:(Tower *)attacker
{
    [self.attackedBy removeObject:attacker];
}


-(void)getDamaged:(int)damage
{
    //[[SimpleAudioEngine sharedEngine] playEffect:@"laser_shoot.wav"];
    self.currentHp -= damage;
    
    // Calculate percentage of life left
    float lifePercentage = (float)self.currentHp / (float)self.startingHp;
    lifePercentage *= 100.0f;
    
    // Adjust health bar to reflect the percentage left
    self.healthBar.percentage = lifePercentage;
    
    // If health is less than 25% change the bar color to red
    if (self.healthBar.percentage < 25.0f) {
        [self.healthBar setSprite:[CCSprite spriteWithImageNamed:@"RedHealthBar.png"]];
    }

    // If health is less than or equal to 0, award the player gold and get killed
    if(self.currentHp <= 0)
    {
        [theGame awardGold:[self.bounty[0] intValue] resource2:[self.bounty[1] intValue]
                 resource3:[self.bounty[2] intValue]];
        [self getkilled];
    }
}

-(void)takeBullet:(BasicBullet *)incomingBullet {
    [incomingBullets addObject:incomingBullet];
}

- (void)getSelected {
    self.selectionSprite.visible = YES;
}
- (void)getUnselected {
    self.selectionSprite.visible = NO;
}


@end