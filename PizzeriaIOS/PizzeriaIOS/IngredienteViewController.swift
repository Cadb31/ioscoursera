//
//  IngredienteViewController.swift
//  PizzeriaIOS
//
//  Created by Carlos on 02/06/2017.
//  Copyright © 2017 Woowrale. All rights reserved.
//

import UIKit
import os.log

class IngredienteViewController: UITableViewController {
    
    var pizza = Pizza()

    let ingredienteTitle = "Tipos de Ingredientes"
    let ingredientes = ["", "Jamon", "Pepperoni", "Pavo", "Salchicha", "Aceitunas", "Cebolla", "Pimiento", "Piña", "Carne", "Chorizo", "Champiñones"]

    @IBOutlet weak var pagoButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pagoButton.isEnabled = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ingredientes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTamanio = tableView.dequeueReusableCell(withIdentifier: "LabelCellIngredientes", for: indexPath)
        cellTamanio.textLabel?.text = ingredientes[indexPath.row]
        
        return cellTamanio
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ingredienteTitle
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .checkmark
        pizza.ingredientes.append(ingredientes[indexPath.row])

        if(pizza.ingredientes.count >= 5){
            pagoButton.isEnabled = true
        }else{
            pagoButton.isEnabled = false
        }
    }    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .none
        var c = 0
        for i in pizza.ingredientes {
            if i == ingredientes[indexPath.row]{
                pizza.ingredientes.remove(at: c)
            }
            c = c + 1;
        }
        
        if(pizza.ingredientes.count >= 5){
            pagoButton.isEnabled = true
        }else{
            pagoButton.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === pagoButton else {
            os_log("No se ha presionado el boton masa", log: OSLog.default, type: .debug)
            return
        }
        
        let navigation: UINavigationController = segue.destination as! UINavigationController
        
        if button == pagoButton{
            let nextView: PagoViewController = navigation.topViewController as! PagoViewController
            for i in pizza.ingredientes{
                print(i)
            }
            nextView.pizza = pizza
        }else{
            let backView: QuesoViewController = navigation.topViewController as! QuesoViewController;
            backView.pizza = pizza
        }
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
