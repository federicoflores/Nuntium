//
//  SettingsTableViewCell.swift
//  Nuntium
//
//  Created by Federico Flores on 28/11/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellName: UILabel!
    
    func setup(settingsCellName : SettingsCell ){
        cellName.text = settingsCellName.cellName
    }
    

}
