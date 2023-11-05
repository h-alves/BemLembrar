//
//  AddClientViewModel.swift
//  mini3
//
//  Created by Henrique Semmer on 30/10/23.
//

import SwiftUI
import Contacts

class AddClientViewModel: ObservableObject {
    @Published var phoneContacts = [Contact]() {
        didSet {
            if oldValue.count != phoneContacts.count {
                sortContact()
            }
        }
    }
    @Published var autoContacts = [Contact]()
    @Published var manualContacts = [Contact]()
    
    @Published var searchText: String = ""
    
    // Funções de Criar as Listas
    
    func getContactList() {
        let CNStore = CNContactStore()
        
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            do {
                // Elementos que o Contacts retorna
                let keys = [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactBirthdayKey as CNKeyDescriptor]
                let request = CNContactFetchRequest(keysToFetch: keys)
                
                try CNStore.enumerateContacts(with: request, usingBlock: { contact, _ in
                    let newContact = Contact(contactInfo: contact, isSelected: false)
                    phoneContacts.append(newContact)
                })
            }catch {
                print("Error on contact fetching \(error)")
            }
        case .denied:
            print("denied")
        case .notDetermined:
            print("notDetermined")
            CNStore.requestAccess(for: .contacts) { granted, error in
                if granted {
                    self.getContactList()
                } else if let error = error {
                    print("Error requesting contact access: \(error)")
                }
            }
        case .restricted:
            print("restricted")
        @unknown default:
            print("")
        }
        
        /// Teste adicionando um contato na lista de clientes pra ver se não aparece na lista por já estar adicionado
        ///
        // let newClient = Client(contactInfo: phoneContacts[0].contactInfo, preferences: Preferences.none)
        // ClientDataSource.shared.allClients.append(newClient)
        
        filterContacts()
    }
    
    func filterContacts() {
        // Tem que testar
        phoneContacts = phoneContacts.filter { contact in
            !ClientDataSource.shared.allClients.contains { client in
                client.contactInfo.identifier == contact.contactInfo.identifier
            }
        }
        
        autoContacts = phoneContacts.filter { c in
            c.contactInfo.givenName.localizedCaseInsensitiveContains("cliente") || c.contactInfo.familyName.localizedCaseInsensitiveContains("cliente")
        }
        
        updateList()
    }
    
    func sortContact() {
        phoneContacts.sort { contact1, contact2 in
            let nameCompleto1 = contact1.contactInfo.givenName + contact1.contactInfo.familyName
            let nameCompleto2 = contact2.contactInfo.givenName + contact2.contactInfo.familyName
            
            return nameCompleto1.caseInsensitiveCompare(nameCompleto2) == .orderedAscending
        }
    }
    
    func updateList() {
        manualContacts = phoneContacts.filter { c in
            !autoContacts.contains(c)
        }
        
        if searchText != "" {
            manualContacts = manualContacts.filter { c in
                let completeName = (c.contactInfo.givenName + " " + c.contactInfo.familyName).lowercased()
                let textFormat = searchText.lowercased()
                
                return completeName.contains(textFormat)
            }
        }
    }
    
    // Funções de Selecionar Contatos
    
    func selectContact(contact: Contact) {
        let index = phoneContacts.firstIndex { c in
            return c.contactInfo.identifier == contact.contactInfo.identifier
        }
        
        phoneContacts[index!].isSelected.toggle()
        
        filterContacts()
    }
    
    func getBinding(contact: Contact) -> Binding<Contact?> {
        let b = Binding<Contact?> {
            contact
        } set: { v in
            if let v {
                let index = self.phoneContacts.firstIndex(of: contact)!
                self.phoneContacts[index] = v
            }
        }
        
        return b
    }
    
    // Funções de Salvar
      
    func saveData() {
        let savedContacts = phoneContacts.filter { c in
            c.isSelected
        }
        
        for i in savedContacts {
            let newClient = Client(contactInfo: i.contactInfo, fullName: i.contactInfo.givenName + " " + i.contactInfo.familyName, birthday: i.contactInfo.birthday!.createDate(), preferences: Preferences.none)
            ClientDataSource.shared.allClients.append(newClient)
        }
        
        // print(ClientDataSource.shared.allClients)
        RouterService.shared.navigate(.allClients)
    }
    
    func selectedContacts() -> String {
        let selectedList = phoneContacts.filter { c in
            c.isSelected
        }
        
        if selectedList.isEmpty {
            return ""
        }
        return " (\(selectedList.count.description))"
    }
    
    func disabled() -> Bool {
        let selectedList = phoneContacts.filter { c in
            c.isSelected
        }
        
        if selectedList.isEmpty {
            return true
        }
        return false
    }
}
