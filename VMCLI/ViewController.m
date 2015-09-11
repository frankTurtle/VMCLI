//
//  ViewController.m
//  VMCLI
//
//  Created by OSX on 9/11/15.
//  Copyright © 2015 LebonTech Solutions. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.doseTextField.delegate = self;
    self.weightTextField.delegate = self;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel"
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(doneWithNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                         target:nil
                                                                         action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone
                                                           target:self
                                                           action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    
    self.doseTextField.inputAccessoryView = numberToolbar;
    self.weightTextField.inputAccessoryView = numberToolbar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetButtonPressed:(id)sender {
}

- (IBAction)calculateButtonPressed:(id)sender {
}

#pragma mark - UITextFieldDelegate Methods
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)doneWithNumberPad
{
    [self.doseTextField resignFirstResponder];
    [self.weightTextField resignFirstResponder];
}
@end
