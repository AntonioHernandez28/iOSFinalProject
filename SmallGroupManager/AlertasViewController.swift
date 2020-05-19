//
//  AlertasViewController.swift
//  SmallGroupManager
//
//  Created by Erick Ramirez on 10/05/20.
//  Copyright © 2020 Antonio Hernández Ruiz. All rights reserved.
//

import UIKit

class AlertasViewController: UIViewController {

  
    @IBOutlet weak var btnSospecha: UIButton!
    @IBOutlet weak var btnCrimen: UIButton!
    @IBOutlet weak var btnMedico: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Alertas"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func enviarAlerta(_ sender: UIButton) {
        var type: String
        if(sender.isEqual(btnCrimen)){
            type = "Alerta Criminal"
        }
        else{
            if(sender.isEqual(btnMedico)){
                type = "Alerta Medica"
            }
            else{
                type = "Actividad Sospechosa"
            }
        }
        
        let alertOne = UIAlertController(title: "Confirme alerta", message: "Esta seguro de enviar una alerta de tipo \(type)?", preferredStyle: .alert)
        
        alertOne.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alertOne.addAction(UIAlertAction(title: "Si", style: .default, handler: { action in
            var desc = ""
            
            if(type != "Alerta Criminal"){
                let captureDesc = UIAlertController(title: "Describa que ocurre:", message: nil, preferredStyle: .alert)
                
                captureDesc.addTextField(configurationHandler: { textField in
                    textField.placeholder = "¿Qué esta pasando?"
                })
                
                captureDesc.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    if let name = captureDesc.textFields?.first?.text {
                        desc = name
                    }
                    
                    //Falta agregar localizacion del usuario y enviar alerta
                    var newAlert = Alerta (tipo: type, localizacion: "", descripcion: desc)
                    
                    let alertTwo = UIAlertController(title: "\(type) en curso", message: "Presione el botón cancelar para terminar la alerta, de lo contrario continuará activa.", preferredStyle: .alert)
                    
                    alertTwo.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { action in
                        //Eliminar alerta
                    }))
                    
                    self.present(alertTwo, animated: true)
                }))
                
                self.present(captureDesc, animated: true)
            }
            else{
                //Falta agregar localizacion del usuario y enviar alerta
                var newAlert = Alerta (tipo: type, localizacion: "", descripcion: desc)
                
                let alertTwo = UIAlertController(title: "\(type) en curso", message: "Presione el botón cancelar para terminar la alerta, de lo contrario continuará activa.", preferredStyle: .alert)
                
                alertTwo.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { action in
                    //Eliminar alerta
                }))
                
                self.present(alertTwo, animated: true)
            }
        }))
        
        
        
        self.present(alertOne, animated: true)
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
