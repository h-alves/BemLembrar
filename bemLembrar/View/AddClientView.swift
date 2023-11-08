//
//  AddClientView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 30/10/23.
//

import SwiftUI
import Contacts

struct AddClientView: View {
    @ObservedObject var viewModel = AddClientViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                if !viewModel.autoContacts.isEmpty {
                    Text("Sugestões")
                    
                    ForEach(viewModel.autoContacts, id: \.contactInfo.identifier) { phoneContact in
                        ContactCard(contact: viewModel.getBinding(contact: phoneContact)) {
                            viewModel.selectContact(contact: phoneContact)
                        }
                    }
                }
                
                Text("Todos os contatos")
                
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
                            ContactCard(contact: viewModel.getBinding(contact: phoneContact)) {
                                viewModel.selectContact(contact: phoneContact)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .padding(.bottom, 60)
                }
                .scrollIndicators(.hidden)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
            
            VStack {
                Spacer()
                
                Button {
                    viewModel.saveData()
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
        .onAppear {
            viewModel.getContactList()
        }
        .sheet(isPresented: $viewModel.isPresented) {
            NewContactView(viewModel: viewModel)
        }
    }
}

#Preview {
    AddClientView()
}
