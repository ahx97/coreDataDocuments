//
//  DocListViewController.swift
//  ahx97CoreDataDocs
//
//  Created by Aaron Henry on 9/20/19.
//  Copyright © 2019 Aaron Henry. All rights reserved.
//

import UIKit
import CoreData

class DocListViewController: UIViewController {
    
    @IBOutlet weak var docsTableView: UITableView!
    
    var documents = [Document]()
    let dateFormatter = DateFormatter()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium

    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchDocs()
        docsTableView.reloadData()
    }
    
    func fetchDocs() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Document> = Document.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)] // order results by note title ascending
        
        do {
            documents = try managedContext.fetch(fetchRequest)
        } catch {
            alertNotifyUser(message: "Fetch for docs could not be performed.")
            return
        }
    }
    
    func deleteDoc(at indexPath: IndexPath) {
        let doc = documents[indexPath.row]
        
        if let managedObjectContext = doc.managedObjectContext {
            managedObjectContext.delete(doc)
            
            do {
                try managedObjectContext.save()
                self.documents.remove(at: indexPath.row)
                docsTableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                alertNotifyUser(message: "Delete failed.")
                docsTableView.reloadData()
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "docCell", for: indexPath)
        
        let doc = documents[indexPath.row]
        cell.textLabel?.text = doc.title
        if let addDate = doc.date {
            cell.detailTextLabel?.text = dateFormatter.string(from: addDate)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteDoc(at: indexPath)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SingleDocViewController {
            if segue.identifier == "openDocument" {
                if let row = docsTableView.indexPathForSelectedRow?.row {
                    destination.doc = documents[row]
                }
            }
        }
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
