//
//  SkinView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

struct SkinView: View {
    @ObservedObject var viewModel = PreferencesViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.rosa
                    .ignoresSafeArea()
                ZStack {
                    VStack(spacing: 0) {
                        TitleBar(backgroundImage: "teste", image: "face.smiling", title: "Tipo de pele", color: .azul)
                        
                        ScrollView {
                            VStack {
                                HStack {
                                    Text("Quais possuem a pele...")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                
                                VStack(spacing: 24) {
                                    ForEach(Pele.allCases, id: \.rawValue) { p in
                                        PreferenceCard(pele: p,clientList: ClientDataSource.shared.allClients.filter({ $0.preferences.pele == p })) {
                                            RouterService.shared.showSheet(ClientSheetView(viewModel: viewModel, preferenceType: .skin, pele: p))
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
                            RouterService.shared.navigate(.service)
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
                            RouterService.shared.navigate(.smell)
                        } label: {
                            HStack {
                                Image("backButton")
                                    .resizable()
                                    .frame(width: 54, height: 56)
                                
                                Text("Cheiros")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SkinView()
}
