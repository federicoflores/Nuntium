//
//  SettingsViewController.swift
//  Nuntium
//
//  Created by Federico Flores on 8/12/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func didModifySettings()
}


class SettingsViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource {
    
    var newsArray : [News] = []
    
    let defaults = UserDefaults.standard
    
    var languagesArray = ["spanish", "english", "french", "italian","german"]
    
    var languagesDict = ["spanish": "es","english" : "en", "french" : "fr", "italian" : "it","german": "de"]
    
    var languageSelected : String = ""
    
    @IBOutlet weak var languagePickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languagePickerView.delegate = self
        languagePickerView.dataSource = self

    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.blue
        pickerLabel.text = languagesArray[row]
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 35)
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languagesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languagesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        languageSelected = languagesArray[row]
    }
    
    
    @IBAction func doneTappedButton(_ sender: Any) {
        defaults.set(languagesDict[languageSelected], forKey: "languageElected")
        navigationController?.popToRootViewController(animated: true)
        
    }
    
}
