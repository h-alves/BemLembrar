//
//  ClientView.swift
//  mini3
//
//  Created by Henrique Semmer on 02/11/23.
//

import SwiftUI

struct ClientView: View {
    var body: some View {
        VStack {
            Circle()
                .frame(maxWidth: 200, maxHeight: 200)
                .foregroundColor(.gray)
                .padding(.top, 32)
            
            Text("Nome da cliente")
                .font(.system(size: 34))
            
            Button(action: {
                        // Coloque a ação que você deseja executar quando o botão for pressionado aqui
                        print("Botão pressionado!")
                    }) {
                        Text("Entrar em contato")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .padding()
                    }
                    .frame(maxWidth: 298, maxHeight: 46)
                    .background(Color.black)
                    .cornerRadius(10)
        }
        .padding(.bottom, 12)
        
        VStack(alignment: .leading) {
            
            Text("Preferências:")
                .font(.system(size: 17))
                .bold()
            
            Text("Lembre-se do que sua cliente mais gosta!")
                .font(.system(size: 13))
            
            HStack {
                
                Rectangle()
                    .frame(maxWidth: 57, maxHeight: 18)
                    .cornerRadius(8)
                    .overlay(
                        Text("base 07")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                    )
                
                Rectangle()
                    .frame(maxWidth: 57, maxHeight: 18)
                    .cornerRadius(8)
                    .overlay(
                        Text("doce")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                    )
                
                Rectangle()
                    .frame(maxWidth: 57, maxHeight: 18)
                    .cornerRadius(8)
                    .overlay(
                        Text("ligação")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                    )
                
                Rectangle()
                    .frame(maxWidth: 57, maxHeight: 18)
                    .cornerRadius(8)
                    .overlay(
                        Text("pele oleosa")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                    )
                
            }
        }
        .frame(width: 330, height: 99)
        .background(Color(.systemGray5))
        .cornerRadius(12)
        .padding(0)
        .padding(.bottom, 12)
        
        VStack(alignment: .leading) {
            
            Text("Anotações:")
                .font(.system(size: 17))
                .bold()
                .padding(.horizontal, 12)
            
            Text("Aqui você pode registrar alergias, tanana e \ndetalhes para garantir sempre o melhor atendimento!")
                .font(.system(size: 13))
                .padding(.horizontal, 12)
            
            // Verificar o espaçamento dentro do VStack (retangulo)
            
        }
        .frame(width: 330, height: 109)
        .background(Color(.systemGray5))
        .cornerRadius(12)
        
        Spacer()
        
    }
}

#Preview {
    ClientView()
}
