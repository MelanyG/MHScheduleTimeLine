//
//  MHMiddleViewController.m
//  MHScheduleTimeLine
//
//  Created by Melaniia Hulianovych on 11/25/16.
//  Copyright © 2016 Melaniia Hulianovych. All rights reserved.
//

#import "MHMiddleViewController.h"

@interface MHMiddleViewController ()

@property (strong, nonatomic) MHChildViewController *timeLineController;

@end

@implementation MHMiddleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (id)init {
    self = [super init];
    if (self != nil) {
      
        self.view = [[[NSBundle mainBundle] loadNibNamed:@"MHMiddleViewController" owner:self options:nil] objectAtIndex:0];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
