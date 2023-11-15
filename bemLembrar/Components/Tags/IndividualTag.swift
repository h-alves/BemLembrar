//
//  IndividualTag.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

struct IndividualTag: View {
    var texto: String
    var type: PreferenceType
    
    var body: some View {
        if !texto.isEmpty {
            Text(texto)
                .foregroundStyle(.branco)
                .font(.callout)
                .fontWeight(.bold)
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .background(backgroundColor())
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
    
    func backgroundColor() -> Color {
        switch type {
        case .smell:
            return .laranja
        case .skin:
            return .azul
        case .service:
            return .rosaEscuro
        }
    }
}

#Preview {
    IndividualTag(texto: "teste", type: .smell)
}
