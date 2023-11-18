//
//  TextCard.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 15/11/23.
//

import SwiftUI

struct TextCard: View {
    @Binding var isSelected: Bool?
    var text: String
    var symbol: String
    var mainFunc: () -> Void
    
    var body: some View {
        Button {
            mainFunc()
        } label: {
            HStack(alignment: .center, spacing: 4) {
                Image(systemName: getSymbol())
                    .foregroundColor(symbolColor())
                    .font(.subheadline)
                
                Text(text.capitalized)
                    .foregroundStyle(textColor())
                    .font(.headline)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(backgroundColor())
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14.0)
                    .stroke(.preto, lineWidth: 2)
            )
            .padding(1)
        }
    }
    
    func backgroundColor() -> Color {
        if isSelected! {
            return .preto
        }
        return .branco
    }
    
    func textColor() -> Color {
        if isSelected! {
            return .branco
        }
        return .preto
    }
    
    func symbolColor() -> Color {
        if isSelected! {
            return .rosa
        }
        return .preto
    }
    
    func getSymbol() -> String {
        var newSymbol = symbol
        
        if isSelected! {
            newSymbol += ".fill"
        }
        
        return newSymbol
    }
}

#Preview {
    VStack {
        TextCard(isSelected: .constant(false), text: "teste", symbol: "square") {
            print("a")
        }
        
        TextCard(isSelected: .constant(true), text: "teste", symbol: "square") {
            print("a")
        }
    }
}
