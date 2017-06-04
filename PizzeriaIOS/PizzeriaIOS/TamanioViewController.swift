//
//  TamanioViewController.swift
//  PizzeriaIOS
//
//  Created by Carlos on 02/06/2017.
//  Copyright © 2017 Woowrale. All rights reserved.
//

import UIKit
import os.log

class TamanioViewController: UITableViewController {
    
    var pizza = Pizza()
    var rowTamanioSelected: String = "";
    
    let tamanioTitle = "Tamaño de Pizza"
    let tamanios = ["", "Pequeña", "Mediana", "Grande", "Familiar"]
    
    @IBOutlet weak var masaButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        masaButton.isEnabled = false
        
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
        return tamanios.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTamanio = tableView.dequeueReusableCell(withIdentifier: "LabelCellTamanio", for: indexPath)
        cellTamanio.textLabel?.text = tamanios[indexPath.row]
        
        return cellTamanio
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tamanioTitle
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowTamanioSelected = tamanios[indexPath.row]
        if(rowTamanioSelected != ""){
            masaButton.isEnabled = true
        }else{
            masaButton.isEnabled = false
        }
        print(rowTamanioSelected)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === masaButton else {
            os_log("No se ha presionado el boton masa", log: OSLog.default, type: .debug)
            return
        }
        
        let navigation: UINavigationController = segue.destination as! UINavigationController
        let nextView: MasaViewController = navigation.topViewController as! MasaViewController;
        pizza.tamanio = rowTamanioSelected
        nextView.pizza = pizza
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
