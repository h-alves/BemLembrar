//
//  AddClientManager.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 09/11/23.
//

import SwiftUI

struct AddClientManager: View {
    @ObservedObject var viewModel = AddClientViewModel()
    
    var body: some View {
        NavigationStack {
            if viewModel.denied {
                RejectedView()
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                RouterService.shared.navigate(.allClients)
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 17))
                                    .fontWeight(.bold)
                            }
                        }
                    }
            } else {
                AddClientView(viewModel: viewModel)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                RouterService.shared.navigate(.allClients)
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 17))
                                    .fontWeight(.bold)
                            }
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            viewModel.getContactList()
        }
        .sheet(isPresented: $viewModel.isPresented) {
            NewContactView(viewModel: viewModel)
        }
    }
}

#Preview {
    AddClientManager()
}
