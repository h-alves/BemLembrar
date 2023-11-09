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
                
                Spacer()
                
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
                
                HStack {
                    SearchBar(searchText: $viewModel.searchText) {
                        viewModel.updateList()
                    }
                    
                    Button(action: {
                        RouterService.shared.navigate(.addClient)
                    }) {
                        Text("+ Adicionar")
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .padding(12)
                            .background(Color(.systemGray2))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .frame(width: 116, height: 42)
                }
                .padding(.bottom, 21)
            }
            .frame(height: 140)
            .padding(.horizontal, 32)
            .background(Color(.systemGray6))
            
            if viewModel.allClients.isEmpty {
                VStack(spacing: 24) {
                    Spacer()
                    
                    Circle()
                        .frame(width: 142)
                    Text("Você ainda não adicionou nenhum cliente :(")
                        .font(.system(size: 16))
                        .frame(maxWidth: 192)
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
                PopUp(title: "Teste", bodyText: "teste", buttonText: "Botão 1", secondaryText: "botão 2") {
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
