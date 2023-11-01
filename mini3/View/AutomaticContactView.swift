//
//  AutomaticContactView.swift
//  mini3
//
//  Created by Henrique Semmer on 31/10/23.
//

import SwiftUI

struct AutomaticContactView: View {
    @ObservedObject var viewModel: ContactViewModel
    
    var body: some View {
        VStack {
            Text("Encontramos alguns contatos que possivelmente são seus clientes, confirme.")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            
            // Card que apresenta todos os contatos
            ForEach(viewModel.autoContacts, id: \.contactInfo.identifier) { phoneContact in
                ContactSelectCard(contact: viewModel.getBinding(contact: phoneContact)) {
                    viewModel.selectContact(contact: phoneContact)
                }
            }
            
            // Botão pra salvar
            Button {
                viewModel.saveData()
                
                // Navegar para a ContactView
            } label: {
                Text("Salvar")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    AutomaticContactView(viewModel: ContactViewModel())
}
