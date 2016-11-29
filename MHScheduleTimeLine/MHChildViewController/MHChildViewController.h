//
//  MHChildViewController.h
//  MHScheduleTimeLine
//
//  Created by Melaniia Hulianovych on 11/16/16.
//  Copyright © 2016 Melaniia Hulianovych. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHConfig.h"

@class MHStyle;

@interface MHChildViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property(strong, nonatomic) NSMutableArray *dataSource;
@property(strong, nonatomic) NSIndexPath *activeIndex;
@property(strong, nonatomic) NSIndexPath *currentProgrameIndex;
@property (weak, nonatomic) IBOutlet UICollectionView *timeLineCollection;

- (id)initWithArray:(NSArray *)array andStyle:(MHStyle *)style;
- (void)moveToCurrentTime;
- (void)resetControllerWithData:(NSMutableArray *)newData;
@end
