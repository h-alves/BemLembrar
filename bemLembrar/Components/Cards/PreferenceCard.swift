//
//  PreferenceCard.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

struct PreferenceCard: View {
    var cheiro: Cheiro = .none
    var pele: Pele = .normal
    var atendimento: Atendimento = .none
    
    var clientList: [Client]
    
    var mainFunc: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            if clientList.isEmpty {
                Button {
                    mainFunc()
                } label: {
                    HStack {
                        // Título
                        if cheiro != .none {
                            Text("\(cheiro.rawValue.capitalized)?")
                                .foregroundStyle(.black)
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                        } else if pele != .normal {
                            Text("\(pele.rawValue.capitalized)?")
                                .foregroundStyle(.black)
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                        } else if atendimento != .none {
                            Text("\(atendimento.rawValue.capitalized)?")
                                .foregroundStyle(.black)
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "plus")
                            .foregroundStyle(.black)
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                    }
                }
            } else {
                HStack {
                    // Título
                    if cheiro != .none {
                        Text("\(cheiro.rawValue.capitalized)?")
                            .foregroundStyle(.black)
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                    } else if pele != .normal {
                        Text("\(pele.rawValue.capitalized)?")
                            .foregroundStyle(.black)
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                    } else if atendimento != .none {
                        Text("\(atendimento.rawValue.capitalized)?")
                            .foregroundStyle(.black)
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                    
                    Button {
                        mainFunc()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.black)
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                    }
                }
            }
            
            if !clientList.isEmpty {
                HStack {
                    ScrollView(.horizontal) {
                        HStack {
                            // Todos os clientes
                            ForEach(clientList, id: \.identifier) { client in
                                Text(client.fullName)
                                    .font(.system(size: 17))
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                    .background(Color(.systemGray4))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(18)
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    VStack {
        PreferenceCard(cheiro: .amadeirado, clientList: [Client.test]) {
            print("Clicado")
        }
        PreferenceCard(pele: .oleosa, clientList: [Client.test]) {
            print("Clicado")
        }
        PreferenceCard(atendimento: .presencial, clientList: [Client.test]) {
            print("Clicado")
        }
    }
    .padding(32)
}
