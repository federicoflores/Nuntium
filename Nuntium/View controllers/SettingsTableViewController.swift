//
//  SettingsTableViewController.swift
//  Nuntium
//
//  Created by Federico Flores on 28/11/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    let userDefaults = UserDefaults()
    
    var categorySelected : String?
    var categoryRow : Int?
    var languageSelected : String?
    var languageRow : Int?
    var countrySelected : String?
    var countryRow : Int?
    
    
    var categoriesDict = ["business" : "business","entertainment" : "entertainment","gaming": "gaming","general": "general", "health-and-medical": "health-and-medical","music": "music","politics": "politics","science-and-nature": "science-and-nature", "sport": "sport","technology": "technology"]
    
    var categoriesArray = ["business","entertainment","gaming", "general", "health-and-medical", "music", "politics", "science-and-nature", "sport", "technology"]
    
    
    var languagesDict = ["spanish": "es","english" : "en", "french" : "fr", "italian" : "it","german": "de"]
    
    var lenguagesArray = ["spanish", "english", "french", "italian","german"]
    
    var countriesDict = ["Argentina": "ar","Australia" : "au","Brasil" : "br", "Canada" : "ca","China" : "cn","Germany" : "de" ,"Spain" : "es" ,"France" : "fr" , "Great Bretain" : "gb","Hong Kong" : "hk" ,"Ireland" : "ie", "India" : "in", "Island" : "is" , "Italy" : "it", "Neatherlands" : "nl", "Norway" : "no", "Pakistan": "pk", "Rusia": "ru", "South Africa" : "sa", "Saudi Arabian": "sv", "United States": "us", "Israel": "za"]
    
    var countriesArray = ["Argentina", "Australia", "Brasil", "Canada", "China", "Germany", "Spain", "France", "Great Bretain", "Hong Kong", "Ireland", "India", "Island", "Italy", "Neatherlands", "Norway", "Pakistan", "Rusia", "South Africa", "Saudi Arabian", "United States", "Israel"]
    
    
    var cellSettings: [[String]] = []
    
    var multipleSelection = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellSettings.append(categoriesArray)
        cellSettings.append(lenguagesArray)
        cellSettings.append(countriesArray)
        
    }
    
    


    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return cellSettings.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "categories"
        case 1:
            return "languages"
        case 2:
            return "countries"
        default:
            break
        }
        return nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellSettings[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        
        let selectedCellName = cellSettings[indexPath.section] [indexPath.row]
        if let preferenceCell = cell as? SettingsTableViewCell {
            preferenceCell.setup(settingsCellName:SettingsCell(cellName: selectedCellName))
            if indexPath.section == 0 {
                if let theCategoryRow = categoryRow, indexPath.row == theCategoryRow {
                    preferenceCell.accessoryType = .checkmark
                } else {
                    preferenceCell.accessoryType = .none
                }
            }
            if indexPath.section == 1 {
                if let theLanguageRow = languageRow, indexPath.row == theLanguageRow {
                    preferenceCell.accessoryType = .checkmark
                } else {
                    preferenceCell.accessoryType = .none
                }
            }
            if indexPath.section == 2 {
                if let theCountryRow = countryRow, indexPath.row == theCountryRow {
                    preferenceCell.accessoryType = .checkmark
                } else {
                    preferenceCell.accessoryType = .none
                }
            }
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if let selectedCategoryRow = self.categoryRow, selectedCategoryRow == indexPath.row {
                self.categoryRow = nil
            } else {
                self.categoryRow = indexPath.row
                if let selectedCategoryRow = self.categoryRow {
                self.categorySelected = categoriesDict[categoriesArray[selectedCategoryRow]]
                }
            }
        }
        else if indexPath.section == 1 {
            if let selectedLanguageRow = self.languageRow, selectedLanguageRow == indexPath.row {
                self.languageRow = nil
            } else {
                self.languageRow = indexPath.row
                if let selectedLangueageRow = self.languageRow {
                    self.languageSelected = languagesDict[lenguagesArray[selectedLangueageRow]]
                }
            }
        }
    else if indexPath.section == 2 {
                if let selectedCountryRow = self.countryRow, selectedCountryRow == indexPath.row {
                    self.countryRow = nil
                } else {
                    self.countryRow = indexPath.row
                    if let selectedCountryRow = self.countryRow {
                        self.countrySelected = countriesDict[countriesArray[selectedCountryRow]]
                        }
                    }
                }
            tableView.reloadData()
                }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }

    
    
    @IBAction func doneTappedButton(_ sender: UIBarButtonItem) {
        userDefaults.set(categorySelected, forKey: "categoryElected")
        userDefaults.set(languageSelected, forKey: "languageElected")
        userDefaults.set(countrySelected, forKey: "countryElected")
        userDefaults.set(categoryRow, forKey: "categoryRow")
        userDefaults.set(languageRow, forKey: "languageRow")
        userDefaults.set(countryRow, forKey: "countryRow")
        navigationController?.popViewController(animated: true)
    }
    
    func didSelectSyntetizerLenguage(sender: NewsWithImageViewController) {
        if let theLanguageSelected = languageSelected {
        switch theLanguageSelected {
        case "es":
            sender.syntetizerLanguage = "es-ES"
        case "en":
            sender.syntetizerLanguage = "en-US"
        case "fr":
            sender.syntetizerLanguage = "fr-FR"
        case "it":
            sender.syntetizerLanguage = "it-IT"
         default:
            sender.syntetizerLanguage = "en-US"

            }
        }
        else if languageSelected == nil {
            sender.syntetizerLanguage = "en-US"
        }
    }
        
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
