//
//  ExperimentVC.m
//  MHScheduleTimeLine
//
//  Created by Melaniia Hulianovych on 11/21/16.
//  Copyright © 2016 Melaniia Hulianovych. All rights reserved.
//

#import "ExperimentVC.h"

@interface ExperimentVC ()
- (IBAction)returnHome:(id)sender;

@end

@implementation ExperimentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)returnHome:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
//    [self.navigationController popToRootViewControllerAnimated:YES];

}
@end
