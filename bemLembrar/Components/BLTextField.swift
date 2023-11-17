//
//  BLTextField.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 16/11/23.
//

import SwiftUI

struct BLTextField: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Seu nome", text: $text)
            .font(.headline)
            .foregroundStyle(.preto)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(text.isEmpty ? .rosa : .verde, lineWidth: 2)
            )
            .padding(.horizontal, 1)
    }
}

#Preview {
    BLTextField(text: .constant(""))
}
