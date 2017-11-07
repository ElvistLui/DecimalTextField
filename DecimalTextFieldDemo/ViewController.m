//
//  ViewController.m
//  DecimalTextFieldDemo
//
//  Created by Elvist on 16/10/24.
//  Copyright © 2016年 Elvist. All rights reserved.
//

#import "ViewController.h"
#import "DecimalNumHelper.h"
#import "DecimalTextFieldDemo-Swift.h"

#define kWINDOW_WIDTH   [UIScreen mainScreen].bounds.size.width
#define kTEXTFIELD_X    50

@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController
{
    UITextField *_decimalTF;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _decimalTF = [[UITextField alloc] initWithFrame:CGRectMake(kTEXTFIELD_X, 200, kWINDOW_WIDTH - kTEXTFIELD_X*2, 50)];
    _decimalTF.delegate = self;
    _decimalTF.borderStyle = UITextBorderStyleBezel;
    _decimalTF.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:_decimalTF];
}

#pragma mark - textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [DecimalNumHelper textField:textField shouldChangeCharactersInRange:range replacementString:string decimalType:DecimalTwo];
    
    // oc调用swift方法
//    return [DecimalNumHelper_Swift textField:textField shouldChangeCharactersIn:range replacementString:string decimalType:TextFieldDecimalTypeDecimalTwo];
}

#pragma mark -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_decimalTF resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
