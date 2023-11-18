//
//  StringEditView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 08/11/23.
//

import SwiftUI

struct StringEditView: View {
    var title: String
    var placeholderText: String
    var name: String = ""
    @Binding var text: String
    @Binding var isEditing: Bool
    var mainFunc: () -> Void
    
    var body: some View {
        if isEditing {
            HStack {
                BLTextField(placeholderText: placeholderText, text: $text)
                
                Spacer()
                
                Button {
                    mainFunc()
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.verde)
                        .font(.system(size: 38))
                }
            }
        } else {
            Button {
                mainFunc()
            } label: {
                if text == "" {
                    HStack {
                        Text("Adicione o endereço de \(name)")
                            .foregroundStyle(.verde)
                            .font(.body.body())
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        Image(systemName: "plus")
                            .foregroundStyle(.verde)
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(.verdeClaro, lineWidth: 2)
                    )
                    .padding(.horizontal, 1)
                } else {
                    HStack {
                        Text(text)
                            .foregroundStyle(.branco)
                            .font(.body.body())
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        Image(systemName: "square.and.pencil")
                            .foregroundStyle(.branco)
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(.verde)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(.verde, lineWidth: 2)
                    )
                    .padding(.horizontal, 1)
                }
            }
        }
    }
}

#Preview {
    VStack {
        StringEditView(title: "Endereço", placeholderText: "teste", text: .constant("teste"), isEditing: .constant(true)) {
            print("a")
        }
        
        DateEditView(title: "teste", date: .constant(Date.distantPast), isEditing: .constant(false)) {
            print("b")
        }
    }
}
