//
//  ContactSelectCard.swift
//  mini3
//
//  Created by Henrique Semmer on 31/10/23.
//

import SwiftUI

struct ContactSelectCard: View {
    @Binding var contact: InitialContact?
    var mainFunc: () -> Void
    
    var body: some View {
        Button {
            mainFunc()
        } label: {
            HStack {
                Image(systemName: getSymbol())
                
                Text(contact!.contactInfo.givenName)
                Text(contact!.contactInfo.familyName)
            }
            .foregroundStyle(.black)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(.black, lineWidth: 2)
        )
    }
    
    func getSymbol() -> String {
        if contact!.isSelected {
            return "checkmark.square.fill"
        }
        return "square"
    }
}

#Preview {
    ContactSelectCard(contact: .constant(InitialContact.teste)) {
        print("a")
    }
}
