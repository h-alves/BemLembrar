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
                VStack(spacing: 0) {
                    TitleBar(symbol: "bubble.left", title: "Atendimento")
                    
                    ScrollView {
                        VStack {
                            HStack {
                                Text("Quais preferem...")
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            
                            VStack(spacing: 24) {
                                ForEach(Atendimento.allCases, id: \.rawValue) { a in
                                    PreferenceCard(atendimento: a,clientList: viewModel.allClients.filter({ $0.preferences.atendimento == a })) {
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
                    
                    Button {
                        RouterService.shared.navigate(.allClients)
                    } label: {
                        Text("Finalizar")
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray4))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .padding(.top, 12)
                    .padding(.horizontal, 36)
                    .background(.gray)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        RouterService.shared.navigate(.skin)
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                            
                            Text("Tipos de Pele")
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
