//
//  ContactViewModel.swift
//  mini3
//
//  Created by Henrique Semmer on 30/10/23.
//

import SwiftUI
import Contacts

class ContactViewModel: ObservableObject {
    @Published var phoneContacts = [InitialContact]()
    
    func getContactList() {
        let CNStore = CNContactStore()
        
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            do {
                let keys = [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor]
                let request = CNContactFetchRequest(keysToFetch: keys)
                try CNStore.enumerateContacts(with: request, usingBlock: { contact, _ in
                    let newContact = InitialContact(contactInfo: contact, isSelected: false)
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
    }
    
    func selectContact(contact: InitialContact) {
        let index = phoneContacts.firstIndex { c in
            return c.contactInfo.identifier == contact.contactInfo.identifier
        }
        
        phoneContacts[index!].isSelected.toggle()
    }
    
    func getBinding(contact: InitialContact) -> Binding<InitialContact?> {
        let b = Binding<InitialContact?> {
            contact
        } set: { v in
            if let v {
                let index = self.phoneContacts.firstIndex(of: contact)!
                self.phoneContacts[index] = v
            }
        }
        
        return b
    }
    
    func saveData() {
        let savedContacts = phoneContacts.filter { c in
            c.isSelected
        }
        
        for i in savedContacts {
            let newContact = Contact(contactInfo: i.contactInfo, preferences: Preferences.none)
            ContactDataSource.shared.allClients.append(newContact)
        }
        
        print(ContactDataSource.shared.allClients)
    }
}
