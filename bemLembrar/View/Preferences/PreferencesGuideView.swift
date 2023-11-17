//
//  PreferencesGuideView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

struct PreferencesGuideView: View {
    let titleTexts = ["Fragrâncias", "Tipo de pele", "Atendimento"]
    let descriptionTexts = ["Guarde as preferências das suas clientes para fazer recomendações personalizadas com os aromas que elas mais gostam.", "Registre se sua cliente tem pele seca, oleosa ou mista, para identificar produtos adequados para o tipo de pele dela.", "Cada pessoa prefere um tipo específico de atendimento. Registre a melhor forma de entrar em contato com cada cliente!"]
    let colors: [Color] = [.laranja, .azul, .rosaEscuro]
    
    @State var selectIndex = 0
    
    @Binding var onboarding: Bool
    
    var body: some View {
        ZStack {
            Color.branco
                .ignoresSafeArea(edges: .top)
            
            colors[selectIndex]
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
                                Image("preferencesImage\(selectIndex+1)")
                                    .resizable()
                                    .frame(width: 280, height: 280)
                                
                                VStack(spacing: 12) {
                                    Text(titleTexts[selectIndex])
                                        .foregroundStyle(colors[selectIndex])
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    
                                    Text(descriptionTexts[selectIndex])
                                        .foregroundStyle(.preto)
                                        .font(.body)
                                        .multilineTextAlignment(.center)
                                }
                                .padding(.horizontal, 32)
                                
                                Spacer()
                            }
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
                .shadow(color: .preto.opacity(0.2), radius: 5, y: 8)
                
                if selectIndex < 2 {
                    BLButton(symbol: "arrow.right", text: "Próximo", disabled: false, opposite: true, color: .branco, textColor: .verde) {
                        withAnimation {
                            selectIndex+=1
                        }
                    }
                    .padding(.horizontal, 32)
                } else {
                    BLButton(symbol: "", text: "Preencher preferências", disabled: false, opposite: false, color: .branco, textColor: .verde) {
                        onboarding = false
                        RouterService.shared.navigate(.smell)
                    }
                    .padding(.horizontal, 32)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    PreferencesGuideView(onboarding: .constant(true))
}
