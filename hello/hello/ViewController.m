//
//  ViewController.m
//  hello
//
//  Created by lijinghao on 15/9/15.
//  Copyright (c) 2015年 lijinghao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize userOutput;
@synthesize userInput;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    self.userOutput = nil;
    self.userInput = nil;
    [self setUserOutput:nil];
    [self setUserInput:nil];
    [super viewDidUnload];
}

- (IBAction)setOutput:(id)sender {
    self.userOutput.text=self.userInput.text;
}
@end
