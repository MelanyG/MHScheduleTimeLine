//
//  MHChildViewController.h
//  MHScheduleTimeLine
//
//  Created by Melaniia Hulianovych on 11/16/16.
//  Copyright © 2016 Melaniia Hulianovych. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHConfig.h"


@interface MHChildViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property(strong, nonatomic) NSMutableArray *dataSource;
@property(strong, nonatomic) NSIndexPath *activeIndex;
@property(strong, nonatomic) NSIndexPath *currentProgrameIndex;
@property (weak, nonatomic) IBOutlet UICollectionView *timeLineCollection;

- (id)initWithArray:(NSArray *)array;
- (void)moveToCurrentTime;
- (void)resetController:(NSMutableArray *)newData;
@end
