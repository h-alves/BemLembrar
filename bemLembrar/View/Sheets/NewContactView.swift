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
        VStack(spacing: 24) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Dados Pessoais")
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack {
                    TextField("Telefone", text: $viewModel.number)
                    
                    TextField("Nome", text: $viewModel.givenName)
                    
                    TextField("Sobrenome", text: $viewModel.familyName)
                    
                    DatePicker("Aniversário:", selection: $viewModel.birthday, displayedComponents: [.date])
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Endereço")
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack {
                    TextField("Rua", text: $viewModel.street)
                    
                    TextField("Cidade", text: $viewModel.city)
                    
                    TextField("Estado", text: $viewModel.state)
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            Button {
                viewModel.addContact()
                viewModel.isPresented = false
            } label: {
                Text("Salvar")
                    .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemGray2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 12)
        .background(Color(.systemGray5))
    }
}

#Preview {
    NewContactView(viewModel: AddClientViewModel())
}
