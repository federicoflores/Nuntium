//
//  NewsWithImageTableViewCell.swift
//  Nuntium
//
//  Created by Federico Flores on 14/11/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import UIKit
import Kingfisher

class NewsWithImageTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    
    @IBOutlet weak var newsBodyTextView: UITextView!
    
    @IBOutlet weak var sourceNameLabel: UILabel!
    
    @IBOutlet weak var newsSourceAuthorLabel: UILabel!
    
    func setup(news : News) {
        
        newsImageView.kf.setImage(with: URL(string: news.urlToImage))
        newsTitleLabel.text = news.title
        newsBodyTextView.text = news.description
        sourceNameLabel.text = news.source?.name
        newsSourceAuthorLabel.text = news.author
    }
    
    
}
