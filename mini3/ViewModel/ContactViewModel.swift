//
//  ContactViewModel.swift
//  mini3
//
//  Created by Henrique Semmer on 30/10/23.
//

import Foundation
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
}
