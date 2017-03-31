//
//  DetailViewController.swift
//  SaveRetriveUpdate
//
//  Created by Sudheesh on 3/20/17.
//  Copyright © 2017 DevelopScripts. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    var item : NSManagedObject!
    var appStoreItems = [AppStore]()
    var index = 0
    
    @IBOutlet var appNameText: UITextField!
    @IBOutlet var appIdText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appName = item.valueForKey("appName") as? String
        let appId = item.valueForKey("appId") as? Int
        appNameText.text = appName!
        appIdText.text = "\(appId!)"
       // update()
    }
    
    // For Update Entire Rows in the table with Specified values
    func update(){
        let moc = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
        let en = NSEntityDescription.entityForName("AppStore", inManagedObjectContext: moc!)
        
        let batchUpdateRequest = NSBatchUpdateRequest(entity: en!)
        batchUpdateRequest.resultType = NSBatchUpdateRequestResultType.UpdatedObjectIDsResultType
        batchUpdateRequest.propertiesToUpdate = ["appName": "Fantabulus"]
     
        do{
            try moc?.executeRequest(batchUpdateRequest)
        }
        catch (let error as NSError){
            print(error.localizedDescription)
            print("Not able to update")
        }
    }
    
    @IBAction func updateDatabase(sender: UIButton) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appStoreItems[index].appName = appNameText.text!
        appStoreItems[index].appId = Int(appIdText.text!)
        appDelegate.saveContext()
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
