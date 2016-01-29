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
        let hashs = ["Comprometimento", "Pontualidade", "Comunicação", "Capacidade de entendimento",
                    "Interesse", "Antecipação", "Acessibilidade/ disponibilidade", "Pro-atividade",
                    "Sinceridade/ transparência", "Abertura para diálogos", "Abertura para ideias",
                    "Vontade de aprender", "Criatividade", "Responsabilidade", "Seguir Cronograma/cumprir prazos",
            "Dedicação", "Paciência", "Participação","Atenção" ,"detalhes", "Prontidão", "Eficácia", "Flexibilidade",
            "Automotivação", "Organização", "Perfeccionismo", "Cordialidade", "Capricho", "Esforço", "Competitividade",
            "Respeito", "Liderança", "Confiabilidade", "Autoconfiança", "Motivação de grupo", "Ética de trabalho",
            "Tolerância", "Adaptação", "Planejamento", "Valorização da equipe", "Descentralização de tarefas (oposto de centralizador)",
            "Simpatia" , "Empatia"]
        
        return hashs
    }
 
    
    class func ordernarHashtags(array: [Hashtag]) -> [Hashtag]
    {
        let ordenado = array.sort { $0.times > $1.times }
        
        return ordenado
    }
}



