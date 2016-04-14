//
//  ViewController.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 20/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        
        let scrollView = UIScrollView(frame: CGRectMake(0,20, width, height - 20))
        self.view.addSubview(scrollView)
    
        
        let title1 = UITextField(frame: CGRectMake(20, 20, width - 40, 44))
        title1.text = "O que é?"
        title1.font = UIFont(name:  "Arial Rounded MT Bold", size: 20)
        scrollView.addSubview(title1)
        
        let textView1 = UITextView(frame: CGRectMake(20, title1.frame.origin.y + title1.frame.size.height, width - 40, 150))
        
        textView1.text = "Gente Boa é um projeto nascido na disciplina de Atitude e Comportamento Empreendedor, ministrada na Pontífica Universidade Católica do Rio de Janeiro. O nome mistura a expressão popular que segundo o dicionário informal quer dizer 'Pessoa agradável, divertida, de bom caráter e o que é conhecido no mercado profissional como uma pessoa 'boa', que tem potencial de realizar grandes projetos e se sai bem nas atividades que se propõe a fazer."
        
        scrollView.addSubview(textView1)
        
        let title2 = UITextField(frame: CGRectMake(20, textView1.frame.origin.y + textView1.frame.size.height, width - 40, 44))
        title2.text = "Por que?"
        title2.font = UIFont(name:  "Arial Rounded MT Bold", size: 20)
        scrollView.addSubview(title2)
        
        let textView2 = UITextView(frame: CGRectMake(20, title2.frame.origin.y + title2.frame.size.height, width - 40, 150))
        
        textView2.text = "Porque queremos que as pessoas se conectem e formem grupos de trabalho de forma mais consciente. Aqui o aluno tem a oportunidade de dar retornos sobre o desempenho de pessoas com quem trabalham e convivem em ambiente universitário. Queremos que as pessoas saibam o que elas tem de melhor e o que elas podem melhorar."
        
        scrollView.addSubview(textView2)
        
        let title3 = UITextField(frame: CGRectMake(20, textView2.frame.origin.y + textView2.frame.size.height, width - 40, 44))
        title3.text = "Quem?"
        title3.font = UIFont(name:  "Arial Rounded MT Bold", size: 20)
        scrollView.addSubview(title3)
        
        let textView3 = UITextView(frame: CGRectMake(20, title3.frame.origin.y + title3.frame.size.height, width - 40, 150))
        
        textView3.text = "Idealizado por um aluno de Publicidade da PUC-Rio e executado por um time da disciplina de Atitude e Comportamento Empreendedor."
        
        scrollView.addSubview(textView3)
        
        scrollView.contentSize.height = (title1.frame.size.height + textView1.frame.size.height)*3
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
