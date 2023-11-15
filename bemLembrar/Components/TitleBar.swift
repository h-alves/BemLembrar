//
//  TitleBar.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

struct TitleBar: View {
    var backgroundImage: String
    var image: String
    var title: String
    var color: Color
    
    var body: some View {
        VStack {
            Image(backgroundImage)
                .resizable()
                .frame(width: .infinity, height: 183)
            
            HStack {
                Image(image)
                    .resizable()
                    .frame(width: 56, height: 58)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .foregroundStyle(color)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Selecione suas clientes de acordo com a preferência")
                        .foregroundStyle(.preto)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .background(.branco)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(radius: 5, y: 5)
    }
}

#Preview {
    VStack {
        TitleBar(backgroundImage: "teste", image: "nose", title: "Cheiros", color: .laranja)
        
        Spacer()
    }
}
