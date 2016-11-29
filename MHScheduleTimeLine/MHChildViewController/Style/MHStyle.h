//
//  MHStyle.h
//  MHScheduleTimeLine
//
//  Created by Melaniia Hulianovych on 11/29/16.
//  Copyright © 2016 Melaniia Hulianovych. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MHStyle : NSObject

@property (nonatomic, retain) UIFont *activeProgramFont;
@property (nonatomic, retain) UIColor *activeProgramTextColor;
@property (nonatomic, retain) UIFont *inactiveProgramFont;
@property (nonatomic, retain) UIColor *inactiveProgramTextColor;
@property (nonatomic, retain) UIFont *nowPlayingFont;
@property (nonatomic, retain) UIColor *timelineBarBackgroundColor;
@property (nonatomic, retain) UIColor *timelineBarTextColor;
@property (nonatomic, retain) NSString *activeImageName;
@property (nonatomic, retain) NSString *inActiveImageName;

@end
