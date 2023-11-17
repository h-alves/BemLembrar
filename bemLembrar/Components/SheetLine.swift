//
//  SheetLine.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 17/11/23.
//

import SwiftUI

struct SheetLine: View {
    var color: Color = .rosa
    
    var body: some View {
        RoundedRectangle(cornerRadius: 32)
            .foregroundStyle(color)
            .frame(width: 55, height: 4)
    }
}

#Preview {
    SheetLine()
}
