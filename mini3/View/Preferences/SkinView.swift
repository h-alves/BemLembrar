//
//  SkinView.swift
//  mini3
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

struct SkinView: View {
    @ObservedObject var viewModel = PreferencesViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                TitleBar(symbol: "face.smiling", title: "Tipo de pele")
                
                ScrollView {
                    VStack {
                        HStack {
                            Text("Quais possuem a pele...")
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack(spacing: 24) {
                            ForEach(Pele.allCases, id: \.rawValue) { p in
                                PreferenceCard(pele: p,clientList: viewModel.allClients.filter({ $0.preferences.pele == p })) {
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
                
                Button {
                    RouterService.shared.navigate(.service)
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
    SkinView()
}
