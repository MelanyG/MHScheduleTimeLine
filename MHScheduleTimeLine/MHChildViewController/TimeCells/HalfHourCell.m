//
//  HalfHourCell.m
//  MHScheduleTimeLine
//
//  Created by Melaniia Hulianovych on 11/17/16.
//  Copyright © 2016 Melaniia Hulianovych. All rights reserved.
//

#import "HalfHourCell.h"
#import "MHConfig.h"

@implementation HalfHourCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tickEnd.backgroundColor = [MHConfig sharedConfiguration].timelineBarTextColor;
    self.tickStart.backgroundColor = [MHConfig sharedConfiguration].timelineBarTextColor;
}

@end
