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
                .foregroundStyle(.preto)
                .opacity(0.3)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Você tem certeza que quer excluir essa cliente?")
                        .foregroundStyle(.verde)
                        .font(.title.title())
                        .fontWeight(.bold)
                    
                    Text("Continuar resultará na perda dos dados da cliente. Ao adicioná-la novamente, será necessário recriar todas as preferências e informações.")
                        .foregroundStyle(.preto)
                        .font(.body.body())
                }
                
                VStack {
                    Button {
                        mainFunc()
                    } label: {
                        Text(buttonText)
                            .foregroundStyle(.verde)
                            .font(.headline.headline())
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .overlay {
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(.verde, lineWidth: 2)
                            }
                    }
                    
                    Button {
                        secondaryFunc()
                    } label: {
                        Text(secondaryText)
                            .foregroundStyle(.branco)
                            .font(.headline.headline())
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(.verde)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .overlay {
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(.verde, lineWidth: 2)
                            }
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
            .padding(.top, 16)
            .background(.branco)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .shadow(color: .pretoShadow, radius: 10, y: 4)
            .padding(.horizontal, 32)
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
