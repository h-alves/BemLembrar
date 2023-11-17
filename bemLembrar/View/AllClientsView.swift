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
        ZStack {
            Color.branco
                .ignoresSafeArea(edges: .top)
            
            Color.rosa
            
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 10) {
                        Button {
                            RouterService.shared.navigate(.user)
                        } label: {
                            Image("\(UserData.shared.user.image)")
                                .resizable()
                                .frame(width: 80, height: 81)
                                .overlay(alignment: .bottomTrailing) {
                                    ZStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundStyle(.branco)
                                            .font(.system(size: 25))
                                        Image(systemName: "person.circle.fill")
                                            .foregroundStyle(.verde)
                                            .font(.system(size: 25))
                                    }
                                }
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text(UserData.shared.user.name)
                                .foregroundStyle(.verdeClaro)
                                .font(.title3)
                            
                            Text("Meus clientes")
                                .foregroundStyle(.preto)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    VStack(spacing: 10) {
                        SearchBar(searchText: $viewModel.searchText) {
                            viewModel.updateList()
                        }
                        
                        VStack {
                            BLButton(symbol: "paintbrush.fill", font: .headline, text: "Preferências", disabled: viewModel.allClients.isEmpty, opposite: false, color: .verde, textColor: .branco) {
                                RouterService.shared.navigate(.smell)
                            }
                            
                            BLButton(symbol: "plus", font: .headline, text: "Adicionar", disabled: false, opposite: false, color: .verde, textColor: .branco) {
                                RouterService.shared.navigate(.addClient)
                            }
                        }
                    }
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 24)
                .background(.branco)
                .clipShape(
                    .rect (
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 32,
                        bottomTrailingRadius: 32,
                        topTrailingRadius: 0
                    )
                )
                .shadow(color: .preto.opacity(0.2), radius: 5, y: 8)
                
                VStack {
                    if viewModel.allClients.isEmpty {
                        ScrollView {
                            VStack(spacing: 32) {
                                Button {
                                    RouterService.shared.navigate(.addClient)
                                } label: {
                                    Image("noClients")
                                        .resizable()
                                        .frame(width: 390, height: 296)
                                }
                                
                                Text("Comece adicionando seus clientes!")
                                    .foregroundStyle(.preto)
                                    .font(.title3)
                                    .multilineTextAlignment(.center)
                                
                                Spacer()
                            }
                            .padding(.top, 48)
                            
                        }
                        .scrollIndicators(.hidden)
                    } else {
                        VStack(spacing: 16) {
                            HStack {
                                Spacer()
                                
                                BLButton(symbol: viewModel.isEditing ? "arrow.uturn.left" : "square.and.pencil", text: viewModel.isEditing ? "voltar" : "editar", infinity: false, disabled: false, opposite: false, color: .branco, textColor: .verde) {
                                    viewModel.editList()
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
                .background(.rosa)
            }
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
        }
    }
}

#Preview {
    AllClientsView()
}
