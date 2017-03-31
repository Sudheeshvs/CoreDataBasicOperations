//
//  ViewControllerHelper.swift
//  SaveRetriveUpdate
//
//  Created by Sudheesh on 3/20/17.
//  Copyright © 2017 DevelopScripts. All rights reserved.
//

import CoreData
import UIKit

extension ViewController{
    
    func addItem(itemToSave : String){
        if let moc = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext{
            let appstore = NSEntityDescription.insertNewObjectForEntityForName("AppStore", inManagedObjectContext: moc) as! AppStore
            appstore.appName = itemToSave
            appstore.appId = 1
            do{
                try moc.save()
                appStoreItems.append(appstore)
            }
            catch let error as NSError{
                print(error.localizedFailureReason)
            }
        }
    }
    
    func retrieveItemWithoutReturnType(){
        if let moc = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext{
            let fetchRequest = NSFetchRequest(entityName: "AppStore")
            do{
                let results = try moc.executeFetchRequest(fetchRequest)
                appStoreItems = results as! [AppStore]
            }
            catch{
                print("oops... Some Error occured")
            }
        }
    }
    
    func retrieveItem() -> [AppStore]{
        var appStoreDetails = [AppStore]()
        if let moc = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext{
            let fetchRequest = NSFetchRequest(entityName: "AppStore")
            do {
                let reults = try moc.executeFetchRequest(fetchRequest)
                appStoreDetails = reults as! [AppStore]
            }
            catch let error as NSError{
                print(error.localizedFailureReason)
            }
        }
        return appStoreDetails
    }
}