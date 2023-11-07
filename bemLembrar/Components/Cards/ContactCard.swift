//
//  ContactCard.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 31/10/23.
//

import SwiftUI

struct ContactCard: View {
    @Binding var contact: Contact?
    var mainFunc: () -> Void
    
    var body: some View {
        Button {
            mainFunc()
        } label: {
            HStack {
                Image(systemName: getSymbol())
                
                Text("\(contact!.contactInfo.givenName) \(contact!.contactInfo.familyName)")
                
                Spacer()
            }
            .foregroundStyle(.black)
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(strokeColor(), lineWidth: 2)
        )
        .background(backgroundColor())
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    func getSymbol() -> String {
        if contact!.isSelected {
            return "circle.fill"
        }
        return "circle"
    }
    
    func strokeColor() -> Color {
        if contact!.isSelected {
            return .gray
        }
        return .black
    }
    
    func backgroundColor() -> Color {
        if contact!.isSelected {
            return .gray
        }
        return .white
    }
}

#Preview {
    ContactCard(contact: .constant(Contact.test)) {
        print("a")
    }
}
