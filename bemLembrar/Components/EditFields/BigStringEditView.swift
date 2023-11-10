//
//  BigStringEditView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 09/11/23.
//

import SwiftUI

struct BigStringEditView: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            if isEditing {
                TextField("", text: $text, axis: .vertical)
            } else {
                Text(text == "" ? "Aqui você pode registrar alergias, tanana e \ndetalhes para garantir sempre o melhor atendimento!" : text)
                    .font(.system(size: 13))
            }
            
            Spacer()
        }
        .font(.system(size: 13))
    }
}

#Preview {
    BigStringEditView(text: .constant("teste"), isEditing: .constant(true))
}
