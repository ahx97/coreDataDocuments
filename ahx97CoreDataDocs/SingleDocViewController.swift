//
//  SingleDocViewController.swift
//  ahx97CoreDataDocs
//
//  Created by Aaron Henry on 9/20/19.
//  Copyright © 2019 Aaron Henry. All rights reserved.
//

import UIKit

class SingleDocViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextView! //this should be body textView not field oops
    
    var doc: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let doc = doc {
            titleTextField.text = doc.title
            bodyTextField.text = doc.body
        }

    }
    
    @IBAction func save(_ sender: Any) {
        
        guard let title = titleTextField.text else {
            alertNotifyUser(message: "Doc not saved.\nThe title is not accessible.")
            return
        }
        
        let docTitle = title.trimmingCharacters(in: .whitespaces)
        if (docTitle == "") {
            alertNotifyUser(message: "Doc not saved.\nA title is required.")
            return
        }
        
        let body = bodyTextField.text ?? ""
        
        if doc == nil {
            // note doesn't exist, create new one
            doc = Document(title: docTitle, body: body)
        } else {
            // document exists, update existing one
            doc?.title = title
            doc?.body = body
        }
        
        if let doc = doc {
            do {
                let managedContext = doc.managedObjectContext
                try managedContext?.save()
            } catch {
                alertNotifyUser(message: "The doc context could not be saved.")
            }
        } else {
            alertNotifyUser(message: "The doc could not be created.")
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {
            (alertAction) -> Void in
            print("OK selected")
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    

}
