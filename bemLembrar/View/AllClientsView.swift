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
        VStack(spacing: 32) {
            // Top Title
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Button {
                        RouterService.shared.navigate(.user)
                    } label: {
                        Image(UserData.shared.user.image)
                            .resizable()
                            .frame(width: 80, height: 80)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(UserData.shared.user.name)
                            .foregroundStyle(.verdeClaro)
                            .font(.title3)
                        
                        Text("Meus clientes")
                            .foregroundStyle(.verde)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                }
                
                VStack(spacing: 10) {
                    SearchBar(searchText: $viewModel.searchText) {
                        viewModel.updateList()
                    }
                    
                    HStack {
                        BLButton(symbol: "plus", text: "Adicionar", infinity: false, disabled: false, opposite: false, color: .verde, textColor: .branco) {
                            RouterService.shared.navigate(.addClient)
                        }

                        BLButton(symbol: "square.and.pencil", text: "Preferências", disabled: viewModel.allClients.isEmpty, opposite: false, color: .verde, textColor: .branco) {
                            RouterService.shared.navigate(.smell)
                        }
                    }
                }
            }
            .padding(.horizontal, 32)
            
            // Clients
            VStack {
                if viewModel.allClients.isEmpty {
                    VStack(spacing: 20) {
                        Image("noClients")
                            .resizable()
                            .frame(width: 204, height: 260)
                        
                        Text("Nessa tela, ficarão todos os seus clientes, comece adicionando alguns deles!")
                            .foregroundStyle(.branco)
                            .frame(maxWidth: 280)
                            .multilineTextAlignment(.center)
                    }
                } else {
                    VStack {
                        HStack {
                            Spacer()
                            
                            Button {
                                viewModel.editList()
                            } label: {
                                HStack(spacing: 5) {
                                    if !viewModel.isEditing {
                                        Image(systemName: "square.and.pencil")
                                            .font(.system(size: 15))
                                    }
                                    
                                    Text(viewModel.isEditing ? "voltar" : "editar")
                                        .font(.headline)
                                }
                                .foregroundStyle(.branco)
                            }
                        }
                        
                        ScrollView {
                            VStack(spacing: 16) {
                                ForEach(viewModel.allClientsSearch, id: \.identifier) { client in
                                    ClientCard(client: client, isEditing: viewModel.isEditing) {
                                        RouterService.shared.navigate(.client(client: client))
                                    } deleteFunc: {
                                        viewModel.isPresented = true
                                        viewModel.client = client
                                    }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                    .padding(.horizontal, 32)
                }
            }
            .padding(.top, 32)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            .background(.verde)
            .clipShape(
                .rect (
                    topLeadingRadius: 32,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 32
                )
            )
            .ignoresSafeArea()
        }
        .background(.branco)
        .onAppear {
            viewModel.subscribe()
        }
        .onDisappear {
            viewModel.cancelSubscription()
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
        
//        VStack(spacing: 0) {
//            VStack(alignment: .leading, spacing: 10) {
//                HStack {
//                    Button {
//                        RouterService.shared.navigate(.user)
//                    } label: {
//                        Image(UserData.shared.user.image)
//                    }
//                    
//                    VStack(alignment: .leading) {
//                        Text(UserData.shared.user.name)
//                            .foregroundStyle(.verdeClaro)
//                            .font(.title3)
//                            .fontWeight(.semibold)
//                            .lineLimit(1)
//                        
//                        Text("Meus Clientes")
//                            .foregroundStyle(.verde)
//                            .font(.largeTitle)
//                            .fontWeight(.bold)
//                            .multilineTextAlignment(.leading)
//                    }
//                    
////                    Button {
////                        viewModel.editList()
////                    } label: {
////                        Image(systemName: viewModel.isEditing ? "checkmark.circle.fill" : "square.and.pencil")
////                    }
////                    .disabled(viewModel.allClients.isEmpty)
//                }
//                
//                VStack {
//                    SearchBar(searchText: $viewModel.searchText) {
//                        viewModel.updateList()
//                    }
//                    
//                    HStack {
//                        BLButton(symbol: "plus", text: "Adicionar", infinity: false, disabled: false, opposite: false, color: .verde, textColor: .branco) {
//                            RouterService.shared.navigate(.addClient)
//                        }
//                        
//                        BLButton(symbol: "square.and.pencil", text: "Preferências", disabled: viewModel.allClients.isEmpty, opposite: false, color: .verde, textColor: .branco) {
//                            RouterService.shared.navigate(.smell)
//                        }
//                    }
//                }
//                .padding(.bottom, 12)
//            }
//            .padding(.horizontal, 32)
//            .background(Color(.systemGray6))
//            
//            if viewModel.allClients.isEmpty {
//                VStack(spacing: 24) {
//                    Spacer()
//                    
//                    Image("noClients")
//                        .resizable()
//                        .frame(width: 227, height: 288)
//                    
//                    Text("Nessa tela, ficarão todos os seus clientes, comece adicionando alguns deles!")
//                        .foregroundStyle(.gray)
//                        .font(.system(size: 16))
//                        .frame(maxWidth: 219)
//                        .multilineTextAlignment(.center)
//                    
//                    Spacer()
//                }
//            } else {
//                ScrollView {
//                    VStack(spacing: 16) {
//                        ForEach(viewModel.allClients, id: \.identifier) { client in
//                            ClientCard(client: client, isEditing: viewModel.isEditing) {
//                                RouterService.shared.navigate(.client(client: client))
//                            } deleteFunc: {
//                                viewModel.isPresented = true
//                                viewModel.client = client
//                            }
//                        }
//                    }
//                    .padding(.top, 16)
//                    .padding(.horizontal, 32)
//                }
//            }
//            
//            Spacer()
//        }
    }
}

#Preview {
    AllClientsView()
}
