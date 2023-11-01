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
            ScrollView {
                VStack {
                    Text("Sugestões")
                    
                    ForEach(viewModel.autoContacts, id: \.contactInfo.identifier) { phoneContact in
                        ContactSelectCard(contact: viewModel.getBinding(contact: phoneContact)) {
                            viewModel.selectContact(contact: phoneContact)
                        }
                    }
                    
                    Text("Todos os contatos")
                    
                    ForEach(viewModel.manualContacts, id: \.contactInfo.identifier) { phoneContact in
                        ContactSelectCard(contact: viewModel.getBinding(contact: phoneContact)) {
                            viewModel.selectContact(contact: phoneContact)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .scrollIndicators(.hidden)
            
            VStack {
                Spacer()
                
                // Botão de adicionar clientes
                AddContactsButton(quantity: viewModel.selectedContacts()) {
                    viewModel.saveData()
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
