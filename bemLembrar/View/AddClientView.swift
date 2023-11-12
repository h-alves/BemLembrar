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
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Adicionar clientes")
                            .font(.system(size: 34))
                        
                        Text("Selecione **quais contatos são seus clientes**")
                            .font(.system(size: 16))
                    }
                    
                    Spacer()
                }
                
                if !viewModel.autoContacts.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Sugestões")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        
                        Text("Identificamos alguns contatos como clientes:")
                            .font(.system(size: 13))
                        
                        ForEach(viewModel.autoContacts, id: \.contactInfo.identifier) { phoneContact in
                            ContactCard(contact: viewModel.getBinding(contact: phoneContact), color: Color(.systemGray5)) {
                                viewModel.selectContact(contact: phoneContact)
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Todos os contatos")
                        .font(.system(size: 28))
                    
                    HStack {
                        // Barra de pesquisa
                        SearchBar(searchText: $viewModel.searchText) {
                            viewModel.updateList()
                        }
                        
                        Button {
                            viewModel.isPresented = true
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    
                    ScrollView {
                        VStack {
                            ForEach(viewModel.manualContacts, id: \.contactInfo.identifier) { phoneContact in
                                ContactCard(contact: viewModel.getBinding(contact: phoneContact), color: .white) {
                                    viewModel.selectContact(contact: phoneContact)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .padding(.bottom, 60)
                    }
                    .scrollIndicators(.hidden)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
            
            VStack {
                Spacer()
                
                Button {
                    viewModel.saveData()
                    if onboarding {
                        RouterService.shared.navigate(.preferences)
                    } else {
                        RouterService.shared.navigate(.smell)
                    }
                } label: {
                    Text("Adicionar Clientes\(viewModel.selectedContacts())")
                        .fontWeight(.bold)
                        .foregroundStyle(viewModel.disabled() ? .white : .black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.disabled() ? Color(.systemGray3) : Color(.systemGray4))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding(.top, 12)
                .padding(.horizontal, 36)
                .background(.gray)
                .disabled(viewModel.disabled())
            }
        }
    }
}

#Preview {
    AddClientView(viewModel: AddClientViewModel(), onboarding: .constant(true))
}
