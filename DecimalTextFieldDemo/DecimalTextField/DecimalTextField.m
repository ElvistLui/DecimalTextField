//
//  DecimalTextField.m
//  DecimalTextFieldDemo
//
//  Created by Elvist on 16/10/24.
//  Copyright © 2016年 Elvist. All rights reserved.
//

#import "DecimalTextField.h"

// 代理人
@interface DecimalTextFieldDelegate : NSObject<UITextFieldDelegate>

@property (nonatomic, assign) TextFiedDecimalType decimals;  // 小数点后位数，默认为限制小数点后输入两位

@end

@implementation DecimalTextFieldDelegate

#pragma mark - textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 不能输入空格
    if ([string isEqualToString:@" "]) {
        
        return NO;
    }
    // 禁止输入小数点时，或者为第一位时，不能输入小数点，
    if ((self.decimals == TextFiedDecimalNone ||
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
        if (flag == self.decimals) {
            
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

@end

// 委托人
@interface DecimalTextField ()

@property (nonatomic, strong) DecimalTextFieldDelegate *decimalDelegate;

@end

@implementation DecimalTextField

// 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self.decimalDelegate;
    }
    return self;
}

// 重写setter方法
- (void)setDecimals:(TextFiedDecimalType)decimals
{
    _decimals = decimals;
    self.decimalDelegate.decimals = decimals;
}

// 懒加载代理人
- (DecimalTextFieldDelegate *)decimalDelegate
{
    if (!_decimalDelegate) {
        
        _decimalDelegate = [[DecimalTextFieldDelegate alloc] init];
        _decimalDelegate.decimals = TextFiedDecimalTwo;
    }
    return _decimalDelegate;
}

// 禁止执行部分动作
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))    //禁止粘贴
        return NO;
    if (action == @selector(select:))   // 禁止选择
        return NO;
    if (action == @selector(selectAll:))// 禁止全选
        return NO;
    
    return [super canPerformAction:action withSender:sender];
}

@end
