//
//  ContactHandlerView.swift
//  mini3
//
//  Created by Henrique Semmer on 01/11/23.
//

import SwiftUI

struct ContactHandlerView: View {
    @ObservedObject var viewModel = ContactViewModel()
    
    var body: some View {
        VStack {
            if !viewModel.autoContacts.isEmpty {
                AutomaticContactView(viewModel: viewModel)
            } else {
                ManualContactView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.getContactList()
        }
    }
}

#Preview {
    ContactHandlerView()
}
