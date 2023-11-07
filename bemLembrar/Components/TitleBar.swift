//
//  TitleBar.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

struct TitleBar: View {
    var symbol: String
    var title: String
    
    var body: some View {
        VStack(alignment:.leading) {
            
            Spacer()
            
            VStack(spacing: 2) {
                HStack {
                    Image(systemName: symbol)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                    
                    Text(title)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                
                HStack {
                    Text("Selecione suas clientes de acordo com a preferência")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                }
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 36)
            .padding(.bottom, 28)
        }
        .frame(height: 170)
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
    }
}

#Preview {
    VStack {
        TitleBar(symbol: "nose", title: "Cheiros")
        
        Spacer()
    }
}
