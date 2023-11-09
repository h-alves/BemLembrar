//
//  RouterService.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 01/11/23.
//

import SwiftUI

class RouterService: ObservableObject {
    
    static var shared = RouterService()
    
    @Published var screen: Screen = .allClients
    
    @Published var isSheetPresented: Bool = false
    
    @Published var sheet: AnyView = AnyView(Text("Sheet"))
    
    func showSheet(_ sheet: some View) {
        self.sheet = AnyView(sheet)
        isSheetPresented = true
    }
    
    func hideSheet() {
        isSheetPresented = false
    }
    
    func navigate(_ screen: Screen) {
        self.screen = screen
    }
}
