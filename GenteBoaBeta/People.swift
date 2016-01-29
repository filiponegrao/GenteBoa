//
//  People.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 07/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import Foundation
import UIKit

class People
{
    var email: String
    
    var name : String!
    
    var photo : UIImage!
    
    var university : String!
    
    var course : String!
    
    var period : Int!
    
    var about : String!
    
    var positivas : [Hashtag]!
    
    var negativas : [Hashtag]!
    
    init(email: String, name: String, photo: UIImage, university: String, course: String, period: Int, about: String, positivas: [Hashtag], negativas: [Hashtag])
    {
        self.email = email
        self.name = name
        self.photo = photo
        self.university = university
        self.course = course
        self.period = period
        self.about = about
        self.positivas = positivas
        self.negativas = negativas
    }
    
    deinit
    {
//        print("desalocando People")
    }
}


class MetaPeople
{
    var email: String
    
    var name : String!
    
    var photo : UIImage!
    
    var university : String!
    
    var course : String!
    
    var period : Int!
    
    var about : String!
    
    
    init(email: String, name: String, photo: UIImage, university: String, course: String, period: Int)
    {
        self.email = email
        self.name = name
        self.photo = photo
        self.university = university
        self.course = course
        self.period = period
    }
}