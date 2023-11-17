//
//  NewContactView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 07/11/23.
//

import SwiftUI

struct NewContactView: View {
    @ObservedObject var viewModel: AddClientViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 24) {
                RoundedRectangle(cornerRadius: 32)
                    .foregroundStyle(.rosa)
                    .frame(width: 55, height: 4)
                
                VStack(alignment: .leading, spacing: 24) {
                    Text("Novo contato")
                        .foregroundStyle(.verde)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    VStack(spacing: 32) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Dados Essenciais")
                                .foregroundStyle(.verde)
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            BLTextField(placeholderText: "Nome", text: $viewModel.givenName)
                            
                            BLTextField(placeholderText: "Sobrenome", text: $viewModel.familyName)
                            
                            BLTextField(placeholderText: "Telefone", text: $viewModel.number)
                        }
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 12) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Dados Opcionais")
                                    .foregroundStyle(.verde)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                BLDatePicker(date: $viewModel.birthday)
                            }
                            
                            Text("Endereço")
                                .foregroundStyle(.verde)
                                .font(.headline)
                            
                            VStack(spacing: 8) {
                                BLTextField(placeholderText: "Rua", text: $viewModel.street)
                                
                                BLTextField(placeholderText: "Cidade", text: $viewModel.city)
                                
                                BLTextField(placeholderText: "Estado", text: $viewModel.state)
                            }
                        }
                    }
                }
                .padding(.horizontal, 32)
            }
            
            Spacer()
            
            BLButton(symbol: "checkmark", text: "Concluir", disabled: viewModel.givenName == "" || viewModel.number == "", opposite: viewModel.givenName != "" && viewModel.number != "", color: .verde, textColor: .branco) {
                viewModel.addContact()
                viewModel.isPresented = false
            }
            .padding(.horizontal, 32)
        }
        .padding(.top, 12)
        .background(.branco)
    }
}

#Preview {
    NewContactView(viewModel: AddClientViewModel())
}
