#import "cocos2d.h"
#import "GameScene.h"

@interface Waypoint: CCNode {
    GameScene *theGame;
}

// Note: Might need to change this to strong
@property (nonatomic,assign) CGPoint myPosition;
@property (nonatomic,strong) Waypoint *nextWaypoint;

+ (id)nodeWithTheGame:(GameScene*)_game location:(CGPoint)location;
- (id)initWithTheGame:(GameScene *)_game location:(CGPoint)location;

@end
