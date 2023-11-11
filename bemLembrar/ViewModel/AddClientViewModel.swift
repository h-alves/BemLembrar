//
//  AddClientViewModel.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 30/10/23.
//

import SwiftUI
import Contacts

class AddClientViewModel: ObservableObject {
    @Published var denied = false
    
    @Published var isPresented = false
    
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
    
    @Published var number = ""
    @Published var givenName = ""
    @Published var familyName = ""
    @Published var birthday = Date()
    @Published var street = ""
    @Published var city = ""
    @Published var state = ""
    
    // Funções de Criar as Listas
    
    func getContactList() {
        let CNStore = CNContactStore()
        
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            print("authorized")
            denied = false
            do {
                // Elementos que o Contacts retorna
                let keys = [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactBirthdayKey as CNKeyDescriptor, CNContactPostalAddressesKey as CNKeyDescriptor]
                let request = CNContactFetchRequest(keysToFetch: keys)
                
                try CNStore.enumerateContacts(with: request, usingBlock: { contact, _ in
                    let newContact = Contact(contactInfo: contact, identifier: contact.identifier, isSelected: false)
                    phoneContacts.append(newContact)
                })
            }catch {
                print("Error on contact fetching \(error)")
            }
            print(denied)
        case .denied:
            print("denied")
            self.denied = true
        case .notDetermined:
            print("notDetermined")
            CNStore.requestAccess(for: .contacts) { granted, error in
                if granted {
                    self.getContactList()
                } else if let error = error {
                    self.denied = true
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
                client.identifier == contact.contactInfo.identifier
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
    
    func addContact() {
        if number != "" && givenName != "" {
            let contact = CNMutableContact()
            
            contact.phoneNumbers = [CNLabeledValue(
                label: CNLabelPhoneNumberiPhone,
                value: CNPhoneNumber(stringValue: number))]
            
            contact.givenName = givenName
            if familyName != "" {
                contact.familyName = familyName
            }
            
            let calendar = Calendar.current
            if calendar.dateComponents([.day,.month,.year], from: birthday) != calendar.dateComponents([.day,.month,.year], from: Date()) {
                print(calendar.dateComponents([.day,.month,.year], from: birthday))
                contact.birthday = calendar.dateComponents([.day,.month,.year], from: birthday)
            }
            
            if street != "" || city != "" || state != "" {
                let homeAddress = CNMutablePostalAddress()
                homeAddress.street = street
                homeAddress.city = city
                homeAddress.state = state
                contact.postalAddresses = [CNLabeledValue(label: CNLabelHome, value: homeAddress)]
            }
            
            let c = Contact(contactInfo: contact, identifier: contact.identifier, isSelected: true)
            
            phoneContacts.append(c)
            manualContacts.append(c)
            
            number = ""
            givenName = ""
            familyName = ""
            birthday = Date()
            street = ""
            city = ""
            state = ""
            
            sortContact()
            updateList()
        } else {
            print("ERRO - Número e/ou nome incompleto")
        }
    }
    
    // Funções de Salvar
      
    func saveData() {
        let savedContacts = phoneContacts.filter { c in
            c.isSelected
        }
        
        for i in savedContacts {
            var address = ""
            if !i.contactInfo.postalAddresses.isEmpty {
                address = i.contactInfo.postalAddresses[0].value.formatAddress()
            }
            
            let newClient = Client(contactInfo: i.contactInfo, identifier: i.contactInfo.identifier, fullName: (i.contactInfo.givenName + " " + i.contactInfo.familyName).removeClient(), birthday: i.contactInfo.birthday?.createDate(), address: address, preferences: Preferences.none, annotation: "")
            ClientDataSource.shared.allClients.append(newClient)
            
            if newClient.birthday != nil {
                // Agendando notificação pro aniversário da pessoa
                NotificationManager.shared.scheduleNotification(fullName: newClient.fullName, date: newClient.birthday!.getMonthDay(), repeats: true)
            }
        }
        
        // print(ClientDataSource.shared.allClients)
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
