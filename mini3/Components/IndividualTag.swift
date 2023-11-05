//
//  IndividualTag.swift
//  mini3
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

struct IndividualTag: View {
    var texto: String
    
    var body: some View {
        if !texto.isEmpty {
            Text(texto)
                .font(.system(size: 12))
                .foregroundStyle(.black)
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(Color(.lightGray))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    IndividualTag(texto: "teste")
}
