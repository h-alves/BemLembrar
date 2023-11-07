//
//  ClientView.swift
//  mini3
//
//  Created by Henrique Semmer on 02/11/23.
//

import SwiftUI

struct ClientView: View {
    var client: Client
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Circle()
                        .frame(maxWidth: 200, maxHeight: 200)
                        .foregroundStyle(.gray)
                        .padding(.top, 32)
                    
                    Text(client.fullName)
                        .font(.system(size: 34))
                    
                    Button(action: {
                        print("Botão pressionado!")
                    }) {
                        Text("Entrar em contato")
                            .font(.system(size: 22))
                            .foregroundStyle(.white)
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.bottom, 12)
                
                VStack(spacing: 16) {
                    if client.birthday != nil && !client.contactInfo.postalAddresses.isEmpty {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Informações gerais:")
                                    .font(.system(size: 17))
                                    .bold()
                                
                                if client.birthday != nil {
                                    VStack(alignment: .leading, spacing: 6) {
                                        HStack(spacing: 0) {
                                            Text("Aniversário: \((client.birthday?.formatted(date: .numeric, time: .omitted))!)")
                                        }
                                        .font(.system(size: 13))
                                    }
                                }
                                
                                if !client.contactInfo.postalAddresses.isEmpty {
                                    VStack(alignment: .leading, spacing: 6) {
                                        HStack(spacing: 0) {
                                            Text("Endereço: \(client.address!)")
                                        }
                                        .font(.system(size: 13))
                                    }
                                }
                            }
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Preferências:")
                                .font(.system(size: 17))
                                .bold()
                            
                            Text("Lembre-se do que sua cliente mais gosta!")
                                .font(.system(size: 13))
                            
                            PreferencesTagsBig(preferences: client.preferences)
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Anotações:")
                                .font(.system(size: 17))
                                .bold()
                            
                            Text("Aqui você pode registrar alergias, tanana e \ndetalhes para garantir sempre o melhor atendimento!")
                                .font(.system(size: 13))
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 32)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        RouterService.shared.navigate(.allClients)
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

#Preview {
    ClientView(client: Client.test)
}
