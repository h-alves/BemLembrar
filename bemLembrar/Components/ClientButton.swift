//
//  ClientButton.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 09/11/23.
//

import SwiftUI

struct ClientButton: View {
    var symbol: String
    var text: String
    
    var mainFunc: () -> Void
    
    var body: some View {
        Button {
            mainFunc()
        } label: {
            HStack {
                Image(systemName: symbol)
                
                Text(text.capitalized)
            }
            .font(.system(size: 22))
            .foregroundStyle(.white)
            .padding()
        }
        .background(.black)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ClientButton(symbol: "circle", text: "teste") {
        print("a")
    }
}
