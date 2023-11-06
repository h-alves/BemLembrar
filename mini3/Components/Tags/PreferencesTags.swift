//
//  PreferencesTags.swift
//  mini3
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

struct PreferencesTags: View {
    var smaller: Bool
    var preferences: Preferences
    
    var body: some View {
        HStack {
            ForEach(preferences.cheiro.prefix(smaller ? 1 : preferences.cheiro.count), id: \.rawValue) { c in
                IndividualTag(texto: c.rawValue)
            }
            IndividualTag(texto: preferences.pele.rawValue)
            IndividualTag(texto: preferences.atendimento.rawValue)
        }
    }
}

#Preview {
    VStack(alignment: .leading) {
        PreferencesTags(smaller: true, preferences: Preferences(cheiro: [.amadeirado, .citrico], pele: .oleosa, atendimento: .ligacao))
        
        ScrollView(.horizontal) {
            PreferencesTags(smaller: false, preferences: Preferences(cheiro: [.amadeirado, .citrico], pele: .oleosa, atendimento: .ligacao))
        }
        .scrollIndicators(.hidden)
    }
    .frame(maxWidth: 250)
}
