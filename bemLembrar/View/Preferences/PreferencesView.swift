//
//  PreferencesView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

struct PreferencesView: View {
    let titleTexts = ["Fragrâncias", "Tipo de pele", "Atendimento"]
    let descriptionTexts = ["Guarde as preferências das suas clientes para fazer recomendações personalizadas com os aromas que elas mais gostam", "Registre para nunca mais esquecer o tipo de pele da sua cliente: normal, seca, oleosa ou mista.", "Cada pessoa prefere um tipo específico de atendimento. Registre a melhor forma de entrar em contato com cada cliente!"]
    
    @State var selectIndex = 0
    
    @Binding var onboarding: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Agora só falta incluir as preferências das suas clientes!")
                    .foregroundStyle(.white)
                    .font(.system(size: 32))
                    .fontWeight(.semibold)
                
                Text("Escolha suas clientes com base nas preferências delas nos seguintes tópicos:")
                    .foregroundStyle(.white)
                    .font(.system(size: 16))
            }
            
            Spacer()
            
            VStack {
                HStack(alignment: .center, spacing: 12) {
                    ForEach((0..<3), id: \.self) { index in
                        if index > self.selectIndex {
                            Circle()
                                .stroke(lineWidth: 2)
                                .foregroundColor(.white)
                                .frame(width: 16, height: 16)
                        } else {
                            Circle()
                                .fill(.white)
                                .frame(width: 16, height: 16)
                        }
                    }
                }
                .animation(.default, value: selectIndex)
                .frame(maxWidth: .infinity, maxHeight: 20)
                
                TabView(selection: $selectIndex) {
                    ForEach(0..<3, id: \.self) { index in
                        VStack {
                            Image("preferenceImage\(selectIndex+1)")
                                .resizable()
                                .frame(width: 241, height: 241)
                                .clipShape(Circle())
                            
                            VStack(spacing: 12) {
                                Text("\(titleTexts[selectIndex])")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                
                                Text("\(descriptionTexts[selectIndex])")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14))
                                    .multilineTextAlignment(.center)
                                    .frame(maxHeight: 58)
                            }
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 400)
            }
            
            Spacer()
            
            if selectIndex >= 2 {
                Button {
                    onboarding = false
                    RouterService.shared.navigate(.smell)
                } label: {
                    Text("Continuar")
                        .foregroundStyle(.black)
                        .fontWeight(.bold)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background()
                .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                Spacer(minLength: 55)
            }
        }
        .padding(.horizontal, 36)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.darkGray))
    }
}

#Preview {
    PreferencesView(onboarding: .constant(true))
}
