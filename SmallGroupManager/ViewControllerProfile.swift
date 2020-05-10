//
//  ViewControllerProfile.swift
//  SmallGroupManager
//
//  Created by Antonio Hernández Ruiz on 08/04/20.
//  Copyright © 2020 Antonio Hernández Ruiz. All rights reserved.
//

import UIKit
import Firebase

class ViewControllerProfile: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    @IBOutlet weak var picker: UIPickerView!
    var currentId : String!
    var UserCurr: User = User(id: "", nombre: "", ap: "", youth: "")
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var ApellidoField: UITextField!
    let arrayYouths = ["Lincon", "Zona Tec", "Mitras", "San Pedro"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayYouths.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayYouths[row]
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        picker.setValue(UIColor.white, forKey: "textColor")
        print("LLEGÓ: " + currentId!)

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func guardarButton(_ sender: UIButton) {
        let db = Firestore.firestore()
        let indexSelected = picker.selectedRow(inComponent: 0)
        print("Llego aki")
        self.UserCurr.userID = self.currentId!
        self.UserCurr.Nombre = self.nameField.text!
        self.UserCurr.Apellido = self.ApellidoField.text!
        self.UserCurr.Yth = self.arrayYouths[indexSelected]
        print("Youth: " + self.UserCurr.Yth)
        db.collection("usuarios").document(currentId!).setData([
            "Nombre" : nameField.text!,
            "Apellido" : ApellidoField.text!,
            "Youth" : arrayYouths[indexSelected]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")

            }
        }
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let barViewControllers = segue.destination as! UITabBarController
        let nav = barViewControllers.viewControllers![0] as! UINavigationController
        let destino = nav.topViewController as! ViewControllerHome
        destino.UserLoged = UserCurr
        print("entro al prepare")
        
    }


}
