#import "Waypoint.h"

@implementation Waypoint

@synthesize myPosition, nextWaypoint;

+ (id)nodeWithTheGame:(GameScene*)_game location:(CGPoint)location
{
    return [[self alloc] initWithTheGame:_game location:location];
}

- (id)initWithTheGame:(GameScene *)_game location:(CGPoint)location
{
	if( (self=[super init])) {
		
		theGame = _game;
        
        [self setPosition:CGPointZero];
        myPosition = location;
		
        [theGame addChild:self];
        
	}
	
	return self;
}

- (void)draw
{
    // TODO: figure out whats going on here, nothing being drawn, draw not being called probably
    CCDrawNode *overlay = [[CCDrawNode alloc] init];
    CCColor *circleColor = [[CCColor alloc] init];
    circleColor = [circleColor initWithRed:1.0 green:.02 blue:1.0];
    
    
    [overlay drawDot:myPosition radius:6 color:circleColor];
    [overlay drawDot:myPosition radius:2 color:circleColor];
    //ccDrawColor4B(0, 255, 2, 255);
    //CCDrawCircle(myPosition, 6, 360, 30, false);
    //ccDrawCircle(myPosition, 2, 360, 30, false);
    
    //if(nextWaypoint)  // max - add back in
    //    ccDrawLine(myPosition, nextWaypoint.myPosition);
    
    //[super draw]; // max - commented out dunno if need to call super
}

@end