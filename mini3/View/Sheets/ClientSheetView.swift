//
//  ClientSheetView.swift
//  mini3
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

struct ClientSheetView: View {
    @ObservedObject var viewModel: PreferencesViewModel
    
    var preferenceType: PreferenceType
    
    var cheiro: Cheiro = .none
    var pele: Pele = .normal
    var atendimento: Atendimento = .none
    
    var body: some View {
        ZStack {
            VStack {
                ForEach(viewModel.filteredContacts, id: \.contactInfo.identifier) { client in
                    ContactCard(contact: viewModel.getBinding(contact: client)) {
                        viewModel.selectContact(contact: client)
                    }
                }
                
                Button {
                    // Mudar as informações
                    viewModel.saveData(cheiro: cheiro, pele: pele, atendimento: atendimento)
                    RouterService.shared.hideSheet()
                } label: {
                    Text("Selecionar contatos")
                }
            }
        }
        .onAppear {
            viewModel.filterContacts(cheiro: cheiro, pele: pele, atendimento: atendimento)
        }
    }
}

#Preview {
    ClientSheetView(viewModel: PreferencesViewModel(), preferenceType: .service)
}
