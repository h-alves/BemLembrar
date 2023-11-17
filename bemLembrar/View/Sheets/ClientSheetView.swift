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
        VStack(spacing: 32) {
            SheetLine()
            
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    switch preferenceType {
                    case .smell:
                        Text("Fragância \(cheiro.rawValue.capitalized)")
                            .foregroundStyle(.verde)
                            .font(.title)
                            .fontWeight(.bold)
                    case .skin:
                        Text("Pele \(pele.rawValue.capitalized)")
                            .foregroundStyle(.verde)
                            .font(.title)
                            .fontWeight(.bold)
                    case .service:
                        Text("Atendimento por \(atendimento.rawValue.capitalized)")
                            .foregroundStyle(.verde)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                    SearchBar(searchText: $viewModel.searchText) {
                        viewModel.updateFiltered()
                    }
                }
                
                VStack(spacing: 24) {
                    ScrollView {
                        if viewModel.searchText == "" {
                            VStack(spacing: 16) {
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
                    }
                    .scrollIndicators(.hidden)
                    
                    BLButton(symbol: "checkmark", text: "Concluir", disabled: false, opposite: false, color: .verde, textColor: .branco) {
                        viewModel.saveData(cheiro: cheiro, pele: pele, atendimento: atendimento)
                        RouterService.shared.hideSheet()
                    }
                }
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 32)
        .background(.branco)
        .onAppear {
            viewModel.filterContacts(cheiro: cheiro, pele: pele, atendimento: atendimento)
        }
    }
}

#Preview {
    ClientSheetView(viewModel: PreferencesViewModel(), preferenceType: .service)
}
