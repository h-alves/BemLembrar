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
                Color.rosa
                    .ignoresSafeArea()
                ZStack {
                    VStack(spacing: 0) {
                        TitleBar(backgroundImage: "teste", image: "nose", title: "Fragrâncias", color: .laranja)
                        
                        ScrollView {
                            VStack {
                                HStack {
                                    Text("Quais gostam de cheiro...")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                
                                VStack(spacing: 24) {
                                    ForEach(Cheiro.allCases, id: \.rawValue) { c in
                                        PreferenceCard(cheiro: c,clientList: ClientDataSource.shared.allClients.filter({ $0.preferences.cheiro.contains(c) })) {
                                            RouterService.shared.showSheet(ClientSheetView(viewModel: viewModel, preferenceType: .smell, cheiro: c))
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
                            RouterService.shared.navigate(.skin)
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
}

#Preview {
    SmellView()
}
