//
//  ContentView.swift
//  bemLembrar
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
                case .allClients: AllClientsView()
                case .addClient: AddClientView()
                case .client(client: let client): ClientView(client: client)
                case .preferences: PreferencesView()
                case .smell: SmellView()
                case .skin: SkinView()
                case .service: ServiceView()
                }
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
        }
        .sheet(isPresented: $router.isSheetPresented) {
            router.sheet
        }
    }
}

#Preview {
    ContentView()
}
