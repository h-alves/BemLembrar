//
//  PreferencesView.swift
//  mini3
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

struct PreferencesView: View {
    var body: some View {
        VStack {
            Button {
                RouterService.shared.navigate(.smell)
            } label: {
                Text("Onboarding das Preferências")
            }
        }
    }
}

#Preview {
    PreferencesView()
}
