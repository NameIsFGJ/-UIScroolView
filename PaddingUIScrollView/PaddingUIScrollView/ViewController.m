//
//  ViewController.m
//  PaddingUIScrollView
//
//  Created by 冯高杰 on 2020/10/29.
//

#import "ViewController.h"
#import "RollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RollView *rollView = [[RollView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200) withDistanceForScroll:60 withGap:10];
    [rollView rollView:@[@"image00",@"image01",@"image02"]];
    [self.view addSubview:rollView];
    
}


@end
