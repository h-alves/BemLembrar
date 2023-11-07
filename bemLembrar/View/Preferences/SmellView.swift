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
        ZStack {
            VStack(spacing: 0) {
                TitleBar(symbol: "nose", title: "Cheiros")
                
                ScrollView {
                    VStack {
                        HStack {
                            Text("Quais gostam de cheiro...")
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack(spacing: 24) {
                            ForEach(Cheiro.allCases, id: \.rawValue) { c in
                                PreferenceCard(cheiro: c,clientList: viewModel.allClients.filter({ $0.preferences.cheiro.contains(c) })) {
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
                
                Button {
                    RouterService.shared.navigate(.skin)
                } label: {
                    Text("Próximo")
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
    }
}

#Preview {
    SmellView()
}
