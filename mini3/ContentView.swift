//
//  ContentView.swift
//  mini3
//
//  Created by Henrique Semmer on 28/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var router = RouterService.shared
    
    var body: some View {
        ZStack {
            VStack {
                switch(router.screen) {
                case .onboarding: OnboardingView()
                case .home: HomeView()
                case .allClients: AllClientsView()
                case .addClient: AddClientView()
                case .profile: ClientView()
                case .preferences: PreferencesView()
                case .smell: SmellView()
                case .skin: SkinView()
                case .service: ServiceView()
                }
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
        }
        .alert(isPresented: $router.isAlertPresented) {
            router.alert
        }
        .sheet(isPresented: $router.isSheetPresented) {
            router.sheet
        }
    }
}

#Preview {
    ContentView()
}
