//
//  ViewController.h
//  VMCLI
//
//  Created by OSX on 9/11/15.
//  Copyright © 2015 LebonTech Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *weightTextField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *speciesSegmentedController;
@property (strong, nonatomic) IBOutlet UITextField *doseTextField;
@property (strong, nonatomic) IBOutlet UILabel *bsaLabel;
@property (strong, nonatomic) IBOutlet UILabel *doseLabel;

- (IBAction)segmentedControllerChanged:(id)sender;
- (IBAction)resetButtonPressed:(id)sender;
- (IBAction)calculateButtonPressed:(id)sender;
@end

