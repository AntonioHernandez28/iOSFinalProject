//
//  Alerta.swift
//  SmallGroupManager
//
//  Created by Erick Ramirez on 10/05/20.
//  Copyright © 2020 Antonio Hernández Ruiz. All rights reserved.
//

import UIKit

class Alerta: NSObject {
    var tipo: String
    var localizacion: String
    var descripcion: String
    
    init(tipo: String, localizacion: String, descripcion: String){
        self.tipo = tipo
        self.localizacion = localizacion
        self.descripcion = descripcion
    }
}
