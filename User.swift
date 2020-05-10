//
//  User.swift
//  SmallGroupManager
//
//  Created by Antonio Hernández Ruiz on 06/04/20.
//  Copyright © 2020 Antonio Hernández Ruiz. All rights reserved.
//

import UIKit
import Foundation

class User: NSObject{
    
    var userID : String = ""
    var Nombre : String = ""
    var Apellido : String = ""
    var Yth : String = ""
    
    init(id : String, nombre : String, ap : String, youth : String){
        self.userID = id
        self.Nombre = nombre
        self.Apellido = ap
        self.Yth = youth
    }
}
