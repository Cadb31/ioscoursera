//
//  QuesoViewController.swift
//  PizzeriaIOS
//
//  Created by Carlos on 02/06/2017.
//  Copyright © 2017 Woowrale. All rights reserved.
//

import UIKit
import os.log

class QuesoViewController: UITableViewController {
    
    var pizza = Pizza()
    var rowQuesoSelected = ""
    
    let quesoTitle = "Tipo de Queso"
    let quesos = ["", "Mozarela", "Cheddar", "Parmesano", "Sin queso"]

    @IBOutlet weak var ingredientesButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientesButton.isEnabled = false

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
        return quesos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTamanio = tableView.dequeueReusableCell(withIdentifier: "LabelCellQueso", for: indexPath)
        cellTamanio.textLabel?.text = quesos[indexPath.row]
        
        return cellTamanio
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return quesoTitle
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowQuesoSelected = quesos[indexPath.row]
        
        if(rowQuesoSelected != ""){
            ingredientesButton.isEnabled = true
        }else{
            ingredientesButton.isEnabled = false
        }
        
        print(rowQuesoSelected)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === ingredientesButton else {
            os_log("No se ha presionado el boton masa", log: OSLog.default, type: .debug)
            return
        }
        
        let navigation: UINavigationController = segue.destination as! UINavigationController
        
        if button == ingredientesButton{
            let nextView: IngredienteViewController = navigation.topViewController as! IngredienteViewController
            pizza.queso = rowQuesoSelected
            nextView.pizza = pizza
        }else{
            let backView: MasaViewController = navigation.topViewController as! MasaViewController;
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
