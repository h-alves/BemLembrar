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
                                Text(viewModel.lastContact.formatted())
                            }
                        }
                        
                        HStack {
                            ShareLink(item: viewModel.shareText, preview: SharePreview(viewModel.shareText, image: Image("noClients"))) {
                                HStack {
                                    Image(systemName: "message.fill")
                                    
                                    Text("Mensagem")
                                }
                                .font(.system(size: 22))
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            
                            ClientButton(symbol: "phone.circle.fill", text: "ligar") {
                                print("LIGAR")
                                viewModel.callClient()
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
                                        viewModel.saveInfo()
                                    } label: {
                                        Image(systemName: viewModel.infoIsEditing ? "checkmark.circle.fill" : "square.and.pencil")
                                    }
                                }
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    DateEditView(title: "Aniversário", date: $viewModel.birthday, isEditing: $viewModel.infoIsEditing)
                                }
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    StringEditView(title: "Endereço", text: $viewModel.address, isEditing: $viewModel.infoIsEditing)
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
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    ClientView(client: Client.test)
}
