//
//  AppStore+CoreDataProperties.swift
//  SaveRetriveUpdate
//
//  Created by Sudheesh on 3/20/17.
//  Copyright © 2017 DevelopScripts. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension AppStore {

    @NSManaged var appName: String?
    @NSManaged var appId: NSNumber?

}
