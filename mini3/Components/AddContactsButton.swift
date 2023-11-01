//
//  AddContactsButton.swift
//  mini3
//
//  Created by Henrique Semmer on 01/11/23.
//

import SwiftUI

struct AddContactsButton: View {
    var quantity: String
    var mainFunc: () -> Void
    
    var body: some View {
        Button {
            mainFunc()
        } label: {
            Text("Adicionar Clientes\(quantity)")
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

#Preview {
    AddContactsButton(quantity: "teste") {
        print("a")
    }
}
