//
//  ContactosViewController.swift
//  SmallGroupManager
//
//  Created by Erick Ramirez on 10/05/20.
//  Copyright © 2020 Antonio Hernández Ruiz. All rights reserved.
//

import UIKit
import ContactsUI

class ContactosViewController: UITableViewController {
    var listaConocidos = Conocido.defaultContacts()
    var conocido : Conocido?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditContactoSegue",
          // 1
          let cell = sender as? ConocidoCell,
          let indexPath = tableView.indexPath(for: cell),
          let editViewController = segue.destination as? EditConocidoTableViewController {
          let contacto = listaConocidos[indexPath.row]
          // 2
          let store = CNContactStore()
          // 3
          let predicate = CNContact.predicateForContacts(matchingEmailAddress: contacto.workEmail)
          // 4
          let keys = [CNContactPhoneNumbersKey as CNKeyDescriptor]
          // 5
          if let contacts = try? store.unifiedContacts(matching: predicate, keysToFetch: keys),
            let contact = contacts.first,
            let contactPhone = contact.phoneNumbers.first {
            // 6
            contacto.storedContact = contact.mutableCopy() as? CNMutableContact
            contacto.phoneNumberField = contactPhone
            contacto.identifier = contact.identifier
          }
          editViewController.conocido = conocido
        }
    }
    
    @IBAction func addFriends(_ sender: Any) {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        // 2
        contactPicker.predicateForEnablingContact = NSPredicate(
          format: "emailAddresses.@count > 0")
        present(contactPicker, animated: true, completion: nil)
    }
}
    
    extension ContactosViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaConocidos.count
    }
}
    extension ContactosViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // 1
        let conocido = listaConocidos[indexPath.row]
        let contact = conocido.contactValue
        // 2
        let contactViewController = CNContactViewController(forUnknownContact: contact)
        contactViewController.hidesBottomBarWhenPushed = true
        contactViewController.allowsEditing = false
        contactViewController.allowsActions = false
        navigationController?.pushViewController(contactViewController, animated: true)
    }
}
    
    extension ContactosViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConocidoCell", for: indexPath)
        
        if let cell = cell as? ConocidoCell {
            let conocido = listaConocidos[indexPath.row]
            cell.conocido = conocido
        }
        return cell
    }
}

extension ContactosViewController: CNContactPickerDelegate {
  func contactPicker(_ picker: CNContactPickerViewController,
                     didSelect contacts: [CNContact]) {
    let newConocidos = contacts.compactMap { Conocido(contact: $0) }
    for conocido in newConocidos {
      if !listaConocidos.contains(conocido) {
        listaConocidos.append(conocido)
      }
    }
    tableView.reloadData()
  }
}


    



