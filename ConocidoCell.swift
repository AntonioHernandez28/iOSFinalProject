//
//  ConocidoCell.swift
//  
//
//  Created by Erick Ramirez on 10/05/20.
//

//
//  ConocidoCell.swift
//  SmallGroupManager
//
//  Created by Erick Ramirez on 10/05/20.
//  Copyright © 2020 Antonio Hernández Ruiz. All rights reserved.
//

import UIKit
import Contacts

class ConocidoCell: UITableViewCell {
  @IBOutlet private weak var contactNameLabel: UILabel!
  @IBOutlet private weak var contactEmailLabel: UILabel!
//  @IBOutlet private weak var contactImageView: UIImageView! {
//    didSet {
//      contactImageView.layer.masksToBounds = true
//      contactImageView.layer.cornerRadius = 22.0
//    }
//  }
  
  var conocido : Conocido? {
    didSet {
      configureCell()
    }
  }
  
  private func configureCell() {
    let formatter = CNContactFormatter()
    formatter.style = .fullName
    guard let conocido = conocido,
      let name = formatter.string(from: conocido.contactValue) else { return }
    contactNameLabel.text = name
    contactEmailLabel.text = conocido.workEmail
//    contactImageView.image = conocido.profilePicture ?? UIImage(named: "PlaceholderProfilePic")
  }
}
