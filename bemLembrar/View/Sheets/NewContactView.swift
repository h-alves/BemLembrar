//
//  NewContactView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 07/11/23.
//

import SwiftUI

struct NewContactView: View {
    @ObservedObject var viewModel: AddClientViewModel
    
    var body: some View {
        VStack {
            TextField("Número", text: $viewModel.number)
            
            TextField("Nome", text: $viewModel.givenName)
            
            TextField("Sobrenome", text: $viewModel.familyName)
            
            DatePicker("Aniversário", selection: $viewModel.birthday, displayedComponents: [.date])
            
            TextField("Rua", text: $viewModel.street)
            
            TextField("Cidade", text: $viewModel.city)
            
            TextField("Estado", text: $viewModel.state)
            
            Button {
                viewModel.addContact()
                viewModel.isPresented = false
            } label: {
                Text("Salvar")
            }
        }
    }
}

#Preview {
    NewContactView(viewModel: AddClientViewModel())
}
