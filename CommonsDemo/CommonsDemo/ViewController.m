//
//  ViewController.m
//  TestIDFA
//
//  Created by Emck on 11/6/13.
//  Copyright (c) 2013 AppTem. All rights reserved.
//

#import "ViewController.h"

#import <CommonsSDK/CommonsSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)OnTestClick:(id)sender
{
    NSLog(@"IDFA: %@",[CommonsSDK getIDFA]);
    NSLog(@"UUID: %@",[CommonsSDK getUUID]);
}

@end