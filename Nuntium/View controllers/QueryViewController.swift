//
//  QueryViewController.swift
//  Nuntium
//
//  Created by Federico Flores on 1/12/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import UIKit


class QueryViewController: UIViewController {
    
    var selectedFromDate : String = ""
    var selectedToDate : String = ""
    
    var selectedLanguage : String = ""
    
    var queryNews : [News] = []
    
    @IBOutlet weak var queryTextField: UITextField!
    
    @IBOutlet weak var fromDatePicker: UIDatePicker!
    
    @IBOutlet weak var toDatePicker: UIDatePicker!
    
    @IBOutlet weak var searchButtonTapped: UIButton!
    
    @IBOutlet weak var disselectDateButton: UIButton!
    
    @IBOutlet weak var selectDateButton: UIButton!
    
    @IBOutlet weak var fromLabel: UILabel!
    
    @IBOutlet weak var toLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let defaults = UserDefaults.standard
    
        selectedLanguage = defaults.object(forKey: "languageElected") as? String ?? ""
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

    @IBAction func fromDatePickerChanged(_ sender: UIDatePicker) {
           let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormater.string(from: fromDatePicker.date)
        print(strDate)
        selectedFromDate = strDate
        }
    
    
    @IBAction func toDatePickerChanged(_ sender: UIDatePicker) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormater.string(from: toDatePicker.date)
        print(strDate)
        selectedToDate = strDate
        }
    
    
    @IBAction func doQueryButtonTapped(_ sender: UIButton) {
        if queryTextField.text != nil {
            self.performSegue(withIdentifier: "presentQueryTableView", sender: nil)
            }
        }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MainTableViewController {
            if let theQuery = queryTextField.text {
            destination.query = theQuery
            destination.selectedFromDate = selectedFromDate
            destination.selectedToDate = selectedToDate
            destination.infoOrigin = "Query"
            }
        }
    }
    
    @IBAction func changeSelectDate(_ sender: UIButton) {
        fromDatePicker.isHidden = false
        toDatePicker.isHidden = false
        searchButtonTapped.isHidden = false
        toLabel.isHidden = false
        fromLabel.isHidden = false
        disselectDateButton.isHidden = false
        selectDateButton.isHidden = true
    }
    
    @IBAction func changeDisselectDateButton(_ sender: UIButton) {
        fromDatePicker.isHidden = true
        toDatePicker.isHidden = true
        searchButtonTapped.isHidden = true
        toLabel.isHidden = true
        fromLabel.isHidden = true
        selectDateButton.isHidden = false
        disselectDateButton.isHidden = true
    }
    
    

}
