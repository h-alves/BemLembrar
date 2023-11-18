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
    var mainFunc: () -> Void
    
    var body: some View {
        HStack {
            if isEditing {
                HStack {
                    TextField("", text: $text, axis: .vertical)
                        .font(.headline)
                        .foregroundStyle(.preto)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(text.isEmpty ? .rosa : .verde, lineWidth: 2)
                        )
                        .padding(.horizontal, 1)
                    
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
                            Text("Aqui você pode registrar alergias, cores preferidas e detalhes para garantir sempre o melhor atendimento!")
                                .foregroundStyle(.verde)
                                .font(.body)
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
                            Text(text == "" ? "Aqui você pode registrar alergias, tanana e detalhes para garantir sempre o melhor atendimento!" : text)
                                .foregroundStyle(.branco)
                                .font(.body)
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
}

#Preview {
    BigStringEditView(text: .constant(""), isEditing: .constant(false)) {
        print("a")
    }
}
