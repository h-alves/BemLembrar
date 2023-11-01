//
//  ManualContactView.swift
//  mini3
//
//  Created by Henrique Semmer on 30/10/23.
//

import SwiftUI

struct ManualContactView: View {
    @ObservedObject var viewModel: ContactViewModel
    
    var body: some View {
        VStack {
            Text("Selecione outros contatos que também são clientes")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            
            // Card que apresenta todos os contatos
            ForEach(viewModel.manualContacts, id: \.contactInfo.identifier) { phoneContact in
                ContactSelectCard(contact: viewModel.getBinding(contact: phoneContact)) {
                    viewModel.selectContact(contact: phoneContact)
                }
            }
            
            // Botão pra salvar
            Button {
                viewModel.saveData()
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
    ManualContactView(viewModel: ContactViewModel())
}
