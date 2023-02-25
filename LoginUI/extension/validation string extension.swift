//
//  validation string extension.swift
//  LoginUI
//
//  Created by Apple on 05/11/1944 Saka.
//

import Foundation
extension String{
    
    func validateEmailID() -> Bool{
        var emailRegex = "[A-Z0-9a-z,%.+-]+@[A-Za-z0-9,-]+\\.[A-Za-z]{2,4}"
        return applyPredicateOnRegex(regexStr: emailRegex)
    }
    
    func validatePassword() -> Bool {
        var passRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
                
        return applyPredicateOnRegex(regexStr: passRegex)
    }
    
    func applyPredicateOnRegex(regexStr: String) -> Bool{
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", regexStr)
    
        let isValidOtherString = validateOtherString.evaluate(with: trimmedString)
    
        return isValidOtherString
    }
}
