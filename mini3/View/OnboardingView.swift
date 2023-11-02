//
//  OnboardingView.swift
//  mini3
//
//  Created by Henrique Semmer on 02/11/23.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        Button {
            RouterService.shared.navigate(.home)
        } label: {
            Text("Onboarding")
        }
    }
}

#Preview {
    OnboardingView()
}
