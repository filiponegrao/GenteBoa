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
        var cursos =  ["Administraçao", "Arquitetura", "Artes Cênicas", "CIÊNCIA DA COMPUTAÇÃO", "CIÊNCIAS BIOLÓGICAS", "CIÊNCIAS ECONÔMICAS (ECONOMIA)", "CIÊNCIAS SOCIAIS", "COMUNICAÇÃO SOCIAL  (CICLO BÁSICO)", "COMUNICAÇÃO SOCIAL  (PUBLICIDADE E PROPAGANDA)", "JORNALISMO", "CINEMA", "DESIGN (COMUNICAÇÃO VISUAL)", "DESIGN (MIDIA DIGITAL)", "DESIGN (MODA)", "DESIGN (PROJETO DE PRODUTO)", "DIREITO", "ENGENHARIA (CICLO BÁSICO)", "ENGENHARIA AMBIENTAL", "ENGENHARIA CIVIL ", "ENGENHARIA DA COMPUTAÇÃO", "ENGENHARIA CONTROLE E AUTOMAÇÃO ", "ENGENHARIA ELÉTRICA", "ENGENHARIA MATERIAIS E NANOTECNOLOGIA","ENGENHARIA MECÂNICA","ENGENHARIA PETRÓLEO", "ENGENHARIA PRODUÇÃO", "ENGENHARIA QUÍMICA","FILOSOFIA", "FÍSICA","GEOGRAFIA","HISTÓRIA","LETRAS (PT e EN)", "LETRAS (LÍNGUA PORTUGUESA)","LETRAS (PRODUÇÃO TEXTUAL)", "LETRAS (TRADUTOR)","MATEMÁTICA","PEDAGOGIA", "PRODUÇÃO E GESTÃO DE MÍDIAS EM EDUCAÇÃO", "PSICOLOGIA","QUÍMICA", "RELAÇÕES INTERNACIONAIS", "SERVIÇO SOCIAL","SISTEMAS DE INFORMAÇÃO", "TEOLOGIA"]
        
        cursos.sortInPlace { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }
        
        return cursos
    }
}

                     