//
//  PreferenceCard.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

struct PreferenceCard: View {
    var cheiro: Cheiro = .none
    var pele: Pele = .none
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
                                .font(.body)
                                .fontWeight(.semibold)
                        } else if pele != .none {
                            Text("\(pele.rawValue.capitalized)?")
                                .foregroundStyle(.verde)
                                .font(.body)
                                .fontWeight(.semibold)
                        } else if atendimento != .none {
                            Text("\(atendimento.rawValue.capitalized)?")
                                .foregroundStyle(.verde)
                                .font(.body)
                                .fontWeight(.semibold)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "plus")
                            .foregroundStyle(.verde)
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
            } else {
                HStack {
                    // Título
                    if cheiro != .none {
                        Text("\(cheiro.rawValue.capitalized)?")
                            .foregroundStyle(.branco)
                            .font(.body)
                            .fontWeight(.semibold)
                    } else if pele != .none {
                        Text("\(pele.rawValue.capitalized)?")
                            .foregroundStyle(.branco)
                            .font(.body)
                            .fontWeight(.semibold)
                    } else if atendimento != .none {
                        Text("\(atendimento.rawValue.capitalized)?")
                            .foregroundStyle(.branco)
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                    
                    Button {
                        mainFunc()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.branco)
                            .font(.subheadline)
                            .fontWeight(.bold)
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
                                    .background(.branco)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .padding(1)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(clientList.isEmpty ? .branco : .verde)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .stroke(clientList.isEmpty ? .verdeClaro : .verde, lineWidth: 2)
        }
    }
}

#Preview {
    VStack {
        PreferenceCard(cheiro: .amadeirado, clientList: []) {
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
    .background()
}
