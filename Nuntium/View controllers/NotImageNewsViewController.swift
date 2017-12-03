//
//  NotImageNewsViewController.swift
//  Nuntium
//
//  Created by Federico Flores on 14/11/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import UIKit

class NotImageNewsViewController: UIViewController {
    
    var news : News?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var newsAuthorLabel: UILabel!
    
    @IBOutlet weak var newsDateLabel: UILabel!
    
    @IBOutlet weak var newsBodyTextView: UITextView!
    
    @IBOutlet weak var newsSourceNameLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedNews = news {
            titleLabel.text = selectedNews.title
            newsAuthorLabel.text = selectedNews.author
            newsDateLabel.text = selectedNews.publishedAt
            newsBodyTextView.text = selectedNews.description
            newsSourceNameLabel.text = selectedNews.source?.name
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
