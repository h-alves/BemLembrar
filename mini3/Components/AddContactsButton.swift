//
//  AddContactsButton.swift
//  mini3
//
//  Created by Henrique Semmer on 01/11/23.
//

import SwiftUI

struct AddContactsButton: View {
    var disabled: Bool
    var quantity: String
    var mainFunc: () -> Void
    
    var body: some View {
        Button {
            mainFunc()
        } label: {
            Text("Adicionar Clientes\(quantity)")
                .fontWeight(.bold)
                .foregroundStyle(textColor())
                .frame(maxWidth: .infinity)
                .padding()
                .background(buttonColor())
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .disabled(disabled)
    }
    
    func textColor() -> Color {
        if disabled {
            return .black
        }
        return .white
    }
    
    func buttonColor() -> Color {
        if disabled {
            return .gray
        }
        return .blue
    }
}

#Preview {
    VStack {
        AddContactsButton(disabled: false, quantity: " (2)") {
            print("a")
        }
        AddContactsButton(disabled: true, quantity: "") {
            print("a")
        }
    }
}
