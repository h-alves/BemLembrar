//
//  SmellView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

struct SmellView: View {
    @ObservedObject var viewModel = PreferencesViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.branco
                    .ignoresSafeArea(edges: .top)
                
                Color.laranja
                    .ignoresSafeArea(edges: .bottom)
                
                VStack(spacing: 24) {
                    VStack(spacing: 0) {
                        Image("smellImage")
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
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Fragrâncias")
                                            .foregroundStyle(.laranja)
                                            .font(.title)
                                            .fontWeight(.bold)
                                        
                                        Text("Selecione suas clientes de acordo com a preferência")
                                            .foregroundStyle(.preto)
                                            .font(.body)
                                    }
                                    .padding(.top, 24)
                                    
                                    Spacer()
                                }
                                
                                Divider()
                                
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Quais gostam de cheiro...")
                                        .foregroundStyle(.preto)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    
                                    VStack(spacing: 16) {
                                        ForEach(Cheiro.allCases, id: \.rawValue) { c in
                                            PreferenceCard(cheiro: c,clientList: ClientDataSource.shared.allClients.filter({ $0.preferences.cheiro.contains(c) })) {
                                                RouterService.shared.showSheet(ClientSheet(viewModel: viewModel, preferenceType: .smell, cheiro: c))
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
                        RouterService.shared.navigate(.skin)
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
    }
}

#Preview {
    SmellView()
}
