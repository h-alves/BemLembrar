//
//  PreferenceCard.swift
//  mini3
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

struct PreferenceCard: View {
    var cheiro: Cheiro = .none
    var pele: Pele = .normal
    var atendimento: Atendimento = .none
    
    @Binding var clientList: [Client]
    
    var mainFunc: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            // Título
            if cheiro != .none {
                Text("\(cheiro.rawValue.capitalized)?")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
            } else if pele != .normal {
                Text("\(pele.rawValue.capitalized)?")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
            } else if atendimento != .none {
                Text("\(atendimento.rawValue.capitalized)?")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
            }
            
            HStack {
                // Botão de adicionar
                VStack {
                    Button {
                        mainFunc()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 32))
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding()
                            .background(.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    
                    Text("Adicionar")
                        .font(.system(size: 19))
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                }
                
                ScrollView(.horizontal) {
                    HStack {
                        // Todos os clientes
                        ForEach(clientList, id: \.contactInfo.identifier) { client in
                            VStack {
                                Image("")
                                    .resizable()
                                    .frame(width: 65, height: 65)
                                    .background(.gray)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                
                                Text(client.fullName)
                                    .font(.system(size: 19))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.gray)
                                    .frame(maxWidth: 100)
                                    .lineLimit(1)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(32)
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    VStack {
        PreferenceCard(cheiro: .amadeirado, clientList: .constant([Client.test])) {
            print("Clicado")
        }
        PreferenceCard(pele: .oleosa, clientList: .constant([Client.test])) {
            print("Clicado")
        }
        PreferenceCard(atendimento: .presencial, clientList: .constant([Client.test])) {
            print("Clicado")
        }
    }
    .padding(32)
}
