//
//  PreferencesViewModel.swift
//  mini3
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI

class PreferencesViewModel: ObservableObject {
    @Published var allClients = ClientDataSource.shared.allClients
    
    @Published var filteredContacts = [Contact]()
    
    // Funções pra Manter a Lista de Contatos
    
    func filterContacts(cheiro: Cheiro) {
        for client in allClients {
            if !client.preferences.cheiro.contains(cheiro) {
                let contact = Contact(contactInfo: client.contactInfo, isSelected: false)
                filteredContacts.append(contact)
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
    
    func saveData(cheiro: Cheiro) {
        let selectedContacts = filteredContacts.filter { c in
            c.isSelected
        }
        
        for contact in selectedContacts {
            let contactInfo = contact.contactInfo
            
            for (index,client) in allClients.enumerated() {
                if client.contactInfo == contactInfo {
                    allClients[index].preferences.cheiro.append(cheiro)
                }
            }
        }
        
        ClientDataSource.shared.allClients = allClients
        print(ClientDataSource.shared.allClients)
    }
}
