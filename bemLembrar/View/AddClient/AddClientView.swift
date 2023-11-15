//
//  AddClientView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 30/10/23.
//

import SwiftUI
import Contacts

struct AddClientView: View {
    @ObservedObject var viewModel: AddClientViewModel
    
    @Binding var onboarding: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    HStack {
                        Text("Adicionar clientes")
                            .foregroundStyle(.verde)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    
                    HStack(spacing: 10) {
                        SearchBar(searchText: $viewModel.searchText) {
                            viewModel.updateList()
                        }
                        
                        Button {
                            viewModel.isPresented = true
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundStyle(.verde)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 12)
                                .background(.rosa)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                    }
                }
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        
                        // Sugestões
                        if !viewModel.autoContacts.isEmpty && viewModel.searchText == "" {
                            VStack(alignment: .leading, spacing: 12) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Sugestões")
                                        .foregroundStyle(.branco)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    
                                    Text("Identificamos alguns contatos como clientes:")
                                        .foregroundStyle(.branco)
                                        .font(.body)
                                }
                                
                                ScrollView {
                                    VStack(spacing: 8) {
                                        ForEach(viewModel.autoContacts, id: \.contactInfo.identifier) { phoneContact in
                                            ContactCard(contact: viewModel.getBinding(contact: phoneContact), background: "dark", color: Color(.systemGray5)) {
                                                viewModel.selectContact(contact: phoneContact)
                                            }
                                        }
                                    }
                                    .padding(.bottom, 12)
                                }
                                .scrollIndicators(.hidden)
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 14)
                            .background(.verde)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                        
                        // Todos os contatos
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Todos os contatos")
                                .foregroundStyle(.verde)
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            if viewModel.searchText != "" {
                                VStack(spacing: 8) {
                                    ForEach(viewModel.phoneSearchContacts, id: \.contactInfo.identifier) { phoneContact in
                                        ContactCard(contact: viewModel.getBinding(contact: phoneContact), background: "light", color: .white) {
                                            viewModel.selectContact(contact: phoneContact)
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical)
                                .padding(.bottom, 60)
                            } else {
                                VStack(alignment: .leading,spacing: 16) {
                                    ForEach(Letters.shared.allLetters, id: \.description) { letter in
                                        if viewModel.hasContact(letter: letter) {
                                            VStack(alignment: .leading, spacing: 6) {
                                                Text(letter)
                                                    .foregroundStyle(.verde)
                                                    .font(.callout)
                                                    .fontWeight(.semibold)
                                                
                                                VStack(alignment: .leading, spacing: 8) {
                                                    ForEach(viewModel.listFromLetter(letter: letter), id: \.contactInfo.identifier) { contact in
                                                        ContactCard(contact: viewModel.getBinding(contact: contact), background: "light", color: .white) {
                                                            viewModel.selectContact(contact: contact)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical)
                                .padding(.bottom, 60)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 32)
            .background(.branco)
            
            VStack {
                Spacer()
                
                BLButton(symbol: "", text: "Adicionar clientes\(viewModel.selectedContacts())", disabled: viewModel.disabled(), opposite: false, color: .rosa, textColor: .verde) {
                    viewModel.saveData()
                    if onboarding {
                        RouterService.shared.navigate(.preferences)
                    } else {
                        RouterService.shared.navigate(.smell)
                    }
                }
                .padding(.top, 24)
                .padding(.horizontal, 32)
                .background(.verde)
            }
        }
    }
}

#Preview {
    AddClientView(viewModel: AddClientViewModel(), onboarding: .constant(true))
}
