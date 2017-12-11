//
//  SourcesTableViewCell.swift
//  Nuntium
//
//  Created by Federico Flores on 10/12/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import UIKit

class SourcesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cellNameLabel: UILabel!
    
    @IBOutlet weak var cellStatusImageView: UIImageView!
    
    
    func setUp(cellName: String) {
            cellNameLabel.text = cellName
    }



}
