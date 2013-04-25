//
//  JTimerTests.m
//  JTimerTests
//
//  Created by Jeremy Tregunna on 2013-04-25.
//  Copyright (c) 2013 Jeremy Tregunna. All rights reserved.
//

#import "JTimerTests.h"
#import "JTimer.h"

@implementation JTimerTests
{
    BOOL _timerFired;
}

- (void)setUp
{
    [super setUp];

    _timerFired = NO;
}

- (void)testCreateTimer
{
    JTimer* timer = [JTimer scheduledTimerWithTimeInterval:1 eventHandler:nil];
    STAssertNotNil(timer, @"Need to be able to create timers.");
}

- (void)testTimerFires
{
    __unused JTimer* timer = [JTimer scheduledTimerWithTimeInterval:1 eventHandler:nil];
    __unused NSTimer* osTimer = [NSTimer scheduledTimerWithTimeInterval:1.1 target:self selector:@selector(checkTimer) userInfo:nil repeats:NO];
}

- (void)testTimerFiresOnDifferentQueue
{
    dispatch_queue_t queue = dispatch_queue_create("test.queue", 0);
    __unused JTimer* timer = [JTimer scheduledTimerWithTimeInterval:1 queue:queue eventHandler:nil];
    __unused NSTimer* osTimer = [NSTimer scheduledTimerWithTimeInterval:1.1 target:self selector:@selector(checkTimer) userInfo:nil repeats:NO];
}

- (void)checkTimer
{
    STAssertTrue(_timerFired, @"Timer needs to fire");
}

@end
