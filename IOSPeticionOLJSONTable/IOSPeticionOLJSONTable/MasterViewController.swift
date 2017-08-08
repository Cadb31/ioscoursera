//
//  MasterViewController.swift
//  IOSPeticionOLJSONTable
//
//  Created by Carlos on 13/07/2017.
//  Copyright © 2017 Woowrale. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    let TEXT_VOID = ""
    let TEXT_INSERT_ISBN = "Insert ISBN:"
    let TEXT_SHOW_DETAILS = "showDetail"
    let TEXT_INSERT_SHOW_DETAILS = "insertShowDetail"
    let TEXT_EXCEPTION_CONNECTION = "Se ha producido una excepción en la comunicación."
    let TEXT_EXCEPTION_TEXTFIELD_VOID = "No se ha encontrado ningun libro con el ISBN: "
    let jsonConnection = JSONCOnnection()
    
    var activityIndicator: UIActivityIndicatorView! = nil
    var json = JSONCOnnection()
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge, color: .gray,  placeInTheCenterOf: tableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func insertNewBook(_ sender: Any?) {
        self.activityIndicator.startAnimating()        
        let inputBoxMessage = UIAlertController(title: "OpenLibrary", message: TEXT_INSERT_ISBN, preferredStyle: UIAlertControllerStyle.alert)
        inputBoxMessage.addTextField(configurationHandler: textFieldHandler(textField:))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {action in print("Cancel")})
        let searchAction = UIAlertAction(title: "Search", style: .default, handler: {action in
            let isbnCode = inputBoxMessage.textFields!.first!.text!
            
            let book = self.getBookData(isbnCode: isbnCode)
            if(book.title != nil){
                print("Title: ", book.title)
                
                let context = self.fetchedResultsController.managedObjectContext
                let bookEvent = BookEntity(context: context)
                
                // If appropriate, configure the new managed object.
                bookEvent.title = book.title
                for author in book.authors{
                    print("Authors: ", author)
                    bookEvent.authors = author
                }
                if(book.image != nil){
                    bookEvent.image = book.image
                }else{
                    bookEvent.image = nil
                }
                // Save the context.
                do{
                    try context.save()
                    self.performSegue(withIdentifier: self.TEXT_INSERT_SHOW_DETAILS, sender: book)
                }catch{
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        })
        
        inputBoxMessage.addAction(cancelAction)
        inputBoxMessage.addAction(searchAction)
        
        present(inputBoxMessage, animated: true, completion: nil)
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TEXT_SHOW_DETAILS {
            if let indexPath = tableView.indexPathForSelectedRow {
            let bookEntity = fetchedResultsController.object(at: indexPath)
            let bookDetails = Book()
                bookDetails.title = bookEntity.title as String!
                bookDetails.authors.append(bookEntity.authors as String!)
                
                let imgObject = bookEntity.image as NSObject!
                if(imgObject != nil){
                    bookDetails.image = imgObject as! UIImage
                }
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.bookDetails = bookDetails
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }else if(segue.identifier == TEXT_INSERT_SHOW_DETAILS){
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.bookDetails = sender as! Book
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }

    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let bookEvent = fetchedResultsController.object(at: indexPath)
        cell.textLabel!.text = bookEvent.title
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = fetchedResultsController.managedObjectContext
            context.delete(fetchedResultsController.object(at: indexPath))
                
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func configureCell(_ cell: UITableViewCell, withEvent bookEvent: BookEntity) {
        cell.textLabel!.text = bookEvent.title
    }
 
    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController<BookEntity> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
             // Replace this implementation with code to handle the error appropriately.
             // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             let nserror = error as NSError
             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController<BookEntity>? = nil

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
            case .insert:
                tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
            case .delete:
                tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
            default:
                return
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .fade)
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .fade)
            case .update:
                configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! BookEntity)
            case .move:
                configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! BookEntity)
                tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         tableView.reloadData()
     }
     */
    
    func getBookData(isbnCode: String) -> Book{
        var book = Book()
        
        if(isbnCode == self.TEXT_VOID){
            self.showAlertBox(message: self.TEXT_EXCEPTION_TEXTFIELD_VOID)
        }else{
            do{
                book = try self.json.getJsonData(codISBN: isbnCode)
                print(book.title)
                if(book.title == nil){
                    self.showAlertBox(message: self.TEXT_EXCEPTION_TEXTFIELD_VOID + isbnCode)
                }
            }catch{
                self.showAlertBox(message: self.TEXT_EXCEPTION_CONNECTION)
                print("Exception in method: getBookData")
            }
        }
        self.activityIndicator.stopAnimating()
        return book
    }
    
    
    func showAlertBox(message: String){
        let alertMessage = UIAlertController(title: "Conexion OpenLibrary", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertMessage.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default,handler: nil))
        present(alertMessage, animated: true, completion: nil)
    }
    
    func textFieldHandler(textField: UITextField!){
        if (textField) != nil {
            textField.placeholder = "ISBN"
        }
    }
}

extension UIActivityIndicatorView {
    
    convenience init(activityIndicatorStyle: UIActivityIndicatorViewStyle, color: UIColor, placeInTheCenterOf parentView: UIView) {
        self.init(activityIndicatorStyle: activityIndicatorStyle)
        center = parentView.center
        self.color = color
        parentView.addSubview(self)
    }
}

