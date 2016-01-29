//
//  User+CoreDataProperties.swift
//  GenteBoa
//
//  Created by Filipo Negrao on 01/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {
    
    @NSManaged var username: String!
    @NSManaged var name: String!
    @NSManaged var email: String!
    @NSManaged var profileImage: NSData?
    @NSManaged var university: String!
    @NSManaged var course: String!
    @NSManaged var period: NSNumber!
    @NSManaged var about: String!
}
