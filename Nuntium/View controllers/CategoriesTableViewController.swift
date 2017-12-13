//
//  CategoriesTableViewController.swift
//  Nuntium
//
//  Created by Federico Flores on 9/12/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    var categoryNews : [News] = []
    
    var selectedLanguage = ""
    
    var categorySelected : String = ""
    
    var categoriesArray = ["business","entertainment","gaming", "general", "health-and-medical", "music", "politics", "science-and-nature", "sport", "technology"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = false
        
        let defaults = UserDefaults.standard
        selectedLanguage = defaults.object(forKey: "languageElected") as? String ?? ""

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        if let categoryCell = cell as? CategoryTableViewCell {
            let categoryName = categoriesArray[indexPath.row]
            categoryCell.setUp(categoryName: categoryName, categoryImage: categoryName)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categorySelected = categoriesArray[indexPath.row]
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
            self.performSegue(withIdentifier: "presentMainTableViewFromCategoies", sender: nil)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MainTableViewController {
            destination.selectedCategory = categorySelected
            destination.infoOrigin = "Categories"
        }
    }
    
    
}
