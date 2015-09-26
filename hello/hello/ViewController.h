//
//  ViewController.h
//  hello
//
//  Created by lijinghao on 15/9/15.
//  Copyright (c) 2015年 lijinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *userOutput;
@property (strong, nonatomic) IBOutlet UITextField *userInput;

- (IBAction)setOutput:(id)sender;

@end

