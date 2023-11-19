//
//  RejectedView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 09/11/23.
//

import SwiftUI

struct RejectedView: View {
    var body: some View {
        ZStack {
            Color.branco
                .ignoresSafeArea(edges: .top)
            
            Color.verde
                .ignoresSafeArea(edges: .bottom)
            
            VStack(spacing: 24) {
                VStack(spacing: 0) {
                    ScrollView {
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 24) {
                            Text("Precisamos ver seus contatos!")
                                .foregroundStyle(.preto)
                                .font(.largeTitle.largeTitle())
                                .fontWeight(.bold)
                            
                            Text("Não se preocupe, não vamos divulgar seus dados! Apenas precisamos dos contatos para facilitar o gerenciamento de clientes!")
                                .foregroundStyle(.preto)
                                .font(.body.body())
                        }
                        .padding(.horizontal, 32)
                        
                        Image("rejectedImage")
                            .resizable()
                            .frame(width: 393, height: 391)
                        
                        Spacer()
                    }
                }
                .padding(.top, 24)
                .padding(.bottom, 32)
                .frame(maxWidth: .infinity)
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
                
                BLButton(symbol: "", text: "Permitir acesso aos contatos", disabled: false, opposite: false, color: .branco, textColor: .preto) {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
                .padding(.horizontal, 32)
                
                Spacer()
            }
        }
    }
}

#Preview {
    RejectedView()
}
