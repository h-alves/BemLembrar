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
            Text("\(title):")
            
            if isEditing {
                DatePicker(title, selection: $date, displayedComponents: [.date])
                    .labelsHidden()
                    .scaleEffect(CGSize(width: 0.8, height: 0.8))
                    .clipped()
            } else {
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
}
