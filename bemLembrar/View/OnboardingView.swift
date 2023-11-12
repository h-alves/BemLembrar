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
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Informações das suas clientes sempre bem lembradas!")
                    .foregroundStyle(.white)
                    .font(.system(size: 32))
                    .fontWeight(.semibold)
                
                Text("Monte sua lista de clientes e salve tudo sobre elas para facilitar o contato. Simples assim:")
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
                        Image("preferenceImage\(selectIndex+1)")
                            .resizable()
                            .frame(width: 241, height: 241)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 400)
            }
            
            Spacer()
            
            if selectIndex >= 2 {
                Button {
                    onboarding = false
                    RouterService.shared.navigate(.allClients)
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
