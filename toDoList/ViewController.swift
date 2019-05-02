//
//  ViewController.swift
//  toDoList
//
//  Created by TALHA AYAR on 23.09.2018.
//  Copyright © 2018 TALHA AYAR. All rights reserved.
//

import UIKit
import UICheckbox_Swift
import SCLAlertView
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
     var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.blue
        
        return refreshControl
    }()
   
   

    @IBOutlet weak var tableView: UITableView!
    var nameArray = [String]()
    var categoryArray = [String]()
    var dateArray = [String]()
    var contentArray = [Contentss]()
    var selectedContent = Contentss()
   
    
   
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "All Tasks"
        self.tableView.addSubview(self.refreshControl)
        self.tableView.layer.cornerRadius = 10
        self.tableView.layer.masksToBounds = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        getInfo()
   
    }
    
      //////////////////////////////////////////////  //////////////////////////////////////////////
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getInfo()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func viewWillAppear() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.getInfo), name: NSNotification.Name(rawValue: "newAnimal" ), object: nil)
    }
    
    @objc func getInfo() {
        nameArray.removeAll(keepingCapacity: false)
        categoryArray.removeAll(keepingCapacity: false)
        dateArray.removeAll(keepingCapacity: false)
        contentArray.removeAll()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contents")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    let contents = Contentss()
                    
                    if let content = result.value(forKey: "content") as? String {
                     contents.content  = content
                       
                        self.contentArray.append(contents)
                    }
                    if let category = result.value(forKey: "category") as? String {
                        contents.category = category
                    }
                    if let date = result.value(forKey: "date") as? String {
                        contents.date = date
                    }
                    if let id = result.value(forKey: "id") as? String {
                        contents.id = id
                    }
                    
                    self.tableView.reloadData()
                }
            }
        } catch {
            
            print("Error")
        }
    }
    
      //////////////////////////////////////////////
    
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "toAddScreen", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contentCell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentTableViewCell
        let contents = contentArray[indexPath.row]
        contentCell.contentName.text = contents.content
        contentCell.dateLabel.text = contents.date
         return contentCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddScreen"  {
            
            let destinationVC = segue.destination as! AddViewController
            destinationVC.chosenContentId = selectedContent.id
           
            
        }
    }
    
 
    ///////////////////////////////////////////////////////////////////////////
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
            self.contentArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = self.contentArray[indexPath.row]
        self.selectedContent = content
        performSegue(withIdentifier: "toAddScreen", sender: nil)
    }
    
}


