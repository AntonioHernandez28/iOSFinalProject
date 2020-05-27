//
//  EditConocidoTableViewCell.swift
//  
//
//  Created by Erick Ramirez on 11/05/20.
//

import UIKit
import Contacts

class EditConocidoTableViewController: UITableViewController {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet weak private var phoneTypeLabel: UILabel!
    @IBOutlet weak private var phoneTextField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    
  var conocido: Conocido?

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    
  }

  private func setup() {
    guard let conocido = conocido else {
      nameLabel.text = ""
      emailLabel.text = ""
      phoneTextField.text = ""
      phoneTextField.isEnabled = true
      return
    }
    let formatter = CNContactFormatter()
    formatter.style = .fullName
    if let name = formatter.string(from: conocido.contactValue) {
      nameLabel.text = name
    } else {
      nameLabel.text = "Nombre no disponible"
    }
    emailLabel.text = conocido.workEmail
    if let phoneNumberField = conocido.phoneNumberField,
      let label = phoneNumberField.label {
      phoneTypeLabel.text = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
      phoneTextField.text = phoneNumberField.value.stringValue
    }
  }

    @IBAction func save(_ sender: Any) {
    phoneTextField.resignFirstResponder()
        let store = CNContactStore()
        guard
          let conocido = conocido,
          let phoneNumberText = phoneTextField.text
          else { return }
        let phoneNumberValue = CNPhoneNumber(stringValue: phoneNumberText)
        let saveRequest = CNSaveRequest()
    if let storedContact = conocido.storedContact,
      let phoneNumberToEdit = storedContact.phoneNumbers.first(
        where: { $0 == conocido.phoneNumberField }
      ),
      let index = storedContact.phoneNumbers.firstIndex(of: phoneNumberToEdit) {
      // 1
      let newPhoneNumberField = phoneNumberToEdit.settingValue(phoneNumberValue)
      storedContact.phoneNumbers.remove(at: index)
      storedContact.phoneNumbers.insert(newPhoneNumberField, at: index)
      conocido.phoneNumberField = newPhoneNumberField
      // 2
      saveRequest.update(storedContact)
      conocido.storedContact = nil
    } else if let unsavedContact = conocido.contactValue.mutableCopy() as? CNMutableContact {
      // 3
      let phoneNumberField = CNLabeledValue(label: CNLabelPhoneNumberMain,
                                            value: phoneNumberValue)
      unsavedContact.phoneNumbers = [phoneNumberField]
      conocido.phoneNumberField = phoneNumberField
      // 4
      saveRequest.add(unsavedContact, toContainerWithIdentifier: nil)
    }
        do {
          try store.execute(saveRequest)
          let controller = UIAlertController(title: "Success",
                                             message: nil,
                                             preferredStyle: .alert)
          controller.addAction(UIAlertAction(title: "OK", style: .default))
          present(controller, animated: true)
          setup()
        } catch {
          print(error)
        }
    }
}
