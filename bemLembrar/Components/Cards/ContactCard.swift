//
//  ContactCard.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 31/10/23.
//

import SwiftUI

struct ContactCard: View {
    @Binding var contact: Contact?
    var background: String
    var color: Color
    var mainFunc: () -> Void
    
    var body: some View {
        Button {
            mainFunc()
        } label: {
            HStack(spacing: 4) {
                Image(systemName: getSymbol())
                    .foregroundStyle(symbolColor())
                    .font(.subheadline)
                
                Text("\(contact!.contactInfo.givenName) \(contact!.contactInfo.familyName)")
                    .foregroundStyle(textColor())
                    .font(.headline.headline())
                    .fontWeight(.semibold)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(backgroundColor())
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14.0)
                .stroke(strokeColor(), lineWidth: 2)
        )
        .padding(2)
    }
    
    func getSymbol() -> String {
        if contact!.isSelected {
            return "square.fill"
        }
        return "square"
    }
    
    func strokeColor() -> Color {
        if background == "light" {
            return .verde
        }
        
        return .branco
    }
    
    func backgroundColor() -> Color {
        if background == "light" {
            if contact!.isSelected {
                return .verde
            }
            return .branco
        }
        
        if contact!.isSelected {
            return .branco
        }
        return .verde
    }
    
    func textColor() -> Color {
        if background == "light" {
            if contact!.isSelected {
                return .branco
            }
            return .verde
        }
        
        if contact!.isSelected {
            return .verde
        }
        return .branco
    }
    
    func symbolColor() -> Color {
        if contact!.isSelected {
            return .rosa
        }
        
        if background == "light" {
            return .verde
        }
        return .branco
    }
}

#Preview {
    VStack {
        VStack {
            ContactCard(contact: .constant(Contact.test), background: "dark", color: .white) {
                print("a")
            }
            
            ContactCard(contact: .constant(Contact.testSelected), background: "dark", color: .white) {
                print("a")
            }
        }
        .padding()
        .background(.verde)
        
        VStack {
            ContactCard(contact: .constant(Contact.test), background: "light", color: .white) {
                print("a")
            }
            
            ContactCard(contact: .constant(Contact.testSelected), background: "light", color: .white) {
                print("a")
            }
        }
        .padding()
        .background(.branco)
    }
}
