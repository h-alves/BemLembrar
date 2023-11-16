//
//  ContentView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 28/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var router = RouterService.shared
    
    @AppStorage("onboarding") private var onboarding = true
    @AppStorage("preferences") private var preferences = true
    
    var body: some View {
        ZStack {
            VStack {
                switch(router.screen) {
                case .onboarding: OnboardingView()
                case .guide: GuideView()
                case .register: RegisterView(onboarding: $onboarding)
                case .allClients: AllClientsView()
                case .addClient: AddClientManager(onboarding: $preferences)
                case .client(client: let client): ClientView(client: client)
                case .preferences: PreferencesView(onboarding: $preferences)
                case .smell: SmellView()
                case .skin: SkinView()
                case .service: ServiceView()
                case .user: UserView()
                }
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
        }
        .onAppear {
            if onboarding {
                RouterService.shared.screen = .onboarding
            }
        }
        .sheet(isPresented: $router.isSheetPresented) {
            router.sheet
        }
        .overlay {
            if router.isPopUpPresented {
                router.popUp
            }
        }
    }
}

#Preview {
    ContentView()
}
