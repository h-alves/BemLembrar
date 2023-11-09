//
//  OnboardingView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 02/11/23.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack {
            Button {
                RouterService.shared.navigate(.allClients)
            } label: {
                Text("Onboarding")
            }
        }
    }
}

#Preview {
    OnboardingView()
}
