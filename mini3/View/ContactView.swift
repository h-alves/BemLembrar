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
        ForEach(viewModel.phoneContacts, id: \.contactInfo.identifier) { contact in
            Text(contact.contactInfo.givenName)
        }
        .onAppear {
            viewModel.getContactList()
        }
    }
}

#Preview {
    ContactView()
}
