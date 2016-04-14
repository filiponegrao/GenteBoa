//
//  DAOParse.swift
//  GenteBoa
//
//  Created by Filipo Negrao on 02/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import Foundation
import Parse
import UIKit


private let data : DAOParse = DAOParse()

class DAOParse
{
    init()
    {
        
    }
    
    class var sharedInstance : DAOParse
    {
        return data
    }
    
    func getUsersWithString(string: String, callback: (results : [MetaPeople]) -> Void) -> Void
    {
        var info = [MetaPeople]()
        
        let query = PFUser.query()
        query?.whereKey("name", containsString: string)
        query?.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
            
            if(objects != nil)
            {
                print("\(objects?.count) Usuarios encontrados")
                for object in objects!
                {
                    let email = object.valueForKey("email") as! String
                    let name = object.valueForKey("name") as! String
                    let university = object.valueForKey("university") as! String
                    let course = object.valueForKey("course") as! String
                    let period = object.valueForKey("period") as! Int
                    
                    let photo = object["profileImage"] as! PFFile
                    
                    photo.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) -> Void in
                        
                        if(data != nil)
                        {
                            let image = UIImage(data: data!)
                            
                            let people = MetaPeople(email: email, name: name, photo: image!, university: university, course: course, period: period)
                            info.append(people)
                        }
                        else
                        {
                            print("Erro ao acarregar photo: \(error)")
                        }
                        
                        if(object == objects!.last)
                        {
                            callback(results: info)
                        }
                        
                    })
                }
                
                callback(results: [MetaPeople]())
            }
            
        })
    }
    
    
    func getProfileImage(username: String, callback: (image: UIImage?) -> Void) -> Void
    {
        let query = PFUser.query()
        query?.whereKey("username", equalTo: username)
        query?.getFirstObjectInBackgroundWithBlock({ (user: PFObject?, error: NSError?) -> Void in
            
            if(user != nil)
            {
                let photo = user?.objectForKey("profileImage") as! PFFile
                photo.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) -> Void in
                    
                    if(data != nil)
                    {
                        callback(image: UIImage(data: data!)!)
                    }
                    else
                    {
                        callback(image: nil)
                    }
                    
                })
            }
            else
            {
                callback(image: nil)
            }
        })
    }
  
    
    func getRandomUserDifferentFromGroup(group: [String], course: String?, callback: (people: People?) -> Void ) -> Void
    {
        let query = PFUser.query()!
        
        
        query.whereKey("email", notContainedIn: group)
        query.whereKey("username", notEqualTo: DAOUser.sharedInstance.getEmail())
        query.whereKeyExists("university")
        query.whereKeyExists("course")
        query.whereKeyExists("period")
        query.whereKeyExists("about")
        
        if(course != nil)
        {
            let filter = course!
            query.whereKey("course", equalTo: filter)
        }
        
        query.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
            
            print(objects?.count)
            
            if(objects != nil && objects?.count != 0)
            {
//                if(objects?.count == 1)
//                {
//                    DAOPeople.sharedInstance.peopleSeen = [String]()
//                }
                
                let n = objects!.count
                let index = Int(arc4random_uniform(UInt32(n)))
                let object = objects![index]
                
                let email = object["email"] as! String
                let name = object["name"] as! String
                let university = object["university"] as! String
                let period = object["period"] as! Int
                let about = object["about"] as! String
                let hiscourse = object["course"] as! String
                
                print("selecionado \(name) de curso \(hiscourse) e curso desejado era \(course)")
                
                let photo = object["profileImage"] as! PFFile
                
                let feedbacks = PFQuery(className: "Feedbacks")
                feedbacks.whereKey("user", equalTo: object)
                feedbacks.findObjectsInBackgroundWithBlock({ (objects2: [PFObject]?, error2: NSError?) -> Void in
                    
                    var positivas = [Hashtag]()
                    var negativas = [Hashtag]()
                    
                    if(objects2 != nil)
                    {
                        var palavrasPositivas = [String]()
                        var palavrasNegativas = [String]()
                        
                        for object2 in objects2!
                        {
                            let positiva = object2["positives"] as! [String]
                            let negativa = object2["negatives"] as! [String]
                            
                            palavrasPositivas += positiva
                            palavrasNegativas += negativa
                        }
                        
                        positivas = Hashtag.sintetizarHashtags(palavrasPositivas)
                        negativas = Hashtag.sintetizarHashtags(palavrasNegativas)
                        
                        positivas = Hashtag.ordernarHashtags(positivas)
                        negativas = Hashtag.ordernarHashtags(negativas)
                        
                        photo.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) -> Void in
                            
                            let image = UIImage(data: data!)!
                            
                            let person = People(email: email, name: name, photo: image, university: university, course: hiscourse, period: period, about: about, positivas: positivas, negativas: negativas)
                            
                            callback(people: person)
                            
                        })
                    }
                })
            }
            else
            {
                print("Usuario nao encontrado")
                callback(people: nil)
            }
        })
    }
    
    
    func feedbackUser(username: String, positive: [String], negative: [String])
    {
        let query = PFUser.query()!
        
        query.whereKey("username", equalTo: username)
        query.getFirstObjectInBackgroundWithBlock { (user: PFObject?, error: NSError?) -> Void in
            
            if(user != nil)
            {
                
                let feedback = PFObject(className: "Feedbacks")
                feedback["user"] = user
                feedback["positives"] = positive
                feedback["negatives"] = negative
                feedback.saveEventually()
            }
        }
    }
    
    
    func getUser(email: String, callback: (people: People?) -> Void) -> Void
    {
        let query = PFUser.query()
        
        query?.whereKey("email", equalTo: email)
        query?.whereKeyExists("university")
        query?.whereKeyExists("course")
        query?.whereKeyExists("period")
        query?.whereKeyExists("about")
        query?.getFirstObjectInBackgroundWithBlock({ (object: PFObject?, error: NSError?) -> Void in
            
            if(object != nil)
            {
                let email = object!["email"] as! String
                let name = object!["name"] as! String
                let university = object!["university"] as! String
                let period = object!["period"] as! Int
                let about = object!["about"] as! String
                let hiscourse = object!["course"] as! String
                
                let photo = object!["profileImage"] as! PFFile
                
                let feedbacks = PFQuery(className: "Feedbacks")
                feedbacks.whereKey("user", equalTo: object!)
                feedbacks.findObjectsInBackgroundWithBlock({ (objects2: [PFObject]?, error2: NSError?) -> Void in
                    
                    var positivas = [Hashtag]()
                    var negativas = [Hashtag]()
                    
                    if(objects2 != nil)
                    {
                        var palavrasPositivas = [String]()
                        var palavrasNegativas = [String]()
                        
                        for object2 in objects2!
                        {
                            let positiva = object2["positives"] as! [String]
                            let negativa = object2["negatives"] as! [String]
                            
                            palavrasPositivas += positiva
                            palavrasNegativas += negativa
                        }
                        
                        positivas = Hashtag.sintetizarHashtags(palavrasPositivas)
                        negativas = Hashtag.sintetizarHashtags(palavrasNegativas)
                        
                        positivas = Hashtag.ordernarHashtags(positivas)
                        negativas = Hashtag.ordernarHashtags(negativas)
                        
                        photo.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) -> Void in
                            
                            let image = UIImage(data: data!)!
                            
                            let person = People(email: email, name: name, photo: image, university: university, course: hiscourse, period: period, about: about, positivas: positivas, negativas: negativas)
                            
                            callback(people: person)
                            
                        })
                    }
                })
            }
            else
            {
                callback(people: nil)
            }
        })
    }
    
    
    
    
    
}