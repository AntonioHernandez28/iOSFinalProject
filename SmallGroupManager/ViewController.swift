//
//  ViewController.swift
//  SmallGroupManager
//
//  Created by Antonio Hernández Ruiz on 06/04/20.
//  Copyright © 2020 Antonio Hernández Ruiz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseCore

class ViewController: UIViewController {
    
    @IBOutlet weak var loginEmailField: UITextField!
    @IBOutlet weak var loginPasswordField: UITextField!
    var currID: String!

    @IBOutlet weak var loginButton: UIButton!
    var CurrentUser = User(id: "", nombre: "", ap: "", email: "", youth: "")
    var ref:DatabaseReference = Database.database().reference() //this will give you a ref for database
    

    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
@IBAction func LoginButton(_ sender: UIButton) {
        loginButton.isEnabled = false
        if self.loginEmailField.text == "" || self.loginPasswordField.text == "" {
                  let alertController = UIAlertController(title: "Error", message: "Por favor introduce email y contraseña", preferredStyle: .alert)
                  
                  let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                  alertController.addAction(defaultAction)
                  
                  self.present(alertController, animated: true, completion: nil)
                  
              } else {
                  print(loginEmailField.text!)
                  print(loginPasswordField.text!)
                  Auth.auth().signIn(withEmail: self.loginEmailField.text!, password: self.loginPasswordField.text!) { (user, error) in
                    
              //3.
                      
                      if error == nil {
                        //print("TEST")
                        self.check() { (isSucceeded) in
                            if isSucceeded {
                                //it exists, do something
                                self.performSegue(withIdentifier: "home", sender: nil)
                                
                            } else {
                                //user does not exist, do something else
                                
                                self.performSegue(withIdentifier: "UserProfile", sender: self)
                            }
                        }
                        
                      } else {
              //4.
                          let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                          
                          let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                          alertController.addAction(defaultAction)
                          
                          self.present(alertController, animated: true, completion: nil)
                          print("Return false")
                      }
                  }

              }
    loginButton.isEnabled = true

    }
    
    
    
    func check(completion: @escaping (Bool) -> Void){
        //print("ebtr check func")
        let userID = Auth.auth().currentUser?.uid
        currID = userID
        print(userID!)
        let db = Firestore.firestore()
        let docRef = db.collection("usuarios").document(userID!)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                let data = document.data()
                let nombre = data!["Nombre"] as? String ?? ""
                let apellido = data!["Apellido"] as? String ?? ""
                let youth = data!["Youth"] as? String ?? ""
                
                self.CurrentUser.userID = userID!
                self.CurrentUser.Nombre = nombre
                self.CurrentUser.Apellido = apellido
                self.CurrentUser.Yth = youth
                
                print(self.CurrentUser.Nombre)
                print(self.CurrentUser.Apellido)
                print(self.CurrentUser.Yth)
                completion(true)
                
            } else {
                print("No hay info de user")
                completion(false)
            }
        }
            
    }
    
    @IBAction func SignUpButton(_ sender: UIButton) {

        //1.
         let alert = UIAlertController(title: "Nuevo Usuario",
                                       message: "Introduce tus datos por favor",
                                       preferredStyle: .alert)
         //2.
         let saveAction = UIAlertAction(title: "Guardar",
                                        style: .default) { action in
                                         let emailField = alert.textFields![0]
                                         let passwordField = alert.textFields![1]
                                         //3.
                                            Auth.auth().createUser(withEmail: emailField.text!,
                                                                    password: passwordField.text!) { user, error in
                                         }
         }
         //4.
         let cancelAction = UIAlertAction(title: "Cancelar",
                                          style: .default)
         //5.
         alert.addTextField { textEmail in
             textEmail.placeholder = "Correo"
         }
         alert.addTextField { textPassword in
             textPassword.isSecureTextEntry = true
             textPassword.placeholder = "Contraseña"
         }
         //6.
         alert.addAction(saveAction)
         alert.addAction(cancelAction)
         //7.
         present(alert, animated: true, completion: nil)
 
    }
    
    // MARK: - Navigation

       // In a storyboard-based application, you will often want to do a little preparation before navigation
    
     
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if(segue.identifier == "home"){
        let barViewControllers = segue.destination as! UITabBarController
        let nav = barViewControllers.viewControllers![0] as! UINavigationController
        let destino = nav.topViewController as! ViewControllerHome
        destino.UserLoged = CurrentUser
    }
    else {
        let vistaProfile = segue.destination as! ViewControllerProfile
        print("USERID: " + CurrentUser.userID)
        vistaProfile.currentId = currID
    }
        
}

        
}

