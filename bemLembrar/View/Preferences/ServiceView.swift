//
//  ServiceView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

struct ServiceView: View {
    @ObservedObject var viewModel = PreferencesViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.branco
                    .ignoresSafeArea(edges: .top)
                
                Color.rosaEscuro
                    .ignoresSafeArea(edges: .bottom)
                
                VStack(spacing: 24) {
                    VStack(spacing: 0) {
                        Image("serviceImage")
                            .resizable()
                            .frame(width: 393, height: 183)
                            .clipShape(
                                .rect (
                                    topLeadingRadius: 24,
                                    bottomLeadingRadius: 0,
                                    bottomTrailingRadius: 0,
                                    topTrailingRadius: 24
                                )
                            )
                        
                        VStack(alignment: .leading, spacing: 24) {
                            ScrollView {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Atendimento")
                                        .foregroundStyle(.rosaEscuro)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Text("Selecione suas clientes de acordo com a preferência")
                                        .foregroundStyle(.preto)
                                        .font(.body)
                                }
                                .padding(.top, 24)
                                
                                Divider()
                                
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Quais gostam de cheiro...")
                                        .foregroundStyle(.preto)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    
                                    VStack(spacing: 16) {
                                        ForEach(Atendimento.allCases, id: \.rawValue) { a in
                                            PreferenceCard(atendimento: a,clientList: ClientDataSource.shared.allClients.filter({ $0.preferences.atendimento == a })) {
                                                RouterService.shared.showSheet(ClientSheetView(viewModel: viewModel, preferenceType: .service, atendimento: a))
                                            }
                                            .padding(.horizontal, 1)
                                        }
                                    }
                                }
                                .padding(.bottom, 24)
                            }
                            .scrollIndicators(.hidden)
                        }
                        .padding(.horizontal, 32)
                    }
                    .background(.branco)
                    .clipShape(
                        .rect (
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 32,
                            bottomTrailingRadius: 32,
                            topTrailingRadius: 0
                        )
                    )
                    .shadow(color: .pretoShadow.opacity(0.2), radius: 5, y: 8)
                    
                    BLButton(symbol: "arrow.right", text: "Próximo", disabled: false, opposite: true, color: .branco, textColor: .verde) {
                        RouterService.shared.navigate(.allClients)
                    }
                    .padding(.horizontal, 32)
                    
                    Spacer()
                }
            }
            .onAppear {
                viewModel.subscribe()
            }
            .onDisappear {
                viewModel.cancelSubscription()
            }
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
        
//        NavigationStack {
//            ZStack {
//                Color.rosa
//                    .ignoresSafeArea()
//                ZStack {
//                    VStack(spacing: 0) {
//                        TitleBar(backgroundImage: "teste", image: "bubble.left", title: "Atendimento", color: .rosaEscuro)
//                        
//                        ScrollView {
//                            VStack {
//                                HStack {
//                                    Text("Quais preferem...")
//                                        .font(.title3)
//                                        .fontWeight(.semibold)
//                                    
//                                    Spacer()
//                                }
//                                .frame(maxWidth: .infinity)
//                                
//                                VStack(spacing: 24) {
//                                    ForEach(Atendimento.allCases, id: \.rawValue) { a in
//                                        PreferenceCard(atendimento: a,clientList: ClientDataSource.shared.allClients.filter({ $0.preferences.atendimento == a })) {
//                                            RouterService.shared.showSheet(ClientSheetView(viewModel: viewModel, preferenceType: .service, atendimento: a))
//                                        }
//                                    }
//                                }
//                            }
//                            .padding(.top, 24)
//                            .padding(.horizontal, 36)
//                            .padding(.bottom, 98)
//                        }
//                        .scrollIndicators(.hidden)
//                    }
//                    
//                    VStack {
//                        Spacer()
//                        
//                        BLButton(symbol: "arrow.forward", text: "Próximo", disabled: false, opposite: true, color: .branco, textColor: .verde) {
//                            RouterService.shared.navigate(.allClients)
//                        }
//                        .padding(.top, 12)
//                        .padding(.horizontal, 36)
//                        .background(.verde)
//                    }
//                }
//                .onAppear {
//                    viewModel.subscribe()
//                }
//                .onDisappear {
//                    viewModel.cancelSubscription()
//                }
//                .toolbar {
//                    ToolbarItem(placement: .topBarLeading) {
//                        Button {
//                            RouterService.shared.navigate(.skin)
//                        } label: {
//                            HStack {
//                                Image("backButton")
//                                    .resizable()
//                                    .frame(width: 54, height: 56)
//                                
//                                Text("Tipos de Pele")
//                            }
//                        }
//                    }
//                }
//            }
//        }
    }
}

#Preview {
    ServiceView()
}
