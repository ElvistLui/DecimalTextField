//
//  DecimalNumHelper.h
//  DecimalTextFieldDemo
//
//  Created by Elvist on 2017/10/30.
//  Copyright © 2017年 Elvist. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UITextField;

typedef NS_ENUM(NSUInteger, DecimalType) {
    DecimalNone = 0,
    DecimalOne,
    DecimalTwo,
};

@interface DecimalNumHelper : NSObject

/**
 <#Description#>

 @param textField <#textField description#>
 @param range <#range description#>
 @param string <#string description#>
 @param type <#type description#>
 @return <#return value description#>
 */
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string decimalType:(DecimalType)type;

@end
