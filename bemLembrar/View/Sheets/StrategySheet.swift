//
//  StrategySheet.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 12/11/23.
//

import SwiftUI

struct StrategySheet: View {
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 24) {
                SheetLine()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Desejo realizar contato")
                            .foregroundStyle(.preto)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            ForEach(viewModel.strategies, id: \.name) { strategy in
                                TextCard(isSelected: viewModel.getStrategyBinding(strategy: strategy), text: strategy.name, symbol: "circle") {
                                    viewModel.selectStrategy(strategy: strategy)
                                }
                            }
                        }
                        
                        HStack {
                            Spacer()
                            
                            BLButton(symbol: "checkmark", text: "Salvar", infinity: false, disabled: false, opposite: false, color: .verde, textColor: .branco) {
                                viewModel.saveStrategies()
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal, 32)
        }
        .padding(.top, 12)
        .background(.branco)
        .presentationDetents([.medium])
//        VStack {
//            Text("ESTRATÉGIAS")
//            
//            ForEach(viewModel.strategies, id: \.name) { strategy in
//                HStack {
//                    Button {
//                        viewModel.selectStrategy(strategy: strategy)
//                    } label: {
//                        Image(systemName: strategy.isSelected ? "square.fill" : "square")
//                    }
//                    
//                    Text(strategy.name)
//                }
//            }
//            
//            Button {
//                viewModel.saveStrategies()
//            } label: {
//                Text("Done")
//            }
//        }
    }
}

#Preview {
    StrategySheet(viewModel: UserViewModel())
}
