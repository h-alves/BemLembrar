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
            Text("MARCAS")
            
            ForEach(viewModel.brands, id: \.name) { brand in
                HStack {
                    Button {
                        viewModel.selectBrand(brand: brand)
                    } label: {
                        Image(systemName: brand.isSelected ? "square.fill" : "square")
                    }
                    
                    Text(brand.name)
                }
            }
            
            Button {
                viewModel.saveBrands()
            } label: {
                Text("Done")
            }
        }
    }
}

#Preview {
    BrandsSheet(viewModel: UserViewModel())
}
