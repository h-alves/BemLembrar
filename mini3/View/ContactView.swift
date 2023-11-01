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
            ForEach(viewModel.phoneContacts, id: \.contactInfo.identifier) { phoneContact in
                ContactSelectCard(contact: viewModel.getBinding(contact: phoneContact)) {
                    viewModel.selectContact(contact: phoneContact)
                }
            }
        }
        .onAppear {
            viewModel.getContactList()
        }
    }
}

#Preview {
    ContactView()
}
