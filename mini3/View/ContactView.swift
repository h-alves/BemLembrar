//
//  ContactView.swift
//  mini3
//
//  Created by Henrique Semmer on 30/10/23.
//

import SwiftUI
import Contacts

struct ContactView: View {
    @ObservedObject var viewModel = ContactViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Text("Sugestões")
                
                ForEach(viewModel.autoContacts, id: \.contactInfo.identifier) { phoneContact in
                    ContactSelectCard(contact: viewModel.getBinding(contact: phoneContact)) {
                        viewModel.selectContact(contact: phoneContact)
                    }
                }
                
                Text("Todos os contatos")
                
                HStack {
                    // Barra de pesquisa
                    
                    // Botão de adicionar sem ser do Contacts
                }
                
                ScrollView {
                    VStack {
                        ForEach(viewModel.manualContacts, id: \.contactInfo.identifier) { phoneContact in
                            ContactSelectCard(contact: viewModel.getBinding(contact: phoneContact)) {
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
                
                // Botão de adicionar clientes
                AddContactsButton(disabled: viewModel.disabled(), quantity: viewModel.selectedContacts()) {
                    viewModel.saveData()
                    
                    // Ir para outra tela
                }
            }
        }
        .padding(.horizontal, 24)
        .onAppear {
            viewModel.getContactList()
        }
    }
}

#Preview {
    ContactView()
}
