//
//  StringExtension.swift
//  Safir El3rood
//
//  Created by mohamed elmaazy on 7/26/18.
//  Copyright © 2018 Internet Plus. All rights reserved.
//

import Foundation

extension String {
    
    func isNumber() -> Bool {
        let numberCharacters = NSCharacterSet.decimalDigits.inverted
        return !self.isEmpty && self.rangeOfCharacter(from: numberCharacters) == nil
    }
    
    var withoutHtmlTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options:
            .regularExpression, range: nil).replacingOccurrences(of: "&[^;]+;", with:
                "", options:.regularExpression, range: nil).replacingOccurrences(of: "\r\n", with:
                    "", options:.regularExpression, range: nil)
    }
    
    func isEgyptianMobileNumber() -> Bool {
        return self.count == 11 && self.prefix(2) == "01" ? true : false
    }
    
    var localize: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}


