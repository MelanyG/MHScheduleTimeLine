//
//  Program.h
//  MHScheduleTimeLine
//
//  Created by Melaniia Hulianovych on 11/16/16.
//  Copyright © 2016 Melaniia Hulianovych. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Program : NSObject

@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSDate *startTime;
@property(strong, nonatomic) NSDate *endTime;

@end
