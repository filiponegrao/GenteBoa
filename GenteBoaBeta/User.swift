//
//  User.swift
//  GenteBoa
//
//  Created by Filipo Negrao on 01/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import Foundation
import CoreData


class User: NSManagedObject
{
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, username: String, name: String, about: String, email: String, university: String, course: String, period: Int, profileImage: NSData?) -> User
    {
        let user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: moc) as! User
        user.username = username
        user.name = name
        user.email = email
        user.profileImage = profileImage
        user.university = university
        user.course = course
        user.period = period
        user.about = about
        
        return user
    }
    
}
