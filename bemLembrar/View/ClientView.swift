//
//  ClientView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 02/11/23.
//

import SwiftUI

struct ClientView: View {
    @ObservedObject var viewModel = ClientViewModel()
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
                    
                    HStack {
                        ClientButton(symbol: "message.fill", text: "mensagem") {
                            print("MENSAGEM")
                        }
                        
                        ClientButton(symbol: "phone.circle.fill", text: "ligar") {
                            print("LIGAR")
                        }
                    }
                }
                .padding(.bottom, 12)
                
                VStack(spacing: 16) {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Informações gerais:")
                                    .font(.system(size: 17))
                                    .bold()
                                
                                Spacer()
                                
                                Button {
                                    viewModel.saveData()
                                } label: {
                                    Image(systemName: viewModel.isEditing ? "checkmark.circle.fill" : "square.and.pencil")
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 6) {
                                DateEditView(title: "Aniversário", date: $viewModel.birthday, isEditing: $viewModel.isEditing)
                            }
                            
                            VStack(alignment: .leading, spacing: 6) {
                                StringEditView(title: "Endereço", text: $viewModel.address, isEditing: $viewModel.isEditing)
                            }
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
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
            .onAppear {
                viewModel.updateClient(client: client)
            }
        }
    }
}

#Preview {
    ClientView(client: Client.test)
}
