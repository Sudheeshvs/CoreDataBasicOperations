//
//  ViewController.swift
//  SaveRetriveUpdate
//
//  Created by Sudheesh on 3/20/17.
//  Copyright © 2017 DevelopScripts. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController{
    
    var appStoreItems = [AppStore]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: #selector(self.didPullRefresher), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl!)
    }
    
    func didPullRefresher(){
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    override func viewWillAppear(animated: Bool) {
        appStoreItems = retrieveItem()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appStoreItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        let item = appStoreItems[indexPath.row]
        
        cell.textLabel?.text = item.appName
        cell.detailTextLabel?.text = "\(item.appId!)"
        //If we are using NSManagedObject Array use below code
        //cell.textLabel?.text = item.valueForKey("appName") as? String
        //cell.detailTextLabel?.text = "\(item.valueForKey("appId") as! NSNumber)"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedItem: NSManagedObject = appStoreItems[indexPath.row] as NSManagedObject
        let detailsView = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailsView.appStoreItems = appStoreItems
        detailsView.index = indexPath.row
        detailsView.item = selectedItem
        self.navigationController?.pushViewController(detailsView, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // 1
        if editingStyle == .Delete {
            // 2
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let moc = appDelegate.managedObjectContext
            
            // 3
            moc.deleteObject(appStoreItems[indexPath.row])
            appDelegate.saveContext()
            
            // 4
            appStoreItems.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
    @IBAction func saveItem(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Type Something", message: nil, preferredStyle: .Alert)
        let confirmAction = UIAlertAction(title: "Confirm",style: UIAlertActionStyle.Default,handler: ({(_) in
                if let field = alert.textFields?[0] {
                    self.addItem(field.text!)
                    self.tableView.reloadData()
                }
            }
        ))
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addTextFieldWithConfigurationHandler({
            (textField) in
            textField.placeholder = "Type in something "
        })
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true , completion: nil)
    }
}

