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
                Button {
                    viewModel.saveData()
                } label: {
                    Text("Adicionar Clientes\(viewModel.selectedContacts())")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
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
