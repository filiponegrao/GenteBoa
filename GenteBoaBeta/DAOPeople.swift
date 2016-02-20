//
//  DAOPeople.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 07/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import Foundation

private let data = DAOPeople()

class DAOPeople
{
    var peopleSeen : [String]!
    
    var course = "Todos"
    
    init()
    {
        self.peopleSeen = [String]()
    }
    
    
    
    class var sharedInstance : DAOPeople
    {
        return data
    }
    
    func getCurrentFilter() -> String
    {
        return self.course
    }
    
    func setCurrentFilter(course: String)
    {
        self.course = course
    }
    
    
    func getRandomUser(course: String, callback: (people: People?) -> Void ) -> Void
    {
        print("curso selecionado: \(self.course) e pessoas ja vistas: \(self.peopleSeen)")
        
        var filter : String?
        if(self.course == "Todos")
        {
            filter = nil
        }
        else
        {
            filter = self.course
        }
        
        
        DAOParse.sharedInstance.getRandomUserDifferentFromGroup(self.peopleSeen, course: filter) { (people) -> Void in
            
            if(people != nil)
            {
                self.peopleSeen.append(people!.email)
                callback(people: people)
            }
            else
            {
                print("Pessoas de mesmo curso acabaram, limpando a lista de amigos vista: \(self.peopleSeen)")
                self.peopleSeen = [String]()
                
                DAOParse.sharedInstance.getRandomUserDifferentFromGroup(self.peopleSeen, course: filter, callback: { (people) -> Void in
                    callback(people: people)
                })
            }
        }
    }
    
    func getPeople(email: String, callback: (people: People?) -> Void)
    {
        DAOParse.sharedInstance.getUser(email) { (people) -> Void in
            
            if(people == nil)
            {
                callback(people: nil)
            }
            else
            {
                callback(people: people)
            }
            
        }
    }
    
    func giveSomeoneFeedback(username: String, positive: [String], negative: [String])
    {
        DAOParse.sharedInstance.feedbackUser(username, positive: positive, negative: negative)
    }
    
    
}