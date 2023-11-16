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
                Color.rosa
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    VStack {
                        Spacer()
                        
                        Image(client.image)
                            .resizable()
                            .frame(maxWidth: 200, maxHeight: 200)
                            .overlay(alignment: .bottomTrailing) {
                                Button {
                                    print("Clicado")
                                } label: {
                                    ZStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundStyle(.branco)
                                            .font(.system(size: 48))
                                        Image(systemName: "square.and.pencil.circle.fill")
                                            .foregroundStyle(.verde)
                                            .font(.system(size: 48))
                                    }
                                }
                            }
                        
                        VStack {
                            Text(client.fullName)
                                .foregroundStyle(.verde)
                                .font(.title)
                                .fontWeight(.bold)
                            if viewModel.lastContact != Date.distantPast {
                                Text("Último contato: \(viewModel.lastContact.formatted(date: .numeric, time: .omitted))")
                                    .foregroundStyle(.verdeClaro)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            }
                        }
                        
                        HStack {
                            BLButton(symbol: "message.fill", text: "Mensagem", infinity: false, disabled: false, opposite: false, color: client.preferences.atendimento == .mensagem ? .verde : .verdeClaro, textColor: .branco) {
                                viewModel.shareMessage()
                            }
                            
                            BLButton(symbol: "phone.fill", text: "Ligação", infinity: false, disabled: false, opposite: false, color: client.preferences.atendimento == .ligacao ? .verde : .verdeClaro, textColor: .branco) {
                                viewModel.callClient()
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.bottom, 16)
                    .padding(.horizontal, 32)
                    .background(.branco)
                    .clipShape(
                        .rect (
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 16,
                            bottomTrailingRadius: 16,
                            topTrailingRadius: 0
                        )
                    )
                    .ignoresSafeArea()
                    .shadow(radius: 5)
                    .padding(.bottom, 10)
                    
                    ScrollView {
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
                                    .background(.branco)
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
                                    .background(.branco)
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
                            .background(.branco)
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
                            .background(.branco)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Spacer()
                        }
                        .padding(.top, 24)
                        .padding(.horizontal, 32)
                    }
                    .scrollIndicators(.hidden)
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
                    .background(.rosa)
                    .onAppear {
                        viewModel.updateClient(client: client)
                    }
                }
            }
        }
    }
}

#Preview {
    ClientView(client: Client.test)
}
