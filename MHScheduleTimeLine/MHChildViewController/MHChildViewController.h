//
//  MHChildViewController.h
//  MHScheduleTimeLine
//
//  Created by Melaniia Hulianovych on 11/16/16.
//  Copyright © 2016 Melaniia Hulianovych. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHChildViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property(strong, nonatomic) NSMutableArray *dataSource;
@property(strong, nonatomic) NSIndexPath *activeIndex;

- (id)initWithArray:(NSArray *)array;
- (void)moveToCurrentTime;

@end
