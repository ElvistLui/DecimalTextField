//
//  ViewController.m
//  DecimalTextFieldDemo
//
//  Created by Elvist on 16/10/24.
//  Copyright © 2016年 Elvist. All rights reserved.
//

#import "ViewController.h"
#import "DecimalTextField.h"

static NSInteger const decimals = 2;    // 小数点后位数

@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) DecimalTextField *textField;
@property (nonatomic, strong) DecimalTextField *decimalTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 设置控制器为delegate
    self.textField = [[DecimalTextField alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    self.textField.delegate = self;
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:self.textField];
    
    // 不设置delegate
    self.decimalTF = [[DecimalTextField alloc] initWithFrame:CGRectMake(50, 200, 200, 50)];
    self.decimalTF.borderStyle = UITextBorderStyleBezel;
    self.decimalTF.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:self.decimalTF];
}

#pragma mark - textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 不能输入空格
    if ([string isEqualToString:@" "]) {
        
        return NO;
    }
    // 禁止输入小数点时，或者为第一位时，不能输入小数点，
    if ((decimals == TextFiedDecimalNone ||
         textField.text.length == 0) &&
        [string isEqualToString:@"."]) {
        
        return NO;
    }
    // 第一位是'0'时，第二位只能是小数点
    if ([textField.text isEqualToString:@"0"] &&
        ![string isEqualToString:@"."]) {
        
        return NO;
    }
    
    NSRange pointRange = [textField.text rangeOfString:@"."];
    if (pointRange.location != NSNotFound) {
        
        // 已输入小数点, 禁止再输入小数点
        if ([string isEqualToString:@"."]) {
            
            return NO;
        }
        
        // 小数点后位数
        NSUInteger flag = textField.text.length - (pointRange.location + pointRange.length);
        if (flag == decimals) {
            
            // 小数点后有两位，禁止再输入任何字符
            if (![string isEqualToString:@""]) {
                
                return NO;
            }
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField.text.length > 1 &&
        [[textField.text substringToIndex:1] isEqualToString:@"0"]) {
        
        if ([[textField.text substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"0"]) {
            
            // 如果第一位第二位都是'0'，直接将文本框置为'0'
            textField.text = @"0";
        } else {
            
            // 如果第一位是'0'，在结束编辑时移除'0'
            textField.text = [textField.text substringFromIndex:1];
        }
    }
    
    NSRange pointRange = [textField.text rangeOfString:@"."];
    if (pointRange.location != NSNotFound) {
        
        if (pointRange.location == textField.text.length - 1) {
            
            // 如果最后一位是小数点，在结束编辑时移除小数点
            textField.text = [textField.text substringToIndex:textField.text.length - 1];
        } else if (pointRange.location == 0) {
            
            // 如果第一位是小数点，在结束编辑时在第一位加上0
            textField.text = [@"0" stringByAppendingString:textField.text];
        }
        
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
