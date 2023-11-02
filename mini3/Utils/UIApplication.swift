//
//  UIApplication.swift
//  mini3
//
//  Created by Henrique Semmer on 02/11/23.
//

import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
