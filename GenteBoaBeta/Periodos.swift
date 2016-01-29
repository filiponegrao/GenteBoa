//
//  Periodos.swift
//  GenteBoa
//
//  Created by Filipo Negrao on 02/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import Foundation

class Periodos
{
    class func periodosDisponiveis() -> [Int]
    {
        return [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22]
    }
    
    class func periodoFromString(periodo: String) -> Int
    {
        let num = NSString(string: periodo).substringWithRange(NSMakeRange(0, 1))
        
        let n = Int.init(num)
        print(n)
        return n!
    }
}

