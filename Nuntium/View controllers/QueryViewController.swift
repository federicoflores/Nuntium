//
//  QueryViewController.swift
//  Nuntium
//
//  Created by Federico Flores on 1/12/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import UIKit

class QueryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    enum Months {
        case Enero
        case Febrero
        case Marzo
        case Abril
        case Mayo
        case Junio
        case Julio
        case Agosto
        case Septiembre
        case Octube
        case Noviembre
        case Diciembre
    }
    
    var days : [Int] = []
    var months = [Months.Enero, Months.Febrero, Months.Marzo, Months.Abril, Months.Mayo, Months.Junio, Months.Julio, Months.Agosto, Months.Septiembre, Months.Octube, Months.Noviembre, Months.Diciembre]
    var years : [Int] = []
    
    
    @IBOutlet weak var queryTextField: UITextField!
    
    @IBOutlet weak var fromDayTextField: UIPickerView!
    
    @IBOutlet weak var fromMonthTextField: UIPickerView!
    
    @IBOutlet weak var fromYearTextField: UIPickerView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func generateDays() {
        for i in 1...30 {
            days.append(i)
        }
    }
    
    func generateYears() {
        for i in 1900...2017 {
            years.append(i)
        }
        years.sort {
            $0 > $1
        }
    }

  

}
