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
            ZStack {
                Color.branco
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        VStack {
                            Circle()
                                .frame(maxWidth: 200, maxHeight: 200)
                                .foregroundStyle(.gray)
                                .padding(.top, 32)
                            
                            VStack {
                                Text(client.fullName)
                                    .font(.system(size: 34))
                                    .lineLimit(1)
                                if viewModel.lastContact != Date.distantPast {
                                    Text("Último contato: \(viewModel.lastContact.formatted(date: .numeric, time: .omitted))")
                                }
                            }
                            
                            HStack {
                                BLButton(symbol: "message.fill", text: "Mensagem", disabled: false, opposite: false, color: client.preferences.atendimento == .mensagem ? .verde : .verdeClaro, textColor: .branco) {
                                    viewModel.shareMessage()
                                }
                                
                                BLButton(symbol: "phone.fill", text: "Ligação", disabled: false, opposite: false, color: client.preferences.atendimento == .ligacao ? .verde : .verdeClaro, textColor: .branco) {
                                    viewModel.shareMessage()
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
                                    }
                                    
                                    HStack {
                                        DateEditView(title: "Aniversário", date: $viewModel.birthday, isEditing: $viewModel.birthdayIsEditing)
                                        
                                        Spacer()
                                        
                                        Button {
                                            viewModel.saveBirthday()
                                        } label: {
                                            Image(systemName: viewModel.birthdayIsEditing ? "checkmark.circle.fill" : "square.and.pencil")
                                        }
                                    }
                                    .padding()
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    
                                    HStack {
                                        StringEditView(title: "Endereço", text: $viewModel.address, isEditing: $viewModel.addressIsEditing)
                                        
                                        Spacer()
                                        
                                        Button {
                                            viewModel.saveAddress()
                                        } label: {
                                            Image(systemName: viewModel.addressIsEditing ? "checkmark.circle.fill" : "square.and.pencil")
                                        }
                                    }
                                    .padding()
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                                
                                Spacer()
                            }
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Preferências:")
                                        .font(.system(size: 17))
                                        .bold()
                                    
                                    Text("Lembre-se do que sua cliente mais gosta!")
                                        .font(.system(size: 13))
                                    
                                    PreferencesTag(big: true, preferences: client.preferences)
                                }
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray5))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Anotações:")
                                            .font(.system(size: 17))
                                            .bold()
                                        
                                        Spacer()
                                        
                                        Button {
                                            viewModel.saveAnnotation()
                                        } label: {
                                            Image(systemName: viewModel.annotationIsEditing ? "checkmark.circle.fill" : "square.and.pencil")
                                        }
                                    }
                                    
                                    BigStringEditView(text: $viewModel.annotation, isEditing: $viewModel.annotationIsEditing)
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
                                Image(systemName: "chevron.left.circle.fill")
                                    .foregroundStyle(.verde)
                                    .font(.system(size: 32))
                                    .padding(.bottom, 10)
                            }
                        }
                    }
                    .onAppear {
                        viewModel.updateClient(client: client)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    ClientView(client: Client.test)
}
