//
//  CNPostalAdress.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 06/11/23.
//

import Foundation
import Contacts

extension CNPostalAddress {
    
    func formatAddress() -> String {
        var address = self.street
        
        if self.street != "" && (self.city != "" || self.state != "") {
            address += " - "
        }
        
        if self.city != "" {
            address += self.city
            if self.state != "" {
                address += ", "
            }
        }
        if self.state != "" {
            address += self.state
        }
        
        return address
    }
}
