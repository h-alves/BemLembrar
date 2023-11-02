//
//  AddClientView.swift
//  mini3
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
                
                Text("Sugestões")
                
                ForEach(viewModel.autoContacts, id: \.contactInfo.identifier) { phoneContact in
                    ContactCard(contact: viewModel.getBinding(contact: phoneContact)) {
                        viewModel.selectContact(contact: phoneContact)
                    }
                }
                
                Text("Todos os contatos")
                
                HStack {
                    // Barra de pesquisa
                    SearchBar(searchText: $viewModel.searchText) {
                        viewModel.updateList()
                    }
                    
                    Button {
                        print("Ir para formulário")
                        // Puxar sheet de adicionar contato sem puxar os dados do Contacts
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
                }
                .scrollIndicators(.hidden)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            VStack {
                Spacer()
                
                Button {
                    viewModel.saveData()
                } label: {
                    Text("Adicionar Clientes\(viewModel.selectedContacts())")
                        .fontWeight(.bold)
                        .foregroundStyle(viewModel.disabled() ? .black : .white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.disabled() ? .gray : .blue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .disabled(viewModel.disabled())
            }
        }
        .padding(.horizontal, 24)
        .onAppear {
            viewModel.getContactList()
        }
    }
}

#Preview {
    AddClientView()
}
