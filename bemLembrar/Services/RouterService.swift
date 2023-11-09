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
    @Published var isPopUpPresented: Bool = false
    
    @Published var sheet: AnyView = AnyView(Text("Sheet"))
    @Published var popUp: PopUp = PopUp(title: "", bodyText: "", buttonText: "", secondaryText: "", mainFunc: {}, secondaryFunc: {})
    
    func showSheet(_ sheet: some View) {
        self.sheet = AnyView(sheet)
        isSheetPresented = true
    }
    
    func hideSheet() {
        isSheetPresented = false
    }
    
    func showPopUp(_ popUp: PopUp) {
        self.popUp = popUp
        isPopUpPresented = true
    }
    
    func hidePopUp() {
        isPopUpPresented = false
    }
    
    func navigate(_ screen: Screen) {
        self.screen = screen
    }
}
