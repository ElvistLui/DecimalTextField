### 限制文本框输入正确的价格数字
在UITextFieldDelegate中使用正则表达式判断编辑后的结果是否合法，并返回YES or NO。

使用了Objective-C以及Swift4两种方式来实现。


*Objective-C：

```
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

```

*Swift4

```
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
```
