//
//  NSTimer+Addition.m
//  MultiImage
//
//  Created by js on 8/9/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "NSTimer+Addition.h"

@implementation NSTimer (Addition)
- (void)pauseTimer
{
    self.fireDate = [NSDate distantFuture];
}

- (void)resumeTimer
{
    self.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
    
}
@end
