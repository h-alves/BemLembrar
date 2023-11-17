//
//  DateEditView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 09/11/23.
//

import SwiftUI

struct DateEditView: View {
    var title: String
    @Binding var date: Date
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            if !isEditing {
                DatePicker(title, selection: $date, displayedComponents: [.date])
            } else {
                Text("\(title):")
                
                if date.formatted(date: .numeric, time: .omitted) != Date().formatted(date: .numeric, time: .omitted) {
                    Text(date.formatText())
                }
            }
            
            Spacer()
        }
        .font(.system(size: 13))
    }
}

#Preview {
    DateEditView(title: "teste", date: .constant(Date()), isEditing: .constant(false))
        .padding(.horizontal, 32)
}
