//
//  OnboardingView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 02/11/23.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var onboarding: Bool
    
    @State var selectIndex = 0
    
    let descriptionTexts = ["Comece criando sua lista de clientes a partir dos seus contatos.", "Identifique as clientes em sua lista de contatos e registre suas preferências!", "Receba notificações sobre suas clientes para fortalecer seus laços."]
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Informações das suas clientes sempre bem lembradas!")
                    .foregroundStyle(.preto)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Text("Monte sua lista de clientes e salve tudo sobre elas para facilitar o contato. Simples assim:")
                    .foregroundStyle(.preto)
                    .font(.body)
            }
            
            Spacer()
            
            VStack(spacing: 24) {
                TabView(selection: $selectIndex) {
                    ForEach(0..<3, id: \.self) { index in
                        VStack {
                            HStack {
                                Text("\(selectIndex+1)")
                                    .foregroundStyle(.preto)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .padding()
                                    .background(.rosa)
                                    .clipShape(Circle())
                                
                                Text(descriptionTexts[selectIndex])
                                    .foregroundStyle(.preto)
                                    .font(.headline)
                                    .frame(width: 230)
                            }
                            
                            Image("onboardingImage\(selectIndex+1)")
                                .resizable()
                                .frame(width: 225, height: 225)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .padding()
                .frame(maxWidth: 329)
                .frame(maxHeight: 340)
                .background(.branco)
                .clipShape (
                    RoundedRectangle(cornerRadius: 12)
                )
                .shadow(radius: 5)
                
                HStack(alignment: .center, spacing: 4) {
                    ForEach((0..<3), id: \.self) { index in
                        if index != self.selectIndex {
                            Image(systemName: "circle")
                                .foregroundStyle(.preto)
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                        } else {
                            Image(systemName: "circle.fill")
                                .foregroundStyle(.preto)
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                        }
                    }
                }
                .animation(.default, value: selectIndex)
                .frame(maxWidth: .infinity, maxHeight: 20)
            }
            
            Spacer()
            
            if selectIndex >= 2 {
                BLButton(symbol: "", text: "Começar", disabled: false, opposite: false, color: .branco, textColor: .verde) {
                    onboarding = false
                    RouterService.shared.navigate(.allClients)
                }
            } else {
                Spacer(minLength: 39)
            }
        }
        .padding(.horizontal, 32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.rosa)
        .onChange(of: selectIndex, perform: { value in
            if selectIndex == 2 {
                NotificationManager.shared.requestPermission()
            }
        })
    }
}

#Preview {
    OnboardingView(onboarding: .constant(true))
}
