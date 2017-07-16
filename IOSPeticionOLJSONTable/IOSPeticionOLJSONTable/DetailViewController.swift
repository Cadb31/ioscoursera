//
//  DetailViewController.swift
//  IOSPeticionOLJSONTable
//
//  Created by Carlos on 13/07/2017.
//  Copyright © 2017 Woowrale. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    let TEXT_TITLE = "Title:"
    let TEXT_AUTHORS = "Authors:"
    
    var bookDetails = Book()
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthors: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    
    func configureView() {
        // Update the user interface for the detail item.
        bookTitle.text = bookDetails.title
        
        for author in bookDetails.authors{
            bookAuthors.text = author
        }
        if(bookDetails.image != nil){
            bookImage.image = bookDetails.image
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Book? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

