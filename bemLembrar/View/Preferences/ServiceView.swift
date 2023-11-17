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
                Color.rosa
                    .ignoresSafeArea()
                ZStack {
                    VStack(spacing: 0) {
                        TitleBar(backgroundImage: "teste", image: "bubble.left", title: "Atendimento", color: .rosaEscuro)
                        
                        ScrollView {
                            VStack {
                                HStack {
                                    Text("Quais preferem...")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                
                                VStack(spacing: 24) {
                                    ForEach(Atendimento.allCases, id: \.rawValue) { a in
                                        PreferenceCard(atendimento: a,clientList: ClientDataSource.shared.allClients.filter({ $0.preferences.atendimento == a })) {
                                            RouterService.shared.showSheet(ClientSheetView(viewModel: viewModel, preferenceType: .service, atendimento: a))
                                        }
                                    }
                                }
                            }
                            .padding(.top, 24)
                            .padding(.horizontal, 36)
                            .padding(.bottom, 98)
                        }
                        .scrollIndicators(.hidden)
                    }
                    
                    VStack {
                        Spacer()
                        
                        BLButton(symbol: "arrow.forward", text: "Próximo", disabled: false, opposite: true, color: .branco, textColor: .verde) {
                            RouterService.shared.navigate(.allClients)
                        }
                        .padding(.top, 12)
                        .padding(.horizontal, 36)
                        .background(.verde)
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
                            RouterService.shared.navigate(.skin)
                        } label: {
                            HStack {
                                Image("backButton")
                                    .resizable()
                                    .frame(width: 54, height: 56)
                                
                                Text("Tipos de Pele")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ServiceView()
}
