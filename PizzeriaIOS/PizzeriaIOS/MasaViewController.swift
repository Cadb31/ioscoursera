//
//  MasaViewController.swift
//  PizzeriaIOS
//
//  Created by Carlos on 02/06/2017.
//  Copyright © 2017 Woowrale. All rights reserved.
//

import UIKit
import os.log

class MasaViewController: UITableViewController {
    
    var pizza = Pizza()
    var rowMasaSelected: String = "";
    let masaTitle = "Tipo de Masa"
    let masas = ["", "Delgada", "Crujiente", "Gruesa", "Sin Gluten"]
    
    @IBOutlet weak var quesoButton: UIBarButtonItem!
    @IBOutlet weak var tamanioButton: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quesoButton.isEnabled = false

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
        return masas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTamanio = tableView.dequeueReusableCell(withIdentifier: "LabelCellMasa", for: indexPath)
        cellTamanio.textLabel?.text = masas[indexPath.row]
        
        return cellTamanio
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return masaTitle
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowMasaSelected = masas[indexPath.row]
        
        if(rowMasaSelected != ""){
            quesoButton.isEnabled = true
        }else{
            quesoButton.isEnabled = false
        }
        
        print(rowMasaSelected)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === quesoButton else {
            os_log("No se ha presionado el boton masa", log: OSLog.default, type: .debug)
            return
        }

        let navigation: UINavigationController = segue.destination as! UINavigationController
        
        if button == quesoButton{
            let nextView: QuesoViewController = navigation.topViewController as! QuesoViewController;
            pizza.masa = rowMasaSelected
            nextView.pizza = pizza
        }else{
            let backView: TamanioViewController = navigation.topViewController as! TamanioViewController;
            backView.pizza = pizza
        }
    }
    


    /*
    @IBAction func unwindToTamanio(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? TamanioViewController, let tamanio: String = String(sourceViewController.tamanio) {
            tamanioSelected = tamanio
        }
    }
    */
    
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
