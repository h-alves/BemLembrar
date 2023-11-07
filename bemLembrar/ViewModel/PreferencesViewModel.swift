//
//  PreferencesViewModel.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

class PreferencesViewModel: ObservableObject {
    @Published var allClients = ClientDataSource.shared.allClients
    
    @Published var filteredContacts = [Contact]()
    
    // Funções pra Manter a Lista de Contatos
    
    func filterContacts(cheiro: Cheiro, pele: Pele, atendimento: Atendimento) {
        for client in allClients {
            if cheiro != .none {
                if !client.preferences.cheiro.contains(cheiro) {
                    let contact = Contact(contactInfo: client.contactInfo, isSelected: false)
                    filteredContacts.append(contact)
                }
            } else if pele != .normal {
                if client.preferences.pele != pele {
                    let contact = Contact(contactInfo: client.contactInfo, isSelected: false)
                    filteredContacts.append(contact)
                }
            } else if atendimento != .none {
                if client.preferences.atendimento != atendimento {
                    let contact = Contact(contactInfo: client.contactInfo, isSelected: false)
                    filteredContacts.append(contact)
                }
            }
        }
    }
    
    func updateList() {
        filteredContacts = filteredContacts
    }
    
    // Funções de Selecionar Contatos
    
    func selectContact(contact: Contact) {
        let index = filteredContacts.firstIndex { c in
            return c.contactInfo.identifier == contact.contactInfo.identifier
        }
        
        filteredContacts[index!].isSelected.toggle()
        
        updateList()
    }
    
    func getBinding(contact: Contact) -> Binding<Contact?> {
        let b = Binding<Contact?> {
            contact
        } set: { v in
            if let v {
                let index = self.filteredContacts.firstIndex(of: contact)!
                self.filteredContacts[index] = v
            }
        }
        
        return b
    }
    
    // Funções de Salvar
    
    func saveData(cheiro: Cheiro, pele: Pele, atendimento: Atendimento) {
        let selectedContacts = filteredContacts.filter { c in
            c.isSelected
        }
        
        for contact in selectedContacts {
            let contactInfo = contact.contactInfo
            
            for (index,client) in allClients.enumerated() {
                if client.contactInfo == contactInfo {
                    if cheiro != .none {
                        allClients[index].preferences.cheiro.append(cheiro)
                    } else if pele != .normal {
                        allClients[index].preferences.pele = pele
                    } else if atendimento != .none {
                        allClients[index].preferences.atendimento = atendimento
                    }
                }
            }
        }
        
        ClientDataSource.shared.allClients = allClients
    }
}