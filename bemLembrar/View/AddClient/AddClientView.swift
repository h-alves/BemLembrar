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
            Color.branco
                .ignoresSafeArea(edges: .top)
            
            Color.verde
                .ignoresSafeArea(edges: .bottom)
            
            VStack(spacing: 24) {
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(spacing: 16) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Adicione seus contatos à sua lista de clientes")
                                    .foregroundStyle(.preto)
                                    .font(.title.title())
                                    .fontWeight(.bold)
                                
                                Text("Identifique quem são os seus clientes e os selecione para adicioná-los")
                                    .foregroundStyle(.preto)
                                    .font(.body.body())
                            }
                            
                            HStack(spacing: 12) {
                                SearchBar(searchText: $viewModel.searchText) {
                                    viewModel.updateList()
                                }
                                
                                Button {
                                    viewModel.isPresented = true
                                } label: {
                                    Image(systemName: "plus")
                                        .foregroundStyle(.branco)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 14)
                                        .background(.verde)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                }
                            }
                        }
                        
                        ScrollView {
                            VStack(spacing: 24) {
                                
                                // Sugestões
                                if !viewModel.autoContacts.isEmpty && viewModel.searchText == "" {
                                    VStack(alignment: .leading, spacing: 12) {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("Sugestões")
                                                .foregroundStyle(.branco)
                                                .font(.title3.title3())
                                                .fontWeight(.semibold)
                                            
                                            Text("Identificamos alguns contatos como clientes: ")
                                                .foregroundStyle(.branco)
                                                .font(.body.body())
                                        }
                                        
                                        VStack(spacing: 8) {
                                            ForEach(viewModel.autoContacts, id: \.contactInfo.identifier) { phoneContact in
                                                ContactCard(contact: viewModel.getBinding(contact: phoneContact), background: "dark", color: Color(.systemGray5)) {
                                                    viewModel.selectContact(contact: phoneContact)
                                                }
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 14)
                                    .background(.verde)
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                                }
                                
                                // Todos os contatos
                                if !viewModel.manualContacts.isEmpty {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Todos os contatos")
                                            .foregroundStyle(.verde)
                                            .font(.title2.title2())
                                            .fontWeight(.semibold)
                                        
                                        VStack(spacing: 12) {
                                            if viewModel.searchText == "" {
                                                ForEach(Letters.shared.allLetters, id: \.description) { letter in
                                                    if viewModel.hasContact(letter: letter) {
                                                        VStack(alignment: .leading, spacing: 4) {
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
                                            } else {
                                                ForEach(viewModel.phoneSearchContacts, id: \.contactInfo) {contact in
                                                    ContactCard(contact: viewModel.getBinding(contact: contact), background: "light", color: .white) {
                                                        viewModel.selectContact(contact: contact)
                                                    }
                                                }
                                            }
                                        }
                                        .padding(.bottom, 14)
                                    }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                    .padding(.horizontal, 32)
                }
                .padding(.top, 24)
                .background(.branco)
                .clipShape(
                    .rect (
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 32,
                        bottomTrailingRadius: 32,
                        topTrailingRadius: 0
                    )
                )
                .shadow(color: .pretoShadow.opacity(0.2), radius: 5, y: 8)
                
                BLButton(symbol: "", text: "Adicionar clientes\(viewModel.selectedContacts())", disabled: viewModel.disabled(), opposite: false, color: .branco, textColor: .verde) {
                    viewModel.saveData()
                    if onboarding {
                        RouterService.shared.navigate(.prefOnboarding)
                    } else {
                        RouterService.shared.navigate(.smell)
                    }
                }
                .padding(.horizontal, 32)
                
                Spacer()
            }
        }

    }
}

#Preview {
    AddClientView(viewModel: AddClientViewModel(), onboarding: .constant(true))
}
