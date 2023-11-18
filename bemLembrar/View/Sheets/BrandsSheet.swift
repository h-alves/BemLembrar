//
//  BrandsSheet.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 12/11/23.
//

import SwiftUI

struct BrandsSheet: View {
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 24) {
                SheetLine()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Marcas que trabalho")
                            .foregroundStyle(.preto)
                            .font(.title.title())
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            ForEach(viewModel.brands, id: \.name) { brand in
                                TextCard(isSelected: viewModel.getBrandBinding(brand: brand), text: brand.name, symbol: "square") {
                                    viewModel.selectBrand(brand: brand)
                                }
                            }
                        }
                        
                        HStack {
                            Spacer()
                            
                            BLButton(symbol: "checkmark", text: "Salvar", infinity: false, disabled: viewModel.brands.allSatisfy({ b in
                                !b.isSelected
                            }), opposite: false, color: .verde, textColor: .branco) {
                                viewModel.saveBrands()
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
    }
}

#Preview {
    BrandsSheet(viewModel: UserViewModel())
}
