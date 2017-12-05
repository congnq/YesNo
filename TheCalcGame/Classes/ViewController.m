//
//  ViewController.m
//  TheCalcGame
//
//  Created by Neo on 7/12/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize scoreLabel;
@synthesize equationLabel;
@synthesize progressView;
@synthesize startBtn;

- (IBAction)pressStartBtn:(id)sender {
	[mediator startGame];
}

- (IBAction)pressTrueBtn:(id)sender {
	[mediator handlePressTrueBtn];
}

- (IBAction)pressFalseBtn:(id)sender {
	[mediator handlePressFalseBtn];
}

- (void)viewDidLoad {
	mediator = [Mediator getInstance];
	mediator.viewCtrl = self;
	
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
