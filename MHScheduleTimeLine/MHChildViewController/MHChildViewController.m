//
//  MHChildViewController.m
//  MHScheduleTimeLine
//
//  Created by Melaniia Hulianovych on 11/16/16.
//  Copyright © 2016 Melaniia Hulianovych. All rights reserved.
//

#import "MHChildViewController.h"
#import "ProgramCell.h"
#import "HalfHourCell.h"
#import "Program.h"
#import "CustomTimeLayOut.h"
#import "MHParentController.h"


@interface MHChildViewController (){
    NSCalendar *_gregorianCalendar;

}


@property (weak, nonatomic) IBOutlet CustomTimeLayOut *customLayOut;
@property (strong, nonatomic) NSArray *timeLablesArray;
@property (strong, nonatomic) NSTimer *autoScrollingTimer;

@end

@implementation MHChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor orangeColor];
//    self.timeLineCollection.backgroundColor = [UIColor purpleColor];
//    self.timeLineCollection.delegate = self;
//    [self moveToCurrentTime];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithArray:(NSArray *)array {
    self = [super init];
    if (self != nil) {
        self.dataSource = (NSMutableArray *)array;
        self.view = [[[NSBundle mainBundle] loadNibNamed:@"MHChildViewController" owner:self options:nil] objectAtIndex:0];
        self.timeLablesArray = [self createTimeArray:array];
        [self.timeLineCollection registerNib:[UINib nibWithNibName:@"ProgramCell" bundle:nil] forCellWithReuseIdentifier:@"ProgramCell"];
        [self.timeLineCollection registerNib:[UINib nibWithNibName:@"HalfHourCell" bundle:nil] forCellWithReuseIdentifier:@"HalfHourCell"];
        [self.customLayOut setUpWithHalfHourItems:self.timeLablesArray.count andProgramItems:self.dataSource.count andArrayOfSchedules:array];

        self.timeLineCollection.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self moveToCurrentTime];
    [self startAutoScrollingTimer];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self stopAutoScrollingTimer];
}

#pragma mark - Reset of Controller

- (void)resetController:(NSMutableArray *)newData {
    self.dataSource = newData;
    [self.customLayOut setUpWithHalfHourItems:self.timeLablesArray.count andProgramItems:self.dataSource.count andArrayOfSchedules:newData];
    [self.customLayOut invalidateLayout];
    [self moveToCurrentTime];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == 0) {
        return self.dataSource.count;
    } else {
        return self.timeLablesArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const CellIdentifier = @"ProgramCell";
    static NSString * const HalfHourCellIdentifier = @"HalfHourCell";
    UICollectionViewCell *cell;

    if(indexPath.section == 1) {
        HalfHourCell *hourCell = [collectionView dequeueReusableCellWithReuseIdentifier:HalfHourCellIdentifier forIndexPath:indexPath];
        hourCell.timeLable.text = self.timeLablesArray[indexPath.item];
        [hourCell.timeLable setTextColor:[MHConfig sharedConfiguration].timelineBarTextColor];
        hourCell.backgroundColor = [MHConfig sharedConfiguration].timelineBarBackgroundColor;
        cell = hourCell;

    } else {
        Program *program = self.dataSource[indexPath.item];

        ProgramCell *programCell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        programCell.title.text = program.title;
        if(self.activeIndex.item == indexPath.item) {
            [programCell.title setFont:[MHConfig sharedConfiguration].activeProgramFont];
            [programCell.title setTextColor:[MHConfig sharedConfiguration].activeProgramTextColor];
            programCell.backgroundColor = [UIColor lightGrayColor];
        } else {
            [programCell.title setFont:[MHConfig sharedConfiguration].inactiveProgramFont];
            [programCell.title setTextColor:[MHConfig sharedConfiguration].inactiveProgramTextColor];
            programCell.backgroundColor = [UIColor grayColor];
        }
        cell = programCell;
    }
      
    return cell;
}

#pragma mark - Helping methods

-(NSArray *)createTimeArray:(NSArray *)mainArray {
    NSMutableArray *tmpArray = [NSMutableArray new];
    if (_gregorianCalendar == nil) {
        _gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    NSDateComponents *comps = [_gregorianCalendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:((Program *)mainArray[0]).startTime];
    NSDateComponents *endComps = [_gregorianCalendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:((Program *)mainArray.lastObject).endTime];

    NSInteger hour = [comps hour];   // I add 48 hours to prevent the value from ever being negative with scrolling into the past.  The display gets slightly messed up if the times become negative.
    NSInteger minutes = [comps minute];
    if(minutes > 30) {
        [comps setMinute:30];
    } else {
     comps.minute = 0;
    }

    NSInteger endMinutes = [endComps minute];
    if(endMinutes > 30) {
        [endComps setMinute:30];
    } else {
        endComps.minute = 0;
    }
    
    NSDate *endDate = [[NSCalendar currentCalendar] dateFromComponents:endComps];
    self.customLayOut.endPoint = endDate;

    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comps];
    self.customLayOut.startPoint = date;
    NSInteger iterationTimes = [endDate timeIntervalSinceDate:date]/60/30;
    for(int i = 0; i < iterationTimes; i++) {
        NSInteger currHour = (hour) * 60 + minutes;
        NSInteger newHour = ((hour * 60 + minutes) / 60);
        NSInteger tmpHour = newHour;
        newHour = newHour > 12 ? newHour % 12 : newHour;
        NSString *hourString = [NSString stringWithFormat:(currHour%60 < 30) ? @"%ld:00%c":@"%ld:30%c", (long)newHour, (tmpHour %24 < 12)?'A':'P'];
        minutes +=30;
        [tmpArray addObject:hourString];
    }
    
    return tmpArray;
}

- (void)moveToCurrentTime {

    NSDate *currentDate = [NSDate new];
    NSInteger difference = [currentDate timeIntervalSinceDate:self.customLayOut.startPoint] / 60 * kPixelsPerMinute - [UIScreen mainScreen].bounds.size.width / 2;
    
    CGPoint destinationPoint = CGPointMake(difference, 0.f);
    [self.timeLineCollection setContentOffset:destinationPoint animated:YES];
    [self definingActiveView:destinationPoint];
    [self addActiveLine:destinationPoint];
}

#pragma mark - Timer Settings

- (void)startAutoScrollingTimer {
    if (!_autoScrollingTimer) {
        _autoScrollingTimer = [NSTimer scheduledTimerWithTimeInterval:5.
                                                               target:self
                                                             selector:@selector(moveToCurrentTime)
                                                             userInfo:nil
                                                              repeats:YES];
    }
}

- (void)stopAutoScrollingTimer {
    [_autoScrollingTimer invalidate];
    _autoScrollingTimer = nil;
}

#pragma mark - Drawinf of Spliiter

- (void)addActiveLine:(CGPoint)point {
    for (CALayer *layer in self.timeLineCollection.layer.sublayers) {
        if([layer.name isEqualToString:@"ActiveLine"]) {
            [layer removeFromSuperlayer];
            break;
        }
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    point.x += [UIScreen mainScreen].bounds.size.width / 2;
    [path moveToPoint:point];
    [path addLineToPoint:CGPointMake(point.x, 25)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
    shapeLayer.lineWidth = 2.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    shapeLayer.name = @"ActiveLine";
    [self.timeLineCollection.layer addSublayer:shapeLayer];
}

- (void)definingActiveView:(CGPoint)activeXPosition {
    activeXPosition.y = 25.f;
    activeXPosition.x += [UIScreen mainScreen].bounds.size.width / 2;
    self.activeIndex = [self.timeLineCollection indexPathForItemAtPoint:activeXPosition];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:self.activeIndex.item inSection:0];
    self.activeIndex = newIndexPath;
}

#pragma mark - ScrollViewDelegate methods

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [self stopAutoScrollingTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self startAutoScrollingTimer];
}

@end
