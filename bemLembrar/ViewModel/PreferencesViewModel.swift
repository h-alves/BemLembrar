//
//  PreferencesViewModel.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 05/11/23.
//

import SwiftUI
import Combine
import Contacts

class PreferencesViewModel: ObservableObject {
    @Published var allClients = [Client]()
    
    @Published var filteredContacts = [Contact]()
    
    var bag = Set<AnyCancellable>()
    
    func subscribe() {
        ClientDataSource.shared.$allClients.sink { clients in
            self.updateList()
        }.store(in: &bag)
    }
    
    func cancelSubscription() {
        for item in bag {
            item.cancel()
        }
        bag.removeAll()
    }
    
    // Funções pra Manter a Lista de Contatos
    
    func filterContacts(cheiro: Cheiro, pele: Pele, atendimento: Atendimento) {
        for client in ClientDataSource.shared.allClients {
            if cheiro != .none {
                if !client.preferences.cheiro.contains(cheiro) {
                    let contact = Contact(contactInfo: CNMutableContact().createID(identifier: client.identifier, fullName: client.fullName), identifier: client.identifier, isSelected: false)
                    filteredContacts.append(contact)
                }
            } else if pele != .normal {
                if client.preferences.pele != pele {
                    let contact = Contact(contactInfo: CNMutableContact().createID(identifier: client.identifier, fullName: client.fullName), identifier: client.identifier, isSelected: false)
                    filteredContacts.append(contact)
                }
            } else if atendimento != .none {
                if client.preferences.atendimento != atendimento {
                    let contact = Contact(contactInfo: CNMutableContact().createID(identifier: client.identifier, fullName: client.fullName), identifier: client.identifier, isSelected: false)
                    filteredContacts.append(contact)
                }
            }
        }
        print(filteredContacts)
    }
    
    func updateList() {
        allClients = ClientDataSource.shared.allClients
    }
    
    func updateFiltered() {
        filteredContacts = filteredContacts
    }
    
    // Funções de Selecionar Contatos
    
    func selectContact(contact: Contact) {
        let index = filteredContacts.firstIndex { c in
            return c.identifier == contact.identifier
        }
        
        filteredContacts[index!].isSelected.toggle()
        
        updateFiltered()
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
            let id = contact.identifier
            
            for (index,client) in ClientDataSource.shared.allClients.enumerated() {
                if client.identifier == id {
                    if cheiro != .none {
                        ClientDataSource.shared.allClients[index].preferences.cheiro.append(cheiro)
                    } else if pele != .normal {
                        ClientDataSource.shared.allClients[index].preferences.pele = pele
                    } else if atendimento != .none {
                        ClientDataSource.shared.allClients[index].preferences.atendimento = atendimento
                    }
                }
            }
        }
        
        updateList()
        ClientDataSource.shared.save()
    }
}
