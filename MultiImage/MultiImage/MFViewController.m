//
//  MFViewController.m
//  MultiImage
//
//  Created by js on 8/9/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "MFViewController.h"
#import "MFMultiImageView.h"
@interface MFViewController ()

@property (nonatomic, strong) MFMultiImageView *multiImageView;
@end

@implementation MFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _multiImageView = [[MFMultiImageView alloc] init];
    _multiImageView.imagePaths = [@[@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"] mutableCopy];
    [self.view addSubview:_multiImageView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
