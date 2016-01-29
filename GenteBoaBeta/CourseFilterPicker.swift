//
//  CourseFilterPicker.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 16/01/16.
//  Copyright © 2016 Filipo Negrao. All rights reserved.
//

import Foundation
import UIKit


class CourseFilterPicker : UIView, UIPickerViewDelegate, UIPickerViewDataSource
{
    var picker : UIPickerView!
    
    var button : UIButton!
    
    var itens = Cursos.cursosDisponiveis()
    
    init()
    {
        super.init(frame: CGRectMake(0, 0, screenWidth, screenHeight*4/9))
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itens.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itens[row]
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
}