//
//  PreferencesTagsBig.swift
//  mini3
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

struct PreferencesTagsSmall: View {
    var preferences: Preferences
    
    var body: some View {
        HStack {
            if preferences.cheiro.count > 0 {
                IndividualTag(texto: preferences.cheiro[0].rawValue)
            }
            IndividualTag(texto: preferences.pele.rawValue)
            IndividualTag(texto: preferences.atendimento.rawValue)
        }
    }
}

#Preview {
    VStack(alignment: .leading) {
        PreferencesTagsSmall(preferences: Preferences(cheiro: [.amadeirado, .citrico], pele: .oleosa, atendimento: .ligacao))
    }
    .frame(maxWidth: 250)
}
