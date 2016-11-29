//
//  MHParentController.m
//  MHScheduleTimeLine
//
//  Created by Melaniia Hulianovych on 11/16/16.
//  Copyright © 2016 Melaniia Hulianovych. All rights reserved.
//

#import "MHParentController.h"
#import "Program.h"
#import "MHChildViewController.h"
#import "MHMiddleViewController.h"
#import "MHStyle.h"

CGFloat const kDPIPerMinute = 7.f; //?


@interface MHParentController ()

@property (weak, nonatomic) IBOutlet UIButton *fisrtVersionButton;
@property (weak, nonatomic) IBOutlet UIButton *secondVersionButton;
@property (weak, nonatomic) IBOutlet UIView *parentContainer;
@property (strong, nonatomic) MHChildViewController *timeLineController;
@property (strong, nonatomic) MHMiddleViewController *middleContainer;
@property (strong, nonatomic) NSMutableArray *secondCaseArray;
@property (strong, nonatomic) NSMutableArray *firstCaseArray;

@end


@implementation MHParentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstCaseArray = [self createArrayWithSchedules];
    MHStyle *style = [MHStyle new];
    style.activeProgramFont = [[MHConfig sharedConfiguration]activeProgramFont];
    style.activeProgramTextColor = [[MHConfig sharedConfiguration]activeProgramTextColor];
    style.inactiveProgramFont = [[MHConfig sharedConfiguration]inactiveProgramFont];
    style.inactiveProgramTextColor = [[MHConfig sharedConfiguration]inactiveProgramTextColor];
    style.nowPlayingFont = [[MHConfig sharedConfiguration]nowPlayingFont];
    style.timelineBarBackgroundColor = [[MHConfig sharedConfiguration]timelineBarBackgroundColor];
    style.timelineBarTextColor = [[MHConfig sharedConfiguration]timelineBarTextColor];
    style.activeImageName = @"schedule_active_background.png";
    style.inActiveImageName = @"schedule_inactive_background_pad.png";
    
    
    self.timeLineController = [[MHChildViewController alloc]initWithArray:self.firstCaseArray andStyle:style];
    self.middleContainer = [[MHMiddleViewController alloc]init];
     [self displayMiddleContentController:self.middleContainer];
    
    [self displayContentController:self.timeLineController];
}

- (IBAction)firstCaseArray:(id)sender {
    
    [self.timeLineController resetControllerWithData:self.firstCaseArray];
}

- (IBAction)secondCaseArray:(id)sender {
    if(!self.secondCaseArray) {
        self.secondCaseArray = [self createSecondCaseArrayWithSchedules];
    }
    [self.timeLineController resetControllerWithData:self.secondCaseArray];
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) displayContentController: (MHChildViewController *)content {
    [self.middleContainer addChildViewController:content];
    content.view.frame = CGRectMake(self.middleContainer.middleView.frame.origin.x, self.middleContainer.middleView.frame.origin.y, self.middleContainer.middleView.frame.size.width, self.middleContainer.middleView.frame.size.height);
    [self.middleContainer.middleView addSubview:content.view];
    content.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self createConstraints];
    [content didMoveToParentViewController:self.middleContainer];
}

- (void) displayMiddleContentController: (MHMiddleViewController *)content {
    [self addChildViewController:content];
    content.view.frame = CGRectMake(self.parentContainer.frame.origin.x, self.parentContainer.frame.origin.y, self.parentContainer.frame.size.width, self.parentContainer.frame.size.height);
    [self.parentContainer addSubview:content.view];
    content.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self createMiddleConstraints];
    [content didMoveToParentViewController:self];
}

- (void)createMiddleConstraints {
    [self.parentContainer addConstraint:[NSLayoutConstraint constraintWithItem:self.middleContainer.view
                                                                   attribute:NSLayoutAttributeTop
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.parentContainer
                                                                   attribute:NSLayoutAttributeTop
                                                                  multiplier:1
                                                                    constant:0]];
    
    [self.parentContainer addConstraint:[NSLayoutConstraint constraintWithItem:self.middleContainer.view
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.parentContainer
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1
                                                                    constant:0]];
    
    [self.parentContainer addConstraint:[NSLayoutConstraint constraintWithItem:self.middleContainer.view
                                                                   attribute:NSLayoutAttributeLeading
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.parentContainer
                                                                   attribute:NSLayoutAttributeLeading
                                                                  multiplier:1
                                                                    constant:0]];
    
    [self.parentContainer addConstraint:[NSLayoutConstraint constraintWithItem:self.middleContainer.view
                                                                   attribute:NSLayoutAttributeTrailing
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.parentContainer
                                                                   attribute:NSLayoutAttributeTrailing
                                                                  multiplier:1
                                                                    constant:0]];
}

- (void)createConstraints {
    [self.middleContainer.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLineController.view
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.middleContainer.middleView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:0]];
    
    [self.middleContainer.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLineController.view
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.middleContainer.middleView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:0]];
    
    [self.middleContainer.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLineController.view
                                                                     attribute:NSLayoutAttributeLeading
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.middleContainer.middleView
                                                                     attribute:NSLayoutAttributeLeading
                                                                    multiplier:1
                                                                      constant:0]];
    
    [self.middleContainer.middleView addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLineController.view
                                                                     attribute:NSLayoutAttributeTrailing
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.middleContainer.middleView
                                                                     attribute:NSLayoutAttributeTrailing
                                                                    multiplier:1
                                                                      constant:0]];
}



- (NSMutableArray *)createArrayWithSchedules {
    
    NSArray *programNames = @[@"Music Through The Night", @"BBC World Service", @"Morning Edition", @"BBC Newshour", @"City Lights with Lois Reitzes", @"Here And Now", @"A Closer Look with Rose Scott and Jim Burress", @"Fresh Air", @"All Things Considered", @"Marketplace"];
    NSMutableArray *startTime = [NSMutableArray new];
    NSMutableArray *endTimes = [NSMutableArray new];
    NSDate *date = [[NSDate new]dateByAddingTimeInterval:-1*24*60*60];
    [startTime addObject:date];
    for(int j = 0; j < 48 * 2; j++) {

      NSDate *newDate = [startTime[j] dateByAddingTimeInterval:(20)*60];
        [startTime addObject:newDate];
        [endTimes addObject:newDate];
    }
    NSDate *newDate = [[startTime lastObject] dateByAddingTimeInterval:20*60];
    [endTimes addObject:newDate];
    NSMutableArray *array = [NSMutableArray new];
    int i = 0, j = 0;
    while (j < 48*2) {
        Program *one = [Program new];
        one.title = programNames[i];
        one.startTime = startTime[j];
        one.endTime = endTimes[j];
        i++;j++;
        if(i == 10)
            i = 0;
        [array addObject:one];
    }
    return array;
}

- (NSMutableArray *)createSecondCaseArrayWithSchedules {
    
    NSArray *programNames = @[@"Music Through The Night", @"BBC World Service", @"Morning Edition", @"BBC Newshour", @"City Lights with Lois Reitzes", @"Here And Now", @"A Closer Look with Rose Scott and Jim Burress", @"Fresh Air", @"All Things Considered", @"Marketplace"];
    NSMutableArray *startTime = [NSMutableArray new];
    NSMutableArray *endTimes = [NSMutableArray new];
    NSDate *date = [[NSDate new]dateByAddingTimeInterval:-1*24*60*60];
    [startTime addObject:date];
    for(int j = 0; j < 48; j++) {
        NSDate *newDate;
        if(j % 2) {
           newDate = [startTime[j] dateByAddingTimeInterval:(20 + 40) * 60];
        } else {
            newDate = [startTime[j] dateByAddingTimeInterval:30 * 60];
        }
        [startTime addObject:newDate];
        [endTimes addObject:newDate];
    }
    NSDate *newDate = [[startTime lastObject] dateByAddingTimeInterval:20*60];
    [endTimes addObject:newDate];
    NSMutableArray *array = [NSMutableArray new];
    int i = 0, j = 0;
    while (j < 48) {
        Program *one = [Program new];
        one.title = programNames[i];
        one.startTime = startTime[j];
        one.endTime = endTimes[j];
        i++;j++;
        if(i == 10)
            i = 0;
        [array addObject:one];
    }
    return array;
}

@end
