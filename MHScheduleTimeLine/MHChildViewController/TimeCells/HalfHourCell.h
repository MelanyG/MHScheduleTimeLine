//
//  HalfHourCell.h
//  MHScheduleTimeLine
//
//  Created by Melaniia Hulianovych on 11/17/16.
//  Copyright © 2016 Melaniia Hulianovych. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HalfHourCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UIView *tickStart;
@property (weak, nonatomic) IBOutlet UIView *tickEnd;


@end
