//
//  DoubleExtension.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 9/28/16.
//  Copyright © 2016 Dennis Pashkov. All rights reserved.
//

public class DoubleExtension: NSObject {
    
    //MARK: - Public -
    //MARK: Methods
    
    public static func convert(doubleToString doubleNumber: Double, withNumberOfDigitsAfterComma numberOfDigitsAfterComma: Swift.UInt) -> String {
        
        var numberString: String = doubleNumber.description
        
        var dotLocation: Int64 = Int64((numberString as NSString).range(of: StringExtension.dotSymbol).location)
        
        if numberOfDigitsAfterComma == 0 && dotLocation == -1 {
            
            return numberString
        }
        else if numberOfDigitsAfterComma == 0 && dotLocation != -1 {
            
            if dotLocation + 1 == numberString.Length {
                
                return numberString.Substring(loc: 0, len: dotLocation)
            }
            
            let nextDigitAfterComma = (numberString.Substring(loc: dotLocation + StringExtension.dotSymbol.Length, len: 1) as NSString).longLongValue
            if nextDigitAfterComma > 4 {
                
                let number = (numberString.Substring(loc: 0, len: dotLocation) as NSString).longLongValue
                let replacementString = (number + 1).description
                
                numberString = StringExtension.replace(numberString, startIndex: 0, length: dotLocation, string: replacementString)!
            }
            
            return numberString.Substring(loc: 0, len: dotLocation)
        }
        
        if dotLocation == -1 {
            
            numberString += StringExtension.dotSymbol
            dotLocation = numberString.Length - StringExtension.dotSymbol.Length
        }
        
        let currentNumberOfDigitsAfterComma = numberString.Length - dotLocation - StringExtension.dotSymbol.Length
        if currentNumberOfDigitsAfterComma < Int64(numberOfDigitsAfterComma) {
            
            for _ in currentNumberOfDigitsAfterComma...(Int64(numberOfDigitsAfterComma) - 1) {
                
                numberString += "0"
            }
        }
        else if currentNumberOfDigitsAfterComma > Int64(numberOfDigitsAfterComma) {
            
            let nextDigit = (numberString.Substring(loc: dotLocation + Int64(numberOfDigitsAfterComma) + StringExtension.dotSymbol.Length, len: 1) as NSString).longLongValue
            if nextDigit > 4 {
                
                let allDigitsAfterDotString = numberString.Substring(dotLocation + StringExtension.dotSymbol.Length)
                let allDigitsAfterDot = (allDigitsAfterDotString as NSString).longLongValue
                
                var afterDotReplacementString: String = (allDigitsAfterDot + 1).description
                if afterDotReplacementString.Length > allDigitsAfterDotString.Length {
                    
                    let decimalPart = (numberString.Substring(loc: 0, len: dotLocation) as NSString).longLongValue + 1
                    numberString = StringExtension.replace(numberString, startIndex: 0, length: dotLocation, string: decimalPart.description)!
                    dotLocation = Int64((numberString as NSString).range(of: StringExtension.dotSymbol).location)
                    
                    afterDotReplacementString = ""
                    for _ in 0...(numberOfDigitsAfterComma - 1) {
                        
                        afterDotReplacementString += "0"
                    }
                }
                
                numberString = StringExtension.replace(numberString, startIndex: dotLocation + StringExtension.dotSymbol.Length, length: numberString.Length - dotLocation - StringExtension.dotSymbol.Length, string: afterDotReplacementString)!
            }
            
            numberString = numberString.Substring(loc: 0, len: dotLocation + StringExtension.dotSymbol.Length + Int64(numberOfDigitsAfterComma))
        }
        
        return numberString
    }	   
}
