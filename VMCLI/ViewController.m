//
//  ViewController.m
//  VMCLI
//
//  Created by OSX on 9/11/15.
//  Copyright © 2015 LebonTech Solutions. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong,nonatomic) NSString *tempInfo;
@end

@implementation ViewController

AVAudioPlayer *avSound;

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
    
    self.bsaLabel.text = [NSString stringWithFormat:@"0.00 m%@", @"\u00b2"];
    self.doseLabel.text = @"0.00 mg";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentedControllerPressed:(UISegmentedControl *)sender
{
    NSString *dogPath = [[NSBundle mainBundle] pathForResource:@"woof"
                                                        ofType:@"mp3"];
    NSURL *dogSoundURL = [NSURL fileURLWithPath:dogPath];

    NSString *catPath = [[NSBundle mainBundle] pathForResource:@"meow"
                                                        ofType:@"mp3"];
    NSURL *catSoundURL = [NSURL fileURLWithPath:catPath];
    
    SystemSoundID audioEffect;
    
    if (self.speciesSegmentedController.selectedSegmentIndex == 0)
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) dogSoundURL, &audioEffect);
    else
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) catSoundURL, &audioEffect);
    
    AudioServicesPlaySystemSound(audioEffect);
}

- (IBAction)resetButtonPressed:(id)sender
{
    self.weightTextField.text = @"";
    self.doseTextField.text = @"";
    
    self.bsaLabel.text = [NSString stringWithFormat:@"m%@", @"\u00b2"];
    self.doseLabel.text = @"mg";
}

- (IBAction)calculateButtonPressed:(id)sender
{
    if ([self.weightTextField.text length] == 0 || [self.doseTextField.text length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Fill in all values"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        float weight = [self.weightTextField.text floatValue];
        float exponent = 2./3;
        
        if (self.speciesSegmentedController.selectedSegmentIndex == 0)
        {
            NSLog(@"%f", exponent);
            
            self.bsaLabel.text = [NSString stringWithFormat:@"%0.3f m%@", ( (10.1 * powf(weight, exponent)) / 100.0 ), @"\u00b2"];
            self.doseLabel.text = [NSString stringWithFormat:@"%0.3f mg", ([self.bsaLabel.text floatValue] * [self.doseTextField.text floatValue])];
        }
        else if (self.speciesSegmentedController.selectedSegmentIndex == 1)
        {
            self.bsaLabel.text = [NSString stringWithFormat:@"%0.3f m%@", ( (10.0 * powf(weight, exponent)) / 100.0 ), @"\u00b2"];
            self.doseLabel.text = [NSString stringWithFormat:@"%0.3f mg", ([self.bsaLabel.text floatValue] * [self.doseTextField.text floatValue])];
        }
    }
}

#pragma mark - UITextFieldDelegate Methods
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
   if(textField.tag == 0) //.... means its the weight
       self.tempInfo = self.weightTextField.text;
    else
        self.tempInfo = self.doseTextField.text;
}

-(void)doneWithNumberPad
{
    [self.doseTextField resignFirstResponder];
    [self.weightTextField resignFirstResponder];
}
@end
