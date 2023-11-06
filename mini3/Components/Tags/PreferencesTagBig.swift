//
//  PreferencesTagSmall.swift
//  mini3
//
//  Created by Henrique Semmer on 06/11/23.
//

import SwiftUI

struct PreferencesTagsBig: View {
    var preferences: Preferences
    
    var body: some View {
        FlexStack {
            ForEach(preferences.cheiro, id: \.rawValue) { c in
                IndividualTag(texto: c.rawValue)
            }
            IndividualTag(texto: preferences.pele.rawValue)
            IndividualTag(texto: preferences.atendimento.rawValue)
        }
    }
}

#Preview {
    VStack(alignment: .leading) {
        PreferencesTagsBig(preferences: Preferences(cheiro: [.amadeirado, .citrico], pele: .oleosa, atendimento: .ligacao))
    }
    .frame(maxWidth: 250)
}
