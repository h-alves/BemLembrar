//
//  RegisterView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 15/11/23.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel = UserViewModel()
    
    @Binding var onboarding: Bool
    
    var body: some View {
        ZStack {
            Color.branco
                .ignoresSafeArea(edges: .top)
            
            Color.verde
                .ignoresSafeArea(edges: .bottom)
            
            VStack(spacing: 24) {
                VStack(spacing: 0) {
                    Image("onboardingTopBar")
                        .resizable()
                        .frame(width: .infinity, height: 88)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Nos conte um pouco mais sobre você!")
                                .foregroundStyle(.preto)
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            Text("Suas informações são confidenciais e usadas exclusivamente para melhorar sua experiência no aplicativo.")
                                .foregroundStyle(.preto)
                        }
                        
                        VStack(alignment: .leading, spacing: 24) {
                            ScrollView {
                                VStack {
                                    VStack(alignment: .leading, spacing: 12) {
                                        Text("Como você gostaria de ser chamada?")
                                            .foregroundStyle(.preto)
                                            .font(.headline)
                                        
                                        TextField("Seu nome", text: $viewModel.name)
                                            .font(.headline)
                                            .foregroundStyle(.verdeClaro)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 14)
                                                    .stroke(.rosa, lineWidth: 2)
                                            )
                                            .padding(.horizontal, 1)
                                    }
                                    
                                    HStack(spacing: 16) {
                                        RoundedRectangle(cornerRadius: 2)
                                            .foregroundStyle(.verdeOpaco)
                                            .frame(height: 2)
                                        
                                        Image("flowerLine")
                                            .resizable()
                                            .frame(width: 26, height: 27)
                                        
                                        RoundedRectangle(cornerRadius: 2)
                                            .foregroundStyle(.verdeOpaco)
                                            .frame(height: 2)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 12) {
                                        Text("Com quais marcas você trabalha?")
                                            .foregroundStyle(.preto)
                                            .font(.headline)
                                        
                                        VStack(spacing: 10) {
                                            ForEach(viewModel.brands, id: \.name) { brand in
                                                TextCard(isSelected: viewModel.getBrandBinding(brand: brand), text: brand.name, symbol: "square") {
                                                    viewModel.selectBrand(brand: brand)
                                                }
                                            }
                                        }
                                    }
                                    
                                    HStack(spacing: 16) {
                                        RoundedRectangle(cornerRadius: 2)
                                            .foregroundStyle(.verdeOpaco)
                                            .frame(height: 2)
                                        
                                        Image("flowerLine")
                                            .resizable()
                                            .frame(width: 26, height: 27)
                                        
                                        RoundedRectangle(cornerRadius: 2)
                                            .foregroundStyle(.verdeOpaco)
                                            .frame(height: 2)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 12) {
                                        Text("Qual é a sua estratégia de recontato com as clientes?")
                                            .foregroundStyle(.preto)
                                            .font(.headline)
                                        
                                        VStack(spacing: 10) {
                                            ForEach(viewModel.strategies, id: \.name) { strategy in
                                                TextCard(isSelected: viewModel.getStrategyBinding(strategy: strategy), text: strategy.name, symbol: "circle") {
                                                    viewModel.selectStrategy(strategy: strategy)
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(.bottom, 32)
                            }
                            .scrollIndicators(.hidden)
                        }
                    }
                    .padding(.horizontal, 32)
                    .background(.branco)
                }
                .background(.branco)
                .clipShape(
                    .rect (
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 32,
                        bottomTrailingRadius: 32,
                        topTrailingRadius: 0
                    )
                )
                .shadow(radius: 5, y: 12)
                
                BLButton(symbol: viewModel.isDisabled() ? "" : "checkmark", text: "Concluir cadastro", disabled: viewModel.isDisabled(), opposite: !viewModel.isDisabled(), color: .branco, textColor: .verde) {
                    viewModel.registerUser()
                }
                .padding(.horizontal, 32)
                
                Spacer()
            }
        }
    }
}

#Preview {
    RegisterView(onboarding: .constant(true))
}
