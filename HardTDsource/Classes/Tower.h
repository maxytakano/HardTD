#import "Building.h"

@class Enemy;

/**
 * Tower class inherits from building to use location, and GUI buttons,
 * extends the building to spawn tower spawns.
 */
@interface Tower: Building

@property (nonatomic, assign) int towerRange;   // How far the tower can shoot
@property (nonatomic, assign) float spawnRate;  // How fast the tower spawns Tower Spawns
@property (nonatomic, assign) int maxEnemies;   // Max number of targets the tower can have

@property (nonatomic, strong) NSMutableArray *currentEnemies;


- (void)targetKilled:(Enemy *)enemy;
-(void)lostSightOfEnemy:(Enemy *)enemy;

@end