//
//  AddClientManager.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 09/11/23.
//

import SwiftUI

struct AddClientManager: View {
    @ObservedObject var viewModel = AddClientViewModel()
    
    @Binding var onboarding: Bool
    
    var body: some View {
        NavigationStack {
            if viewModel.denied {
                RejectedView()
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                RouterService.shared.navigate(.allClients)
                            } label: {
                                Image("backButton")
                                    .resizable()
                                    .frame(width: 54, height: 56)
                            }
                        }
                    }
            } else {
                AddClientView(viewModel: viewModel, onboarding: $onboarding)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                RouterService.shared.navigate(.allClients)
                            } label: {
                                Image("backButton")
                                    .resizable()
                                    .frame(width: 54, height: 56)
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
    AddClientManager(onboarding: .constant(true))
}
