//
//  RouterService.swift
//  mini3
//
//  Created by Henrique Semmer on 01/11/23.
//

import Foundation

class RouterService: ObservableObject {
    static var shared = RouterService()
    
    @Published var screen: Screen = .initial
    
    
}
