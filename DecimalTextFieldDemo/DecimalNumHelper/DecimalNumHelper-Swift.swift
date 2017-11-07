//
//  DecimalNumHelper-Swift.swift
//  DecimalTextFieldDemo
//
//  Created by Elvist on 2017/10/30.
//  Copyright © 2017年 Elvist. All rights reserved.
//

import UIKit

/**
 * swift的自定义方法在oc中调用时，前面必须加@objc
 * swift的enum在oc中调用时，需要定义为Int格式
 */
@objc enum TextFieldDecimalType: Int {
    case DecimalNone
    case DecimalOne
    case DecimalTwo
}

class DecimalNumHelper_Swift: NSObject,UITextFieldDelegate {

    /// 处理输入的字符
    ///
    /// - Parameters:
    ///   - textField: 第一响应者
    ///   - range: 字符输入的位置
    ///   - string: 输入的字符
    ///   - type: 小数点类型后数字位数
    /// - Returns: 输入的字符是否符合要求
    @objc class func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, decimalType type: TextFieldDecimalType) -> Bool {
        
        var resuleString: String = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if resuleString.count == 0 {
            
            return true
        }
        
        // 方案一："."前补0
        
        let Completion = { () -> Bool in
            
            let result: Bool = string.elementsEqual(".") && range.location == 0
            return result
        }
        
        if Completion() {
            
            resuleString = (textField.text! as NSString).replacingCharacters(in: range, with: "0.")
        }
        
        var numRegex = "^(0|[1-9][0-9]*)$"
        
        switch type {
        case TextFieldDecimalType.DecimalNone: break
            
        case TextFieldDecimalType.DecimalOne:
            numRegex = "^[0-9]+(.[0-9]{0,1})?$"
            
        case TextFieldDecimalType.DecimalTwo:
            numRegex = "^[0-9]+(.[0-9]{0,2})?$"
            
        default: break
        }

        let numPredicate = NSPredicate.init(format: "SELF MATCHES %@", numRegex)
        let result = numPredicate.evaluate(with:resuleString)
        
        if result && Completion() {
            
            textField.text = resuleString
            return false
        }
        
        return result
        
        
        // 方案二：只判断输入是否合法
        /*
        var numRegex = "^(0|[1-9][0-9]*)$"
        
        switch type {
        case TextFieldDecimalType.DecimalNone: break
            
        case TextFieldDecimalType.DecimalOne:
            numRegex = "^[0-9]+(.[0-9]{0,1})?$"
            
        case TextFieldDecimalType.DecimalTwo:
            numRegex = "^[0-9]+(.[0-9]{0,2})?$"
            
        default: break
        }
        
        let numPredicate = NSPredicate.init(format: "SELF MATCHES %@", numRegex)
        return numPredicate.evaluate(with:resuleString)
         */
    }
}
