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
            ForEach(preferences.cheiro.prefix(smaller ? 3 : preferences.cheiro.count), id: \.rawValue) { c in
                IndividualTag(texto: c.rawValue)
            }
            ForEach(preferences.pele.prefix(smaller ? 3 - maxValue(n: preferences.cheiro.count) : preferences.pele.count), id: \.rawValue) { p in
                IndividualTag(texto: p.rawValue)
            }
            ForEach(preferences.atendimento.prefix(smaller ? 3 - maxValue(n: preferences.cheiro.count + preferences.pele.count) : preferences.atendimento.count), id: \.rawValue) { a in
                IndividualTag(texto: a.rawValue)
            }
        }
    }
    
    func maxValue(n: Int) -> Int {
        if n > 3 {
            return 3
        }
        return n
    }
}

#Preview {
    VStack(alignment: .leading) {
        PreferencesTags(smaller: true, preferences: Preferences(cheiro: [.amadeirado, .citrico], pele: [.oleosa, .mista, .seca], atendimento: [.mensagem, .ligacao, .presencial]))
        
        ScrollView(.horizontal) {
            PreferencesTags(smaller: false, preferences: Preferences(cheiro: [.amadeirado, .citrico], pele: [.oleosa, .mista, .seca], atendimento: [.mensagem, .ligacao, .presencial]))
        }
        .scrollIndicators(.hidden)
    }
    .frame(maxWidth: 250)
}
