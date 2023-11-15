//
//  ClientSheetView.swift
//  bemLembrar
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
        VStack {
            switch preferenceType {
            case .smell:
                Text(cheiro.rawValue.capitalized)
            case .skin:
                Text(pele.rawValue.capitalized)
            case .service:
                Text(atendimento.rawValue.capitalized)
            }
            
            SearchBar(searchText: $viewModel.searchText) {
                viewModel.updateFiltered()
            }
            
            if viewModel.searchText == "" {
                VStack(alignment: .leading,spacing: 16) {
                    ForEach(Letters.shared.allLetters, id: \.description) { letter in
                        if viewModel.hasContact(letter: letter) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(letter)
                                    .foregroundStyle(.verde)
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    ForEach(viewModel.listFromLetter(letter: letter), id: \.contactInfo.identifier) { contact in
                                        ContactCard(contact: viewModel.getBinding(contact: contact), background: "light", color: .white) {
                                            viewModel.selectContact(contact: contact)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                ForEach(viewModel.searchContacts, id: \.identifier) { client in
                    ContactCard(contact: viewModel.getBinding(contact: client), background: "light", color: .white) {
                        viewModel.selectContact(contact: client)
                    }
                }
            }
            
            BLButton(symbol: "checkmark", text: "Concluir", disabled: false, opposite: false, color: .verde, textColor: .branco) {
                viewModel.saveData(cheiro: cheiro, pele: pele, atendimento: atendimento)
                RouterService.shared.hideSheet()
            }
        }
        .padding(.horizontal, 32)
        .onAppear {
            viewModel.filterContacts(cheiro: cheiro, pele: pele, atendimento: atendimento)
        }
    }
}

#Preview {
    ClientSheetView(viewModel: PreferencesViewModel(), preferenceType: .service)
}
