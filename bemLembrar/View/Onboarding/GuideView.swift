//
//  GuideView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 15/11/23.
//

import SwiftUI

struct GuideView: View {
    @State var selectIndex = 0
    
    let descriptionTexts = ["Comece criando sua lista de clientes a partir dos seus contatos.", "Identifique as clientes em sua lista de contatos e registre suas preferências!", "E receba notificações sobre suas clientes para fortalecer seus laços."]
    
    var body: some View {
        ZStack {
            Color.branco
                .ignoresSafeArea(edges: .top)
            
            Color.verde
                .ignoresSafeArea(edges: .bottom)
            
            VStack(spacing: 48) {
                VStack(spacing: 64) {
                    HStack(alignment: .center, spacing: 3) {
                        ForEach(0..<3, id: \.self) { index in
                            if index != self.selectIndex {
                                Image(systemName: "circle")
                                    .foregroundStyle(.verde)
                                    .font(.system(size: 10))
                                    .fontWeight(.semibold)
                            } else {
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.verde)
                                    .font(.system(size: 10))
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    .animation(.default, value: selectIndex)
                    .frame(maxWidth: .infinity, maxHeight: 20)
                    
                    TabView(selection: $selectIndex) {
                        ForEach(0..<3, id: \.self) { index in
                            VStack(spacing: 32) {
                                HStack(spacing: 16) {
                                    ZStack {
                                        Image("flowerNumber")
                                            .resizable()
                                            .frame(width: 83, height: 81)
                                        
                                        Text("0\(selectIndex+1).")
                                            .foregroundStyle(.branco)
                                            .font(.largeTitle)
                                            .fontWeight(.bold)
                                    }
                                    
                                    Text(descriptionTexts[selectIndex])
                                        .foregroundStyle(.preto)
                                        .font(.headline)
                                }
                                
                                Image("onboardingImage\(selectIndex+1)")
                                    .resizable()
                                    .frame(width: 305, height: 296)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 32)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
                .padding(.top, 24)
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
                
                if selectIndex < 2 {
                    BLButton(symbol: "arrow.right", text: "Próximo", disabled: false, opposite: true, color: .branco, textColor: .preto) {
                        withAnimation {
                            selectIndex+=1
                        }
                    }
                    .padding(.horizontal, 32)
                } else {
                    BLButton(symbol: "", text: "Criar conta", disabled: false, opposite: false, color: .branco, textColor: .preto) {
                        NotificationManager.shared.requestPermission()
                        RouterService.shared.navigate(.register)
                    }
                    .padding(.horizontal, 32)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    GuideView()
}
