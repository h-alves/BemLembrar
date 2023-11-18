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
                        .frame(width: 393, height: 88)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Nos conte um pouco mais sobre você!")
                                .foregroundStyle(.preto)
                                .font(.title.title())
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
                                            .font(.headline.headline())
                                        
                                        BLTextField(text: $viewModel.name)
                                    }
                                    
                                    Divider()
                                    
                                    VStack(alignment: .leading, spacing: 12) {
                                        Text("Com quais marcas você trabalha?")
                                            .foregroundStyle(.preto)
                                            .font(.headline.headline())
                                        
                                        VStack(spacing: 10) {
                                            ForEach(viewModel.brands, id: \.name) { brand in
                                                TextCard(isSelected: viewModel.getBrandBinding(brand: brand), text: brand.name, symbol: "square") {
                                                    viewModel.selectBrand(brand: brand)
                                                }
                                            }
                                        }
                                    }
                                    
                                    Divider()
                                    
                                    VStack(alignment: .leading, spacing: 12) {
                                        Text("Qual é a sua estratégia de recontato com as clientes?")
                                            .foregroundStyle(.preto)
                                            .font(.headline.headline())
                                        
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
                .shadow(color: .pretoShadow.opacity(0.2), radius: 5, y: 8)
                
                BLButton(symbol: viewModel.isDisabled() ? "" : "checkmark", text: "Concluir cadastro", disabled: viewModel.isDisabled(), opposite: !viewModel.isDisabled(), color: .branco, textColor: .preto) {
                    viewModel.registerUser()
                    onboarding = false
                    RouterService.shared.navigate(.allClients)
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
