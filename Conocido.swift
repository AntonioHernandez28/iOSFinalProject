//
//  Conocido.swift
//  
//
//  Created by Erick Ramirez on 10/05/20.
//

import UIKit
import Contacts

class Conocido {
  let firstName: String
  let lastName: String
  let workEmail: String
  var identifier: String?
  let profilePicture: UIImage?
  var storedContact: CNMutableContact?
  var phoneNumberField: (CNLabeledValue<CNPhoneNumber>)?
  
  init(firstName: String, lastName: String, workEmail: String, profilePicture: UIImage?){
    self.firstName = firstName
    self.lastName = lastName
    self.workEmail = workEmail
    self.profilePicture = profilePicture
  }
  
  static func defaultContacts() -> [Conocido] {
    return [
      Conocido(firstName: "Mic", lastName: "Pringle", workEmail: "mic@example.com", profilePicture: UIImage(named: "MicProfilePicture")),
      Conocido(firstName: "Ray", lastName: "Wenderlich", workEmail: "ray@example.com", profilePicture: UIImage(named: "RayProfilePicture")),
      Conocido(firstName: "Sam", lastName: "Davies", workEmail: "sam@example.com", profilePicture: UIImage(named: "SamProfilePicture")),
      Conocido(firstName: "Greg", lastName: "Heo", workEmail: "greg@example.com", profilePicture: UIImage(named: "GregProfilePicture"))]
  }
}

extension Conocido: Equatable {
  static func ==(lhs: Conocido, rhs: Conocido) -> Bool{
    return lhs.firstName == rhs.firstName &&
      lhs.lastName == rhs.lastName &&
      lhs.workEmail == rhs.workEmail &&
      lhs.profilePicture == rhs.profilePicture
  }
}

extension Conocido {
  var contactValue: CNContact {
    let contact = CNMutableContact()
    contact.givenName = firstName
    contact.familyName = lastName
    contact.emailAddresses = [CNLabeledValue(label: CNLabelWork, value: workEmail as NSString)]
    if let profilePicture = profilePicture {
      let imageData = profilePicture.jpegData(compressionQuality: 1)
      contact.imageData = imageData
    }
    if let phoneNumberField = phoneNumberField {
      contact.phoneNumbers.append(phoneNumberField)
    }
    return contact.copy() as! CNContact
  }
  
  convenience init?(contact: CNContact) {
    guard let email = contact.emailAddresses.first else { return nil }
    let firstName = contact.givenName
    let lastName = contact.familyName
    let workEmail = email.value as String
    var profilePicture: UIImage?
    if let imageData = contact.imageData {
      profilePicture = UIImage(data: imageData)
    }
    self.init(firstName: firstName, lastName: lastName, workEmail: workEmail, profilePicture: profilePicture)
    if let contactPhone = contact.phoneNumbers.first {
      phoneNumberField = contactPhone
    }
  }
}
