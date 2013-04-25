//
//  JTimer.h
//  JTimer
//
//  Created by Jeremy Tregunna on 2013-04-25.
//  Copyright (c) 2013 Jeremy Tregunna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JTimer : NSObject
+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval eventHandler:(void (^)(void))handler;
+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval queue:(dispatch_queue_t)queue eventHandler:(void (^)(void))handler;

- (void)invalidate;
- (void)reschedule;
@end
