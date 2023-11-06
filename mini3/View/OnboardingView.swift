//
//  OnboardingView.swift
//  mini3
//
//  Created by Henrique Semmer on 02/11/23.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        
        VStack {
            
            VStack(alignment: .leading) {
                
                Text("Agora só faltam as preferências das suas clientes!")
                    .foregroundStyle(.white)
                    .font(.system(size: 32))
                    .bold()
                    .padding(.bottom, 12)
                
                Text("Selecione suas clientes de acordo com \nas preferências delas nos seguintes \ntópicos:")
                    .foregroundStyle(.white)
                    .font(.system(size: 16))
                    .padding(.bottom, 35)
            }
            
            VStack {
                
                HStack {
                    
                    Image(systemName: "nose")
                        .foregroundStyle(.white)
                        .font(.system(size: 40))
                    
                    VStack(alignment: .leading) {
                        
                        Text("Cheiros")
                            .foregroundStyle(.white)
                            .font(.system(size: 24))
                            .bold()
                        
                        Text("Salve os gostos da suas clientes \npara os cheiros dos produtos \nque você indica e vende.")
                            .font(.system(size: 16))
                            .foregroundStyle(.white)
                    }
                }
                .padding(.bottom, 28)
                
                HStack {
                    
                    Image(systemName: "face.smiling")
                        .font(.system(size: 40))
                        .foregroundStyle(.white)
                    
                    VStack(alignment: .leading) {
                        
                        Text("Tipo de pele")
                            .foregroundStyle(.white)
                            .font(.system(size: 24))
                            .bold()
                        
                        Text("Salve para sempre lembrar qual \né o tipo de pele da sua cliente: \nnormal, seca, oleosa ou mista.")
                            .font(.system(size: 16))
                            .foregroundStyle(.white)
                    }
                }
                .padding(.bottom, 28)
                
                HStack {
                    
                    Image(systemName: "bubble.left")
                        .font(.system(size: 40))
                        .foregroundStyle(.white)
                    
                    VStack(alignment: .leading) {
                        
                        Text("Atendimento")
                            .foregroundStyle(.white)
                            .font(.system(size: 24))
                            .bold()
                        
                        Text("Cada pessoa prefere um tipo de \natendimento, salve qual é o \nmelhor jeito de entrar em \ncontato com a sua cliente.")
                            .font(.system(size: 16))
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding(.bottom, 71)
            
            Button {
                RouterService.shared.navigate(.home)
            } label: {
                Text("Selecionar preferências")
                    .font(.system(size: 16))
                    .foregroundStyle(.black)
                    .padding()
            }
            .frame(maxWidth: 298, maxHeight: 46)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("FundoOnboarding"))
        
    }
}

#Preview {
    OnboardingView()
}
