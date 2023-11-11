//
//  PreferencesTag.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 06/11/23.
//

import SwiftUI

struct PreferencesTag: View {
    var big: Bool
    var preferences: Preferences
    
    var body: some View {
        FlexStack {
            if preferences.cheiro.count > 0 {
                if big {
                    ForEach(preferences.cheiro, id: \.rawValue) { c in
                        IndividualTag(texto: c.rawValue)
                    }
                } else {
                    IndividualTag(texto: preferences.cheiro[0].rawValue)
                }
            }
            IndividualTag(texto: preferences.pele.rawValue)
            IndividualTag(texto: preferences.atendimento.rawValue)
        }
    }
}

#Preview {
    VStack(alignment: .leading) {
        PreferencesTag(big: true, preferences: Preferences(cheiro: [.amadeirado, .citrico], pele: .oleosa, atendimento: .ligacao))
        
        PreferencesTag(big: false, preferences: Preferences(cheiro: [.amadeirado, .citrico], pele: .oleosa, atendimento: .ligacao))
    }
    .frame(maxWidth: 250)
}
