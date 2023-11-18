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
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                VStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Marcas que trabalho:")
                            .foregroundStyle(.verde)
                            .font(.title3)
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
                            .font(.title3)
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
                
                Spacer()
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
        }
    }
}

#Preview {
    UserView()
}
