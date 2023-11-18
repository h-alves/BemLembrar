//
//  Divider.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 16/11/23.
//

import SwiftUI

struct Divider: View {
    var color: Color = .verdeOpaco
    
    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 2)
                .foregroundStyle(color)
                .frame(height: 2)
            
            Image("flowerLine\(color.name().capitalized)")
                .resizable()
                .frame(width: 26, height: 27)
            
            RoundedRectangle(cornerRadius: 2)
                .foregroundStyle(color)
                .frame(height: 2)
        }
    }
}

#Preview {
    Divider(color: .verdeOpaco)
}
