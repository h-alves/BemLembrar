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
                        IndividualTag(texto: c.rawValue, big: big, type: .smell)
                    }
                } else {
                    IndividualTag(texto: preferences.cheiro[0].rawValue, type: .smell)
                }
            }
            IndividualTag(texto: preferences.pele.rawValue, big: big, type: .skin)
            IndividualTag(texto: preferences.atendimento.rawValue, big: big, type: .service)
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
