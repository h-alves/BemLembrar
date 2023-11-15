//
//  PopUp.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 09/11/23.
//

import SwiftUI

struct PopUp: View {
    var title: String
    var bodyText: String
    var buttonText: String
    var secondaryText: String
    
    var mainFunc: () -> Void
    var secondaryFunc: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.gray)
                .opacity(0.6)
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 6) {
                    Text(title)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(bodyText)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                HStack(spacing: 0) {
                    Button {
                        secondaryFunc()
                    } label: {
                        Text(secondaryText)
                            .foregroundStyle(.black)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.lightGray))
                    
                    Button {
                        mainFunc()
                    } label: {
                        Text(buttonText)
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.red)
                }
                .fontWeight(.bold)
            }
            .background()
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    PopUp(title: "Deletar Cliente?", bodyText: "Esse cliente será permanentemente deletado da sua lista de clientes.", buttonText: "Deletar", secondaryText: "Cancelar") {
        print("a")
    } secondaryFunc: {
        print("b")
    }
}
