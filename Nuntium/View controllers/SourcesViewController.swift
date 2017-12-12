//
//  SourcesViewController.swift
//  Nuntium
//
//  Created by Federico Flores on 10/12/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import UIKit

class SourcesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    var categorySourceArray : [Source] = []
    var countrySourceArray : [Source] = []
    var auxsources : [Source] = []
    var sources : [Source] = []
    
    var sourcesIdSelected : [String] = []
    
    var countrySelected : String = ""
    var categorySelected : String = ""
    var sourcesSelected : String = ""
    
    var userDefaults = UserDefaults()
    
    
    var categoriesArray = ["business","entertainment","gaming", "general", "health-and-medical", "music", "politics", "science-and-nature", "sport", "technology"]
    
    var countriesArray = ["Argentina", "Australia", "Brasil", "Canada", "China", "Germany", "Spain", "France", "Great Bretain", "Hong Kong", "Ireland", "India", "Island", "Italy", "Neatherlands", "Norway", "Pakistan", "Rusia", "South Africa", "Saudi Arabian", "United States", "Israel"]
    
        var countriesDict = ["Argentina": "ar","Australia" : "au","Brasil" : "br", "Canada" : "ca","China" : "cn","Germany" : "de" ,"Spain" : "es" ,"France" : "fr" , "Great Bretain" : "gb","Hong Kong" : "hk" ,"Ireland" : "ie", "India" : "in", "Island" : "is" , "Italy" : "it", "Neatherlands" : "nl", "Norway" : "no", "Pakistan": "pk", "Rusia": "ru", "South Africa" : "sa", "Saudi Arabian": "sv", "United States": "us", "Israel": "za"]
    
    
    @IBOutlet weak var categoriesPickerView: UIPickerView!
    
    @IBOutlet weak var countriesPickerView: UIPickerView!
    
    @IBOutlet weak var sourcesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sourcesTableView.allowsMultipleSelection = true
        categoriesPickerView.delegate = self
        categoriesPickerView.dataSource = self
        countriesPickerView.delegate = self
        countriesPickerView.dataSource = self
        
        let service = NewsService()
        service.getSources(category: "", language: "", country: "", serviceCompletion: { response in
            self.sources = response
            self.auxsources = response
            self.sourcesTableView.reloadData()
        })
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == categoriesPickerView {
            return categoriesArray.count
        } else if pickerView == countriesPickerView {
            return countriesArray.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoriesPickerView {
            return categoriesArray[row]
        } else if pickerView == countriesPickerView {
            return countriesArray[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case categoriesPickerView:
            sources = auxsources
            categorySourceArray = sources.filter {$0.language == userDefaults.object(forKey: "languageElected") as? String ?? ""}
            categorySelected = categoriesArray[row]
            categorySourceArray =  categorySourceArray.filter {$0.category == categorySelected}
            auxsources = sources
            sources = categorySourceArray
            sourcesTableView.reloadData()
            
        case countriesPickerView:
            sources = auxsources
            countrySelected = countriesArray[row]
            countrySourceArray = sources.filter {$0.language == userDefaults.object(forKey: "languageElected") as? String ?? ""}

            countrySourceArray = countrySourceArray.filter {$0.country == countriesDict[countrySelected]}
            auxsources = sources
            sources = countrySourceArray
            sourcesTableView.reloadData()
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sourceCell", for: indexPath)
        if let sourceCell = cell as? SourcesTableViewCell {
            let theSource = sources[indexPath.row].name
            sourceCell.setUp(cellName: theSource)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSourceName = sources[indexPath.row].id
        sourcesIdSelected.append(selectedSourceName)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedSourceName = sources[indexPath.row].id
        if sourcesIdSelected.contains(selectedSourceName) {
            let filteredSourceName = sourcesIdSelected.filter {$0 != selectedSourceName}
            sourcesIdSelected = filteredSourceName
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MainTableViewController {
            let joiner = ", "
            sourcesSelected = sourcesIdSelected.joined(separator: joiner)
            destination.sourcesSelected = self.sourcesSelected
            destination.infoOrigin = "Sources"
        }
    }
    
    @IBAction func doneTappedButton(_ sender: Any) {
        performSegue(withIdentifier: "presentMainTableViewControllerFromSources", sender: nil)
        sourcesIdSelected = []
    }
    
    
    
}
