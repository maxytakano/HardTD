//
//  ButtonPanel.m
//  HardTD
//
//  Created by Max Takano on 9/6/14.
//  Copyright (c) 2014 Max Takano. All rights reserved.
//

#import "ButtonPanel.h"
#import "GameScene.h"

@implementation ButtonPanel

+(id)nodeWithTheGame:(GameScene*)_game withData:(NSArray *)data {
    return [[self alloc] initWithTheGame:_game withData:data];
}

/**
 * Create an instance of a button panel using passed in data from a plist
 */
-(id)initWithTheGame:(GameScene*)_game withData:(NSArray *)data{
    // Note: will need to figure out sprite animation later, this code might help
    //NSString * spriteFrameName = [NSString stringWithFormat:@"icon_gold.png"];
    
    // Call super init
    if ((self = [super initWithTheGame:_game])) {
       
        // assign data from the passed in plist
        self.buttonData = data;
        
        
        // Note: old debug how do iterate through plist data
        /*for (NSArray *page in self.buttonData) {
            for (NSString *buildingName in page) {
                NSLog(@"%@", buildingName);
            }
        }*/
        //NSLog(@"%@", self.buttonData[0][1]);
        
        
        // Initialize selection sprite
        self.selectionSprite = [CCSprite spriteWithImageNamed:@"greenBoxButton.png"];
        self.selectionSprite.visible = YES;
        [self.selectionSprite setZOrder:1];
        [self addChild:self.selectionSprite];
        
        
        
        ////////////////// Initialize buttons //////////////////
    
        // allocate buttons array
        self.buttons = [[NSMutableArray alloc] initWithCapacity:PAGE_COUNT];
        
        
        for (int i = 0; i < PAGE_COUNT; i++) {
            // 84 x 62 buttons
            CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:@"noobtile.png"];
            
            // Note: @"" gives no label to buttons while @(i) shows the button id
            //CCButton *button = [CCButton buttonWithTitle:[@(i) stringValue] spriteFrame:spriteFrame];
            CCButton *button = [CCButton buttonWithTitle:@"" spriteFrame:spriteFrame];

            [button setTarget:self selector:@selector(_hudTouched:)];
            [self.buttons addObject:button];
        }
        
        ////////////////// Left Column //////////////////
    
        CCLayoutBox *leftColumn = [[CCLayoutBox alloc] init];
        leftColumn.anchorPoint = ccp(0.5, 0.5);  // Set the anchor to the middle of the tile image
        
        // Note: might want to make this have a better order later
        // adding the five left hud tiles
        for (int i = 0; i < PAGE_COUNT / 2; i++) {
            [leftColumn addChild:self.buttons[i]];
        }
        
        
        //leftColumn.spacing = 15.0f;  // commented out for no spacing between hud tiles
        leftColumn.direction = CCLayoutBoxDirectionVertical;
        [leftColumn layout];
        
        // set layoutbox position by using the right most of the screen - the size of half of the
        // bounding box of a button. (1.5 for the left column) to get the X.  For the Y divide the
        // number of buttons in a column (this is the page count / 2 since the page count should
        // be even) by 2 and multiply it by a button's height.
        leftColumn.position = ccp([[CCDirector sharedDirector] viewSize].width -
                                  [self.buttons[0] boundingBox].size.width * 1.5f,
                                  [self.buttons[0] boundingBox].size.height * ( (PAGE_COUNT/2) / 2.0f));
        [self addChild:leftColumn];
        
        
        ////////////////// Right Column //////////////////
        
        CCLayoutBox *rightColumn = [[CCLayoutBox alloc] init];
        rightColumn.anchorPoint = ccp(0.5, 0.5);  // Set the anchor to the middle of the image
        
        // Note: might want to make this have a better order later
        for (int i = PAGE_COUNT / 2; i < PAGE_COUNT; i++) {
            [rightColumn addChild:self.buttons[i]];
        }
        
        //rightColumn.spacing = 15.0f;  // commented out for no spacing between hud tiles
        rightColumn.direction = CCLayoutBoxDirectionVertical;
        [rightColumn layout];
        
        // set layoutbox position by using the right most of the screen - the size of half of the
        // bounding box of a button. (1.5 for the left column) to get the X.  For the Y divide the
        // number of buttons in a column (this is the page count / 2 since the page count should
        // be even) by 2 and multiply it by a button's height.
        rightColumn.position = ccp([[CCDirector sharedDirector] viewSize].width -
                                   [self.buttons[0] boundingBox].size.width * 0.5f,
                                   [self.buttons[0] boundingBox].size.height * ( (PAGE_COUNT/2) / 2.0f));
        [self addChild:rightColumn];
        
        
        ////////////////// Re-Order buttons //////////////////
        
        // Set up a reorder array
        NSMutableArray *orderArray = [[NSMutableArray alloc] init];
        for (int i = PAGE_COUNT-2; i >=0; i-=2) {
            [orderArray addObject:@(i)];
        }
        for (int i = PAGE_COUNT-1; i >=1; i-=2) {
            [orderArray addObject:@(i)];
        }
        
        // Reorder the array correctly (left to right 0-7)
        self.buttons = [[NSMutableArray alloc] initWithArray:[self.buttons sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSNumber* i = orderArray[[self.buttons indexOfObject:obj1]];
            NSNumber* j = orderArray[[self.buttons indexOfObject:obj2]];
            return [i compare:j];
        }]];
        
        ////////////////// Initialize Button Panel //////////////////
        
        // initialize buttons with first page's data
        [self setPageTo:0];
        
        // Initialize selected button
        CCButton *mybutton = (CCButton *)self.buttons[0];
        
        // set selectedButton to the top left tower of the first page
        self.selectedButton = mybutton.name;
        
        // Initialize top left button of first page to show selected state
        selectionPosition = CGPointMake([[mybutton parent] position].x,
                                                [mybutton position].y);
        
        
        ////////////////// Initialize Gestures //////////////////
      
        self.mySensitiveRect = CGRectMake([[CCDirector sharedDirector] viewSize].width - 84.0f, 155.0f, 84.0f, 155.0f);
        
        // listen for swipes to the left
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                               action:@selector(_handleGesture:)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeLeft];
        
        // listen for swipes to the right
        UISwipeGestureRecognizer * swipeRight= [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(_handleGesture:)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeRight];
        
        // initialize button handling
        self.buttonHandler = [[ButtonHandler alloc] initWithTheGame:self.theGame];
        
        
    }
    return self;
}

- (void)_handleGesture:(UISwipeGestureRecognizer *)sender {
    CGPoint p = [sender locationInView:[[CCDirector sharedDirector] view]];
    if (CGRectContainsPoint(self.mySensitiveRect, p)) {
        NSLog(@"got a swipe in the region i care about");
        
        // Check if the swipe direction is right(1) or left(2)
        if (sender.direction == 1) {
            NSLog(@"swiping right");
            if (self.currentPage != 0) {
                [self setPageTo:self.currentPage - 1];
            }
            
            
        } else if (sender.direction == 2) {
            NSLog(@"swiping left");
            if (self.currentPage != 1) {
                [self setPageTo:self.currentPage + 1];
            }
            
        }
        
        
    } else {
        NSLog(@"got a swipe, but not where i need it");
    }
}


- (void)_hudTouched:(id)sender
{
    CCButton *mybutton = (CCButton *)(sender);
    
    // Try to Handle the button
    // If a the button isn't handled (False is returned), select the button
    if (![self.buttonHandler handleButton:mybutton.name]) {
        
        // select the button
        self.selectedButton = mybutton.name;
        
        // let the game know a button is selected
        [self.theGame.currentlySelected getUnselected];
        
        // Update the Image Panel
        [[self.theGame.hudComponents objectForKey:@"imagePanel"] updateImage:
         [NSClassFromString([[self.theGame.hudComponents objectForKey:@"buttonPanel"] selectedButton]) getArt]];
        
        // Update the information in the InformationPanel
        [[self.theGame.hudComponents objectForKey:@"informationPanel"] updateInformationFromButton:NSClassFromString([[self.theGame.hudComponents objectForKey:@"buttonPanel"] selectedButton])];
        
        
        // Move selected sprite to the button's position
        selectionPosition = CGPointMake([[mybutton parent] position].x,
                                                [mybutton position].y);
        [self.selectionSprite setPosition:selectionPosition];

    }
}

- (void)unassignButtonWithID:(int)buttonID {
    
    [self.buttons[buttonID] setEnabled:NO];
    
    // Set the button's spriteFrame to the building's button image
    CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:@"noobtile-hd.png"];
    [self.buttons[buttonID] setBackgroundSpriteFrame:spriteFrame forState:CCControlStateNormal];
    
}


- (void)setPageTo:(int)page {
    // Debug: setting page info
    NSLog(@"setting page to %d", page);
    
    // Update the current page
    self.currentPage = page;
    
    // Iterate through each button and set it to corresponding button Data
    for (int i = 0; i < [self.buttons count]; i++) {
        // Re-enable any disabled buttons
        if ([self.buttons[i] enabled] == NO) {
            [self.buttons[i] setEnabled:YES];
        }
        
        NSString * buttonName = self.buttonData[page][i];
        [self assignButtonWithID:i
                      toButton:buttonName
                         toImage:[NSClassFromString(buttonName) getButtonArt]];
    }
    
    
    [self.selectionSprite setPosition:selectionPosition];
}

- (void)assignButtonWithID:(int)buttonID
                  toButton:(NSString *)buttonName
                   toImage:(NSString *)imageString {
    
    // Set the button's name to the buildingName, to make it a button of that building type
    [self.buttons[buttonID] setName:buttonName];
    
    // Set the button's spriteFrame to the building's button image
    CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:imageString];
    [self.buttons[buttonID] setBackgroundSpriteFrame:spriteFrame forState:CCControlStateNormal];
}

// Update the button panel with the selected building's buttons
- (void)updateButtonPanelWithButtons:(NSMutableArray *)buildingButtons {
    // Add the building's buttons to the button panel
    int count = 0;
    
    for (NSArray *button in buildingButtons) {
        // Re-enable any disabled buttons (when coming from a selected enemy
        if ([self.buttons[count] enabled] == NO) {
            [self.buttons[count] setEnabled:YES];
        }
        
        // button[0] is the button name, button[1] is the button image
        [self assignButtonWithID:count toButton:button[0] toImage:button[1]];
        count++;
    }
    
    // Unassign the remaining buttons
    for (int i = count; i < [self.buttons count]; i++) {
        [self unassignButtonWithID:i];
    }
}

- (void)switchToPage {
    [self setPageTo:self.currentPage];
}

- (void)disableButtons {
    for (int i = 0; i < [self.buttons count]; i++) {
        [self unassignButtonWithID:i];
    }
}


@end
