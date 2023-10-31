//
//  ContactView.swift
//  mini3
//
//  Created by Henrique Semmer on 30/10/23.
//

import SwiftUI

struct ContactView: View {
    @ObservedObject var viewModel = ContactViewModel()
    
    var body: some View {
        ForEach(viewModel.phoneContacts, id: \.contactInfo.identifier) { phoneContact in
            ContactSelectCard(contact: viewModel.getBinding(contact: phoneContact)) {
                print("a")
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
