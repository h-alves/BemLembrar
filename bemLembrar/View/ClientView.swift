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
                    .ignoresSafeArea(edges: .top)
                
                Color.verde
                    .ignoresSafeArea(edges: .bottom)
                
                VStack(spacing: 24) {
                    VStack {
                        ScrollView {
                            VStack(spacing: 32) {
                                VStack(spacing: 24) {
                                    VStack(spacing: 12) {
                                        Button {
                                            viewModel.imageIsEditing.toggle()
                                        } label: {
                                            Image(viewModel.client.image)
                                                .resizable()
                                                .frame(width: 120, height: 116)
                                                .padding(.trailing, 24)
                                                .padding(.bottom, 4)
                                                .overlay(alignment: .bottomTrailing) {
                                                    ZStack {
                                                        Image(systemName: "circle.fill")
                                                            .foregroundStyle(.branco)
                                                            .font(.system(size: 40))
                                                        Image(systemName: "square.and.pencil.circle.fill")
                                                            .foregroundStyle(.verde)
                                                            .font(.system(size: 40))
                                                    }
                                                }
                                        }
                                        
                                        VStack(spacing: 0) {
                                            Text(client.fullName)
                                                .foregroundStyle(.verde)
                                                .font(.title)
                                                .fontWeight(.bold)
                                            
                                            if viewModel.lastContact != Date.distantPast {
                                                Text("Último contato: \(viewModel.lastContact.formatted(date: .numeric, time: .omitted))")
                                                    .foregroundStyle(.verdeClaro)
                                                    .font(.footnote)
                                            } else {
                                                Text("")
                                                    .foregroundStyle(.verdeClaro)
                                                    .font(.footnote)
                                            }
                                        }
                                    }
                                    
                                    PreferencesTag(big: true, preferences: client.preferences)
                                }
                                
                                VStack(spacing: 16) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Aniversário")
                                            .foregroundStyle(.verde)
                                            .font(.headline)
                                        
                                        DateEditView(title: "Aniversário", name: viewModel.client.fullName.removeFamilyName(), date: $viewModel.birthday, isEditing: $viewModel.birthdayIsEditing) {
                                            viewModel.saveBirthday()
                                        }
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Endereço")
                                            .foregroundStyle(.verde)
                                            .font(.headline)
                                        
                                        StringEditView(title: "Endereço", placeholderText: "", name: viewModel.client.fullName.removeFamilyName(), text: $viewModel.address, isEditing: $viewModel.addressIsEditing) {
                                            viewModel.saveAddress()
                                        }
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Anotações")
                                            .foregroundStyle(.verde)
                                            .font(.headline)
                                        
                                        BigStringEditView(text: $viewModel.annotation, isEditing: $viewModel.annotationIsEditing) {
                                            viewModel.saveAnnotation()
                                        }
                                    }
                                }
                            }
                            .padding(.bottom, 24)
                        }
                        .scrollIndicators(.hidden)
                    }
                    .padding(.top, 24)
                    .padding(.horizontal, 32)
                    .background(.branco)
                    .clipShape(
                        .rect (
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 32,
                            bottomTrailingRadius: 32,
                            topTrailingRadius: 0
                        )
                    )
                    .shadow(color: .pretoShadow.opacity(0.2), radius: 5, y: 8)
                    
                    HStack(spacing: 16) {
                        BLButton(symbol: "message.fill", symbolFont: .title2, vertical_padding: 16, disabled: false, opposite: false, color: .branco, textColor: .verde) {
                            viewModel.shareMessage()
                        }
                        
                        BLButton(symbol: "phone.fill", symbolFont: .title2, vertical_padding: 17, disabled: false, opposite: false, color: .branco, textColor: .verde) {
                            viewModel.callClient()
                        }
                    }
                    .padding(.horizontal, 32)
                }
                .onAppear {
                    viewModel.updateClient(client: client)
                    viewModel.getImageList()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            RouterService.shared.navigate(.allClients)
                        } label: {
                            Image("backButton")
                                .resizable()
                                .frame(width: 54, height: 56)
                        }
                    }
                }
            }
            .sheet(isPresented: $viewModel.imageIsEditing) {
                ClientImageSheet(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ClientView(client: Client.test)
}
