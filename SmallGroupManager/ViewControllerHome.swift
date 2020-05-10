//
//  ViewControllerHome.swift
//  SmallGroupManager
//
//  Created by Antonio Hernández Ruiz on 07/04/20.
//  Copyright © 2020 Antonio Hernández Ruiz. All rights reserved.
//

import UIKit

class ViewControllerHome: UIViewController {
    
    var UserLoged: User!
    
    @IBOutlet weak var Nombre: UILabel!
    
    @IBOutlet weak var Apellido: UILabel!
    
    @IBOutlet weak var Youth: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserLoged.Nombre)
        Nombre.text = UserLoged.Nombre
        Apellido.text = UserLoged.Apellido
        Youth.text = UserLoged.Yth
        Nombre.sizeToFit()
        Apellido.sizeToFit()
        Youth.sizeToFit()
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
