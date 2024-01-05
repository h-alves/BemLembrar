//
//  PreferencesOnboardingView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 16/11/23.
//

import SwiftUI

struct PreferencesOnboardingView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 48) {
                Image("onboardingTopBar")
                    .resizable()
                    .frame(width: 393, height: 88)
                
                ScrollView {
                    VStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 32) {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Agora só falta incluir as preferências das suas clientes!")
                                    .foregroundStyle(.preto)
                                    .font(.largeTitle.largeTitle())
                                    .fontWeight(.semibold)
                                
                                Text("Escolha suas clientes com base nas preferências delas em cada uma das categorias.")
                                    .foregroundStyle(.preto)
                                    .font(.body.body())
                            }
                            
                            BLButton(symbol: "", text: "Conheça as categorias", disabled: false, opposite: false, color: .verde, textColor: .branco) {
                                RouterService.shared.navigate(.prefGuide)
                            }
                        }
                        .padding(.horizontal, 32)
                    }
                }
                .scrollIndicators(.hidden)
                
                Spacer()
                
                if geometry.size.height > 700 {
                    Image("onboardingFlower")
                        .resizable()
                        .frame(width: 393, height: 216)
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(edges: .bottom)
            .background(.branco)
        }
    }
}

#Preview {
    PreferencesOnboardingView()
}
