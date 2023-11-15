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
                                .foregroundStyle(.verde)
                                .font(.title3)
                                .fontWeight(.semibold)
                        } else if pele != .normal {
                            Text("\(pele.rawValue.capitalized)?")
                                .foregroundStyle(.verde)
                                .font(.title3)
                                .fontWeight(.semibold)
                        } else if atendimento != .none {
                            Text("\(atendimento.rawValue.capitalized)?")
                                .foregroundStyle(.verde)
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "plus")
                            .foregroundStyle(.verde)
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                    }
                }
            } else {
                HStack {
                    // Título
                    if cheiro != .none {
                        Text("\(cheiro.rawValue.capitalized)?")
                            .foregroundStyle(.verde)
                            .font(.title3)
                            .fontWeight(.semibold)
                    } else if pele != .normal {
                        Text("\(pele.rawValue.capitalized)?")
                            .foregroundStyle(.verde)
                            .font(.title3)
                            .fontWeight(.semibold)
                    } else if atendimento != .none {
                        Text("\(atendimento.rawValue.capitalized)?")
                            .foregroundStyle(.verde)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                    
                    Button {
                        mainFunc()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.verde)
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
                                    .foregroundStyle(.verde)
                                    .font(.headline)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(.verde, lineWidth: 2)
                                    }
                                    .padding(1)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(18)
        .background(.branco)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 5)
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
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(32)
    .background(.branco)
}
