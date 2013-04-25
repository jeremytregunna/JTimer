//
//  JTimer.m
//  JTimer
//
//  Created by Jeremy Tregunna on 2013-04-25.
//  Copyright (c) 2013 Jeremy Tregunna. All rights reserved.
//

#import "JTimer.h"

@implementation JTimer
{
    dispatch_queue_t _timerQueue;
    dispatch_source_t _timer;

    NSTimeInterval _timeInterval;
    void (^_handler)(void);
    BOOL _valid;
}

+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval eventHandler:(void (^)(void))handler
{
    return [self scheduledTimerWithTimeInterval:timeInterval queue:dispatch_get_main_queue() eventHandler:handler];
}
+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval queue:(dispatch_queue_t)queue eventHandler:(void (^)(void))handler
{
    return [[self alloc] initWithTimeInterval:timeInterval queue:queue eventHandler:handler];
}

- (instancetype)initWithTimeInterval:(NSTimeInterval)timeInterval queue:(dispatch_queue_t)queue eventHandler:(void (^)(void))handler
{
    if((self = [super init]))
    {
        _timerQueue = queue;
        [self reschedule];
    }
    return self;
}

- (void)invalidate
{
    _valid = NO;
    _timer = nil;
}

- (void)reschedule
{
    _valid = YES;
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _timerQueue);
    if(_timer)
    {
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), _timeInterval * NSEC_PER_SEC, 30 * NSEC_PER_MSEC);
        dispatch_source_set_event_handler(_timer, ^{
            if(_valid && _handler)
                _handler();
        });
        dispatch_resume(_timer);
    }
}

@end
