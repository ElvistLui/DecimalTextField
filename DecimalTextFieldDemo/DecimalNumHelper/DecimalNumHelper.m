//
//  DecimalNumHelper.m
//  DecimalTextFieldDemo
//
//  Created by Elvist on 2017/10/30.
//  Copyright © 2017年 Elvist. All rights reserved.
//

#import "DecimalNumHelper.h"
#import <UIKit/UIKit.h>

@implementation DecimalNumHelper

+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string decimalType:(DecimalType)type
{
    NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    // 1：resultString只能包含数字和"."字符，或者为空
    // 2：第一位为0时，第二位只能为"."字符
    // 3："."字符最多只能同时存在一个，如果在第一位时则自动补0
    // 4：根据type判断是否存在"."字符，以及"."字符后的小数位数
    if (!resultString.length) {
        
        return YES;
    }
    
    // 方案一："."前补0
    BOOL (^isCompletion)() = ^(){
        
        BOOL result = [string isEqualToString:@"."] && range.location == 0;
        return result;
    };
    
    if (isCompletion()) {
    
        resultString = [textField.text stringByReplacingCharactersInRange:range withString:@"0."];
    }
    
    NSString *numRegex = @"^(0|[1-9][0-9]*)$";
    
    switch (type) {
        case DecimalNone:
            
            break;
        case DecimalOne:
            
            numRegex = @"^[0-9]+(.[0-9]{0,1})?$";
            break;
            
        case DecimalTwo:
            
            numRegex = @"^[0-9]+(.[0-9]{0,2})?$";
            break;
            
        default:
            break;
    }
    
    NSPredicate *numPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numRegex];
    BOOL result = [numPredicate evaluateWithObject:resultString];

    if (result &&
        isCompletion()) {
        
        textField.text = resultString;
        return NO;
    }
    
    return result;
    
    // 方案二：只判断输入是否合法
    /*
    NSString *numRegex = @"^(0|[1-9][0-9]*)$";
    
    switch (type) {
        case DecimalNone:
            
            break;
        case DecimalOne:
            
            numRegex = @"^[0-9]+(.[0-9]{0,1})?$";
            break;
        case DecimalTwo:
            
            numRegex = @"^[0-9]+(.[0-9]{0,2})?$";
            break;
            
        default:
            break;
    }
    
    NSPredicate *numPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numRegex];
    return [numPredicate evaluateWithObject:resultString];
    */
}

@end
