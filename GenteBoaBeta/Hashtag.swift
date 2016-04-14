//
//  Hashtag.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 06/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import Foundation

class Hashtag
{
    
    var name : String!
    
    var times : Int!
    
    init(name: String, times: Int)
    {
        self.name = name
        self.times = times
    }
    
    
    class func sintetizarHashtags(palavras: [String]) -> [Hashtag]
    {
        var achou = false
        var hashtags = [Hashtag]()
        
        for palavra in palavras
        {
            achou = false
            
            //A hashtag com essa palavra existe
            for h in hashtags
            {
                if palavra == h.name
                {
                    h.times! += 1
                    achou = true
                }
            }
            
            //A hashtag com essa palavra NAO existe
            if achou == false
            {
                hashtags.append(Hashtag(name: palavra, times: 1))
            }
        }
        
        return hashtags
    }
    
    class func hashtagsDisponiveis() -> [String]
    {
        let hashs = ["Comprometimento", "Pontualidade", "Comunicação", "Interesse", "Disponibilidade", "Proatividade", "Sinceridade", "Responsabilidade", "Diálogo", "Abertura para críticas", "Dedicação", "Paciência", "Participação", "Capricho", "Eficácia", "Flexibilidade", "Automotivação", "Organização", "Cordialidade", "Esforço", "Competitividade", "Respeito",
            "Liderança", "Confiabilidade", "Autoconfiança", "Ética", "Tolerância", "Adaptação", "Simpatia", "Empatia"]
        
        return hashs
    }
 
    
    class func ordernarHashtags(array: [Hashtag]) -> [Hashtag]
    {
        let ordenado = array.sort { $0.times > $1.times }
        
        return ordenado
    }
}



