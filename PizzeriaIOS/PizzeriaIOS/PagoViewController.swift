//
//  PagoViewController.swift
//  PizzeriaIOS
//
//  Created by Carlos on 03/06/2017.
//  Copyright © 2017 Woowrale. All rights reserved.
//

import UIKit
import os.log

class PagoViewController: UIViewController {

    
    var pizza = Pizza()
    
    @IBOutlet weak var labelTamanio: UILabel!
    @IBOutlet weak var labelMasa: UILabel!
    @IBOutlet weak var labelQueso: UILabel!
    @IBOutlet weak var labelIngredientes: UILabel!
    
    @IBOutlet weak var ingredienteButton: UIBarButtonItem!
    
    var ingredientes: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        labelTamanio.text = pizza.tamanio
        labelMasa.text = pizza.masa
        labelQueso.text = pizza.queso
        for i in pizza.ingredientes{
            ingredientes.append(i + ", ")
        }
        labelIngredientes.text = ingredientes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func comprobarPago(_ sender: Any) {
        
        if(pizza.tamanio == "" || pizza.masa == "" || pizza.queso == "" || pizza.ingredientes.count < 5){
            let alertMessage = UIAlertController(title: "Pizza Menu", message:
                "Falta algun elemento para preparar su pizza. Por favor seleccionalo", preferredStyle: UIAlertControllerStyle.alert)
            alertMessage.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === ingredienteButton else {
            os_log("No se ha presionado el boton masa", log: OSLog.default, type: .debug)
            return
        }
        
        let navigation: UINavigationController = segue.destination as! UINavigationController
        let backView: IngredienteViewController = navigation.topViewController as! IngredienteViewController;
        backView.pizza = pizza
    }

}
