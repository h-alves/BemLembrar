//
//  AllClientsView.swift
//  bemLembrar
//
//  Created by Gabriel Bruno Meira on 01/11/23.
//

import SwiftUI

struct AllClientsView: View {
    @ObservedObject var viewModel = AllClientsViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment:.leading) {
                HStack {
                    Text("Meus Clientes")
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Button {
                        viewModel.editList()
                    } label: {
                        Image(systemName: viewModel.isEditing ? "checkmark.circle.fill" : "square.and.pencil")
                    }
                    .disabled(viewModel.allClients.isEmpty)
                }
                
                VStack {
                    SearchBar(searchText: $viewModel.searchText) {
                        viewModel.updateList()
                    }
                    
                    HStack {
                        Button(action: {
                            RouterService.shared.navigate(.addClient)
                        }) {
                            HStack {
                                Image(systemName: "plus")
                                
                                Text("Adicionar")
                            }
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(12)
                            .background(.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        
                        Button(action: {
                            RouterService.shared.navigate(.smell)
                        }) {
                            HStack {
                                Image(systemName: viewModel.allClients.isEmpty ? "lock.fill" : "square.and.pencil")
                                
                                Text("Preferências")
                            }
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(12)
                            .background(viewModel.allClients.isEmpty ? Color(.systemGray4) : .gray)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .disabled(viewModel.allClients.isEmpty)
                    }
                }
                .padding(.bottom, 12)
            }
            .padding(.horizontal, 32)
            .background(Color(.systemGray6))
            
            if viewModel.allClients.isEmpty {
                VStack(spacing: 24) {
                    Spacer()
                    
                    Image("noClients")
                        .resizable()
                        .frame(width: 227, height: 288)
                    
                    Text("Nessa tela, ficarão todos os seus clientes, comece adicionando alguns deles!")
                        .foregroundStyle(.gray)
                        .font(.system(size: 16))
                        .frame(maxWidth: 219)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
            } else {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.allClients, id: \.contactInfo.identifier) { client in
                            ClientCard(client: client, isEditing: viewModel.isEditing) {
                                RouterService.shared.navigate(.client(client: client))
                            } deleteFunc: {
                                viewModel.isPresented = true
                                viewModel.client = client
                            }
                        }
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 32)
                }
            }
            
            Spacer()
        }
        .onAppear {
            viewModel.updateList()
        }
        .overlay {
            if viewModel.isPresented {
                PopUp(title: "Deletar Cliente?", bodyText: "Esse cliente será permanentemente deletado da sua lista de clientes.", buttonText: "Deletar", secondaryText: "Cancelar") {
                    viewModel.delete()
                    viewModel.isPresented = false
                } secondaryFunc: {
                    viewModel.isPresented = false
                }
            }
        }
    }
}

#Preview {
    AllClientsView()
}
