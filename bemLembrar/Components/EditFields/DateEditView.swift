//
//  DateEditView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 09/11/23.
//

import SwiftUI

struct DateEditView: View {
    var title: String
    var name: String = ""
    @Binding var date: Date
    @Binding var isEditing: Bool
    var mainFunc: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            if isEditing {
                HStack {
                    BLDatePicker(placeholderText: "Aniversário", date: $date)
                    
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
                    if date.formatted(date: .numeric, time: .omitted) == Date().formatted(date: .numeric, time: .omitted) {
                        HStack {
                            Text("Adicione o aniversário de \(name)")
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
                            Text("\(date.formatText())")
                                .foregroundStyle(.branco)
                                .font(.body)
                            
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
        .font(.system(size: 13))
    }
}

#Preview {
    DateEditView(title: "teste", date: .constant(Date.distantPast), isEditing: .constant(false)) {
        print("a")
    }
}
