//
//  FavoritesNewsViewController.swift
//  Nuntium
//
//  Created by Federico Flores on 13/12/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import UIKit
import Kingfisher
import AVFoundation
import SafariServices

class FavoritesNewsViewController: UIViewController, SFSafariViewControllerDelegate {
    
    var news: News?
    
    @IBOutlet weak var favoriteNewsImageView: UIImageView!
    
    @IBOutlet weak var favoriteNewsTitleLabel: UILabel!
    
    @IBOutlet weak var favoriteNewsBodyTextView: UITextView!
    
    @IBOutlet weak var favoriteNewsSource: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedNews = news {
            favoriteNewsImageView.kf.setImage(with: URL(string: selectedNews.urlToImage))
            favoriteNewsTitleLabel.text = selectedNews.title
            favoriteNewsBodyTextView.text = selectedNews.description
            favoriteNewsSource.text = selectedNews.source?.name
        }
    }
    
    @IBAction func openSafariTapped(_ sender: UIButton) {
        
        if let news = news {
            let newsUrl = URL(string: news.url)!
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable  = true
            let safari = SFSafariViewController(url: newsUrl, configuration: config)
            safari.delegate = self
            present(safari, animated: true, completion: nil)
            
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}

