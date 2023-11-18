//
//  BLDatePicker.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 17/11/23.
//

import SwiftUI

struct BLDatePicker: View {
    var placeholderText: String = "Aniversário"
    @Binding var date: Date
    
    var body: some View {
        DatePicker(placeholderText, selection: $date, displayedComponents: .date)
            .font(.headline)
            .foregroundStyle(.preto)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(date.formatted(date: .numeric, time: .omitted) == Date().formatted(date: .numeric, time: .omitted) ? .rosa : .verde, lineWidth: 2)
            )
            .padding(.horizontal, 1)
    }
}

#Preview {
    BLDatePicker(date: .constant(Date()))
}
