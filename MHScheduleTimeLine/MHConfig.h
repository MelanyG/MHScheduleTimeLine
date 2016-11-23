//
//  MHConfig.h
//  MHScheduleTimeLine
//
//  Created by Melaniia Hulianovych on 11/22/16.
//  Copyright © 2016 Melaniia Hulianovych. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MHConfig : NSObject

@property (nonatomic, retain, readonly) UIFont *activeProgramFont;
@property (nonatomic, retain, readonly) UIColor *activeProgramTextColor;
@property (nonatomic, retain, readonly) UIFont *inactiveProgramFont;
@property (nonatomic, retain, readonly) UIColor *inactiveProgramTextColor;
@property (nonatomic, retain, readonly) UIFont *nowPlayingFont;
@property (nonatomic, retain, readonly) UIColor *timelineBarBackgroundColor;
@property (nonatomic, retain, readonly) UIColor *timelineBarTextColor;


+ (MHConfig *)sharedConfiguration;

@end
