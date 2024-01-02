//
//  UserView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 12/11/23.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var viewModel = UserViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if UserData.shared.user != .test {
                    VStack(spacing: 16) {
                        VStack(spacing: 10) {
                            Button {
                                viewModel.imageIsEditing.toggle()
                            } label: {
                                Image(UserData.shared.user.image)
                                    .resizable()
                                    .frame(width: 120, height: 116)
                                    .padding(.trailing, 16)
                                    .padding(.bottom, 2)
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
                            
                            Text(UserData.shared.user.name)
                                .foregroundStyle(.verde)
                                .font(.title.title())
                                .fontWeight(.bold)
                        }
                        
                        VStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Marcas que trabalho:")
                                    .foregroundStyle(.verde)
                                    .font(.title3.title3())
                                    .fontWeight(.semibold)
                                
                                Button {
                                    viewModel.brandIsEditing.toggle()
                                } label: {
                                    HStack {
                                        FlexStack {
                                            ForEach(viewModel.brands, id: \.name) { brand in
                                                if brand.isSelected {
                                                    Text(brand.name)
                                                        .foregroundStyle(.branco)
                                                        .font(.headline)
                                                        .fontWeight(.bold)
                                                        .padding(.horizontal, 8)
                                                        .padding(.vertical, 2)
                                                        .overlay(
                                                            RoundedRectangle(cornerRadius: 8)
                                                                .stroke(.rosa, lineWidth: 2)
                                                        )
                                                }
                                            }
                                        }
                                        
                                        Image(systemName: "square.and.pencil")
                                            .foregroundStyle(.branco)
                                            .font(.headline)
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 14)
                                    .background(.verde)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Desejo realizar contato:")
                                    .foregroundStyle(.verde)
                                    .font(.title3.title3())
                                    .fontWeight(.semibold)
                                
                                Button {
                                    viewModel.strategyIsEditing.toggle()
                                } label: {
                                    HStack {
                                        FlexStack(verticalSpacing: 8, horizontalSpacing: 8) {
                                            if UserData.shared.user.strategy != .none {
                                                Text(UserData.shared.user.strategy.name)
                                                    .foregroundStyle(.branco)
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                                    .padding(.horizontal, 8)
                                                    .padding(.vertical, 2)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 8)
                                                            .stroke(.rosa, lineWidth: 2)
                                                    )
                                            }
                                        }
                                        
                                        Image(systemName: "square.and.pencil")
                                            .foregroundStyle(.branco)
                                            .font(.headline)
                                    }
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 14)
                                    .background(.verde)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.isDeleting = true
                    } label: {
                        HStack {
                            Text("Deletar perfil")
                            
                            Image(systemName: "trash")
                        }
                        .foregroundStyle(.verde)
                        .font(.headline.headline())
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .overlay {
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(.verde, lineWidth: 2)
                        }
                    }
                    
                } else {
                    VStack(spacing: 32) {
                        Text("Você não possui perfil de usuário ainda")
                        
                        BLButton(symbol: "", text: "Criar perfil", disabled: false, opposite: false, color: .verde, textColor: .branco) {
                            RouterService.shared.navigate(.register)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 48)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .padding(.top, 10)
            .padding(.horizontal, 32)
            .background(.branco)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        RouterService.shared.navigate(.allClients)
                    } label: {
                        Image("backButton")
                            .resizable()
                            .frame(width: 54, height: 56)
                    }
                    .padding(.bottom, 10)
                }
            }
            .onAppear {
                viewModel.getImageList()
            }
            .sheet(isPresented: $viewModel.brandIsEditing) {
                BrandsSheet(viewModel: viewModel)
            }
            .sheet(isPresented: $viewModel.strategyIsEditing) {
                StrategySheet(viewModel: viewModel)
            }
            .sheet(isPresented: $viewModel.imageIsEditing) {
                UserImageSheet(viewModel: viewModel)
            }
            .overlay {
                if viewModel.isDeleting {
                    PopUp(title: "Você tem certeza que quer excluir seu perfil?", bodyText: "Continuar resultará na perda dos dados do seu perfil. Ao recriá-lo será necessário adicionar todas as preferências e informações.", buttonText: "Sim", secondaryText: "Não") {
                        viewModel.deleteUser()
                        viewModel.isDeleting = false
                    } secondaryFunc: {
                        viewModel.isDeleting = false
                    }
                }
            }
        }
    }
}

#Preview {
    UserView()
}
