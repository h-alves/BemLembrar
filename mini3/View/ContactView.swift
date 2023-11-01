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
            
            Button {
                viewModel.saveData()
            } label: {
                Text("Salvar")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
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
