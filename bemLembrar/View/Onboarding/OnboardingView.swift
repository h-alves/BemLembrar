//
//  OnboardingView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 02/11/23.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack(spacing: 48) {
            Image("onboardingTopBar")
                .resizable()
                .frame(width: 393, height: 88)
            
            VStack(spacing: 0) {
                VStack(spacing: 32) {
                    VStack(spacing: 16) {
                        Text("Informações das suas clientes sempre bem lembradas!")
                            .foregroundStyle(.preto)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        
                        Text("Monte sua lista de clientes e salve tudo sobre elas para facilitar o contato. Simples assim.")
                            .foregroundStyle(.preto)
                            .font(.body)
                    }
                    
                    BLButton(symbol: "", text: "Começar", disabled: false, opposite: false, color: .verde, textColor: .branco) {
                        RouterService.shared.navigate(.guide)
                    }
                }
                .padding(.horizontal, 32)
                
                Spacer()
                
                Image("onboardingFlower")
                    .resizable()
                    .frame(width: 393, height: 283)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(edges: .bottom)
        .background(.branco)
    }
}

#Preview {
    OnboardingView()
}
