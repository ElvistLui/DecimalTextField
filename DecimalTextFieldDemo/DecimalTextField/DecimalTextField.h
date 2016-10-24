//
//  DecimalTextField.h
//  DecimalTextFieldDemo
//
//  Created by Elvist on 16/10/24.
//  Copyright © 2016年 Elvist. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TextFiedDecimalType) {
    TextFiedDecimalNone = 0,    // 禁止输入小数点
    TextFiedDecimalOne,         // 限制小数点后输入一位
    TextFiedDecimalTwo,         // 限制小数点后输入两位
};

@interface DecimalTextField : UITextField

@property (nonatomic, assign) TextFiedDecimalType decimals;  // 小数点后位数，默认为限制小数点后输入两位

@end
