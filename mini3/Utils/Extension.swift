//
//  Extension.swift
//  mini3
//
//  Created by Henrique Semmer on 31/10/23.
//

import UIKit
import Contacts

extension CNMutableContact {
    
    // Creating a contact for testing in previews
    func createTestContact() -> CNMutableContact {
        let contact = CNMutableContact()
        
        let image = UIImage(systemName: "person.crop.circle")
        contact.imageData = image?.jpegData(compressionQuality: 1.0)


        contact.givenName = "John"
        contact.familyName = "Appleseed"


        let homeEmail = CNLabeledValue(label: CNLabelHome, value: "john@example.com" as NSString)
        let workEmail = CNLabeledValue(label: CNLabelWork, value: "j.appleseed@icloud.com" as NSString)
        contact.emailAddresses = [homeEmail, workEmail]


        contact.phoneNumbers = [CNLabeledValue(
        label: CNLabelPhoneNumberiPhone,
        value: CNPhoneNumber(stringValue: "(408) 555-0126"))]


        let homeAddress = CNMutablePostalAddress()
        homeAddress.street = "One Apple Park Way"
        homeAddress.city = "Cupertino"
        homeAddress.state = "CA"
        homeAddress.postalCode = "95014"
        contact.postalAddresses = [CNLabeledValue(label: CNLabelHome, value: homeAddress)]


        var birthday = DateComponents()
        birthday.day = 1
        birthday.month = 4
        birthday.year = 1988
        contact.birthday = birthday
        
        return contact
    }
}
