//
//  StringEditView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 08/11/23.
//

import SwiftUI

struct StringEditView: View {
    var title: String
    @Binding var text: String
    @Binding var isEditing: Bool
    var mainFunc: () -> Void
    
    var body: some View {
        if isEditing {
            BLTextField(text: $text)
        } else {
            
            HStack {
                Text(text)
                    .foregroundStyle(.branco)
                
                Spacer()
                
                Button {
                    mainFunc()
                } label: {
                    Image(systemName: "square.and.pencil")
                        .foregroundStyle(.branco)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(.verde)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
}

#Preview {
    StringEditView(title: "Endereço", text: .constant("Rua X"), isEditing: .constant(false)) {
        print("a")
    }
}
