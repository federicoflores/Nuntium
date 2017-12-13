//
//  CategoryTableViewCell.swift
//  Nuntium
//
//  Created by Federico Flores on 12/12/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    func setUp(categoryName : String, categoryImage : String) {
        categoryImageView.image = UIImage(named: categoryImage)
        categoryNameLabel.text = categoryName
    }
    
}
