//
//  Cursos.swift
//  GenteBoa
//
//  Created by Filipo Negrao on 02/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import Foundation

class Cursos
{
    class func cursosDisponiveis() -> [String]
    {
        var cursos =  ["Administração", "Arquitetura e Urbanismo", "Artes Cênicas", "Ciência da Computação", "Ciências Biológicas", "Ciências Econômicas", "Ciências Sociais", "Comunicação Social", "Design", "Direito", "Engenharia Ambiental", "Engenharia Civil" ,"Engenharia Computação", "Engenharia Controle e Automação", "Engenharia Elétrica", "Engenharia Materiais e Nanotecnologia" ,"Engenharia Mecânica", "Engenharia Petróleo", "Engenharia Produção", "Engenharia Química", "Filosofia", "Física",
            "Geografia" ,"História", "Letras", "Matemática", "Pedagogia", "Produção e Gestão de Mídias em Educação", "Psicologia", "Química" ,"Relações Internacionais", "Serviço Social", "Sistemas de Informação", "Teologia"]
        
        cursos.sortInPlace { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }
        
        return cursos
    }
}

                     