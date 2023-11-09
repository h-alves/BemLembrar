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
    
    var body: some View {
        HStack {
            if isEditing {
                TextField(title, text: $text)
            } else {
                HStack(spacing: 0) {
                    Text("\(title):")
                    Text(text)
                }
            }
            
            Spacer()
        }
        .font(.system(size: 13))
    }
}

#Preview {
    StringEditView(title: "Endereço", text: .constant("Rua X"), isEditing: .constant(false))
}
