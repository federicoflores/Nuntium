//
//  NotImageNewsTableViewCell.swift
//  Nuntium
//
//  Created by Federico Flores on 14/11/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import UIKit

class NotImageNewsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var newsTitleLabel: UILabel!
    
    @IBOutlet weak var newsBodyTextView: UITextView!
    
    @IBOutlet weak var sourceNameLabel: UILabel!
    
    @IBOutlet weak var sourceAuthorLabel: UILabel!
    
    func setup(news: News) {
        newsTitleLabel.text = news.title
        newsBodyTextView.text = news.description
        sourceNameLabel.text = news.source?.name
        sourceAuthorLabel.text = news.author
    }
    
}
