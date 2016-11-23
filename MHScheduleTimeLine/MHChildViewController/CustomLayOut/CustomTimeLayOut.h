//
//  CustomTimeLayOut.h
//  MHScheduleTimeLine
//
//  Created by Melaniia Hulianovych on 11/17/16.
//  Copyright © 2016 Melaniia Hulianovych. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomTimeLayOutDelegate <UICollectionViewDelegate>

@required

- (void)layoutSubviewsWithAttributes:(NSMutableArray*)theAttributes;

@end


@interface CustomTimeLayOut : UICollectionViewFlowLayout

@property (nonatomic, strong) NSDictionary *layoutInfo;
@property (nonatomic) NSDate *startPoint;
@property (nonatomic) NSDate *endPoint;

- (void)setUpWithHalfHourItems:(NSInteger)hItems andProgramItems:(NSInteger)pItems andArrayOfSchedules:(NSArray *)schedule;
- (CGRect)frameForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
