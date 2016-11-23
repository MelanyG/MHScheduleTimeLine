//
//  MHConfig.m
//  MHScheduleTimeLine
//
//  Created by Melaniia Hulianovych on 11/22/16.
//  Copyright © 2016 Melaniia Hulianovych. All rights reserved.
//

#import "MHConfig.h"


@interface MHConfig ()

@property (nonatomic, retain) UIFont *activeProgramFont;
@property (nonatomic, retain) UIColor *activeProgramTextColor;
@property (nonatomic, retain) UIFont *inactiveProgramFont;
@property (nonatomic, retain) UIColor *inactiveProgramTextColor;
@property (nonatomic, retain) UIFont *nowPlayingFont;
@property (nonatomic, retain) UIColor *timelineBarBackgroundColor;
@property (nonatomic, retain) UIColor *timelineBarTextColor;

@end

@implementation MHConfig

static MHConfig *singleton;


#pragma mark - Init & dealloc methods

+ (MHConfig *)sharedConfiguration {
    if (singleton == nil) {
        singleton = [MHConfig new];
    }
    return singleton;
}

- (id)init {
    self = [super init];
    if (self) {
        self.activeProgramFont = [UIFont fontWithName:@"Helvetica" size:18.f];

        self.activeProgramTextColor = [UIColor colorWithRed:0/255.0 green:96./255.0 blue:169./255.0 alpha:1.0];
        self.inactiveProgramFont = [UIFont fontWithName:@"Helvetica" size:14.];
  
        self.inactiveProgramTextColor = [UIColor colorWithRed:64./255.0 green:64./255.0 blue:64./255.0 alpha:1.0];
        self.nowPlayingFont = [UIFont fontWithName:@"Helvetica" size:13.];
        self.timelineBarBackgroundColor = [UIColor colorWithRed:60./255.0 green:60./255.0 blue:60./255.0 alpha:1.0];
        self.timelineBarTextColor = [UIColor colorWithRed:200./255.0 green:200./255.0 blue:200./255.0 alpha:1.0];
    }
    return self;
}

@end