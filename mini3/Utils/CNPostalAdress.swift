//
//  CNPostalAdress.swift
//  mini3
//
//  Created by Henrique Semmer on 06/11/23.
//

import Foundation
import Contacts

extension CNPostalAddress {
    func formatAddress() -> String {
        var address = self.street
        address += " - " + self.city + ", " + self.state
        
        return address
    }
}
