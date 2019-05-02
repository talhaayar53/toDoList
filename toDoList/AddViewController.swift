//
//  AddViewController.swift
//  toDoList
//
//  Created by TALHA AYAR on 23.09.2018.
//  Copyright © 2018 TALHA AYAR. All rights reserved.
//

import UIKit
import SCLAlertView
import CoreData



class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewTwo: UIView!
    @IBOutlet weak var contentViewThree: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewTwo: UIImageView!
    @IBOutlet weak var imageViewThree: UIImageView!
    @IBOutlet weak var contentOneLabelOne: UILabel!
    @IBOutlet weak var contentOneLabelTwo: UILabel!
    @IBOutlet weak var contentTwoLabelOne: UILabel!
    @IBOutlet weak var contentTwoLabelTwo: UILabel!
    @IBOutlet weak var contentThreeLabelOne: UILabel!
    @IBOutlet weak var contentThreeLabelTwo: UILabel!
    
    
    var chosenContentId = ""
    var chosenCategory = ""
    var dateView = UIDatePicker()
    @IBOutlet weak var saveLabel: UILabel!
    var selectedContentObject : Any = ()
    
    
    
    
    var pickArray = [UIPickerView]()
    var category = ["Shopping", "Meet" , "Work" , "Food", "Visit" , "Entertaining"]

    override func viewDidLoad() {
        self.navigationItem.title = "All Tasks"

        
        
        contentOneLabelTwo.text = ""
        contentTwoLabelTwo.text = ""
        contentThreeLabelTwo.text = ""
        contentOneLabelOne.text = "Description"
        contentTwoLabelOne.text = "Category"
        contentThreeLabelOne.text = "Date"
        
      
        
        //////////////////////////////////////////////
        
        if chosenContentId != "" {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contents")
            fetchRequest.predicate = NSPredicate(format: "id = %@", self.chosenContentId)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    self.selectedContentObject = results[0]
                    for result in results as! [NSManagedObject] {
                        if let name = result.value(forKey: "content") as? String {
                            contentOneLabelTwo.text = name
                        }
                        
                        if let category = result.value(forKey: "category") as? String {
                            contentTwoLabelTwo.text = category
                        }
                        
                        if let dates = result.value(forKey: "date") as? Date {
                            let date = NSDate()
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            let dateString = dateFormatter.string(from: date as Date)
                            self.contentThreeLabelTwo.text = dateString
                        }
                    }
                }
            }
            catch {
                print("Failed")
                super.viewDidLoad()
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue : "newContent"), object: nil)
        }
      
        
        
        ////////////////////////////////////////////  //////////////////////////////////////////////
        
        
        
        
        
        super.viewDidLoad()
      contentView.isUserInteractionEnabled = true
      let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddViewController.selectImage))
      contentView.addGestureRecognizer(gestureRecognizer)
        
        contentView.layer.shadowColor = UIColor.lightGray.cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = CGSize.zero
        contentView.layer.shadowRadius = 4
        contentView.layer.cornerRadius = 15;
        
        
        let gestureRecognizerTwo = UITapGestureRecognizer(target: self, action: #selector(AddViewController.selectImageTwo))
        
contentViewTwo.addGestureRecognizer(gestureRecognizerTwo)

        contentViewTwo.layer.shadowColor = UIColor.lightGray.cgColor
        contentViewTwo.layer.shadowOpacity = 1
        contentViewTwo.layer.shadowOffset = CGSize.zero
        contentViewTwo.layer.shadowRadius = 4
        contentViewTwo.layer.cornerRadius = 15;
        
        
        let gestureRecognizerThree = UITapGestureRecognizer(target: self, action: #selector(AddViewController.selectImageThree))
        contentViewThree.addGestureRecognizer(gestureRecognizerThree)
        
        contentViewThree.layer.shadowColor = UIColor.lightGray.cgColor
        contentViewThree.layer.shadowOpacity = 1
        contentViewThree.layer.shadowOffset = CGSize.zero
        contentViewThree.layer.shadowRadius = 4
        contentViewThree.layer.cornerRadius = 15;
}
    
    
    
      //////////////////////////////////////////////  //////////////////////////////////////////////
    
    @objc func selectImage() {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false )
        let alert = SCLAlertView(appearance: appearance)
       
        let txt = alert.addTextField("Your description")
        alert.addButton("Add") {
            self.contentOneLabelTwo.text = txt.text
            
        }
        
        alert.showEdit("Content Name", subTitle: "You need to write your description.")
        
        
    }
    
    @objc func selectImageTwo() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250, height: 300)
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        pickerView.dataSource = self
        pickerView.delegate = self
        
        let alertView = UIAlertController(
            title: "Select category",
            message: "agugugugug",
            preferredStyle: .alert)
        //alertView.isModalInPopover = true
        
        vc.view.addSubview(pickerView)
        
        let alertController = UIAlertController(title: "Category", message: "Select your category", preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil)

        alertController.setValue(vc, forKey: "contentViewController")
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return category[row]
    }
    
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.contentTwoLabelTwo.text = category[row]
    }
    
@objc func selectImageThree() {
    let vc = UIViewController()
    vc.preferredContentSize = CGSize(width: 250, height: 300)
    
    dateView = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
   
    
    let alertView = UIAlertController(
        title: "Select date",
        message: "aasdac",
        preferredStyle: .alert)
    
    vc.view.addSubview(dateView)
    
    let alertController = UIAlertController(title: "Date", message: "Select your date", preferredStyle: .alert)
    let action = UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: { action in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let selectedDate = dateFormatter.string(from: self.dateView.date)
        self.contentThreeLabelTwo.text = selectedDate
    });
    
    alertController.setValue(vc, forKey: "contentViewController")
    alertController.addAction(action)
    
    present(alertController, animated: true, completion: nil)
    }
    
      //////////////////////////////////////////////  //////////////////////////////////////////////
   
    @IBAction func saveButton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newData : NSManagedObject ;

        if chosenContentId != nil {
            newData = self.selectedContentObject as! NSManagedObject
            newData.setValue(contentOneLabelTwo.text, forKey: "content")
            newData.setValue(contentTwoLabelTwo.text, forKey: "category")
            newData.setValue(contentThreeLabelTwo.text, forKey: "date")
        } else {
            newData = NSEntityDescription.insertNewObject(forEntityName: "Contents", into: context)
            newData.setValue(contentOneLabelTwo.text, forKey: "content")
            newData.setValue(contentTwoLabelTwo.text, forKey: "category")
            newData.setValue(contentThreeLabelTwo.text, forKey: "date")
            newData.setValue(String(Date().timeIntervalSinceNow), forKey: "id")
        }
        
        
        var haveError = false
       
        if contentOneLabelTwo.text == ""  {
            SCLAlertView().showInfo("ERROR", subTitle: "Boş yer bıraktınız.")
            haveError = true
        }
        if contentTwoLabelTwo.text == ""  {
            SCLAlertView().showInfo("ERROR", subTitle: "Boş yer bıraktınız.")
            haveError = true
        }
        if contentThreeLabelTwo.text == ""  {
            SCLAlertView().showInfo("ERROR", subTitle: "Boş yer bıraktınız.")
            haveError = true
        }
       
        if (haveError) {
            context.delete(newData)
            return
        }
        
        
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue : "newContent"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
     
        
    }
    
    
    
    
    }


extension Date {
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
}



