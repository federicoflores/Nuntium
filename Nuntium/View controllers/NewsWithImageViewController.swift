//
//  NewsWithImageViewController.swift
//  Nuntium
//
//  Created by Federico Flores on 14/11/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import UIKit
import Kingfisher
import AVFoundation
import SafariServices

protocol NewsWithImageViewControllerDelegate {
    func didTappedNext(sender: NewsWithImageViewController)
    func didTappedBack(sender: NewsWithImageViewController)
}


class NewsWithImageViewController: UIViewController, SFSafariViewControllerDelegate {
    
    var syntetizerLanguage = ""
    
    let synthesizer = AVSpeechSynthesizer()
    
    var news : News?
    
    var delegate : NewsWithImageViewControllerDelegate?
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var newsAuthorLabel: UILabel!
    
    @IBOutlet weak var newsDateLabel: UILabel!
    
    @IBOutlet weak var newsBodyTextView: UITextView!
    
    @IBOutlet weak var newsSource: UILabel!
    
    func reloadData() {
        if let selectedNews = news {
            newsImageView.kf.setImage(with: URL(string: selectedNews.urlToImage))
            titleLabel.text = selectedNews.title
            newsAuthorLabel.text = selectedNews.author
            newsDateLabel.text = selectedNews.publishedAt
            newsBodyTextView.text = selectedNews.description
            newsSource.text = selectedNews.source?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        let service = NewsService()
        var savedNews = service.getFavorites()
        if let news = news {
            if savedNews.contains(news) {
                favoriteButton.isEnabled = false
            }
            
        }
        
        
        
        
        
        let defaults = UserDefaults.standard
        syntetizerLanguage = defaults.object(forKey: "languageElected") as? String ?? ""
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        syntetizerLanguage = defaults.object(forKey: "languageElected") as? String ?? ""
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        synthesizer.stopSpeaking(at: AVSpeechBoundary.word)
    }
    
    
    @IBAction func speechNextButton(_ sender: UIButton) {
        synthesizer.stopSpeaking(at: AVSpeechBoundary.word)
        delegate?.didTappedNext(sender: self)
    }
    
    @IBAction func speechPlayButton(_ sender: UIButton) {
        if !synthesizer.isSpeaking {
            if let theNews = news{
                let utterance = AVSpeechUtterance(string: "\(theNews.title) \n \n \(theNews.description)")
                utterance.voice = AVSpeechSynthesisVoice(language: selectSyntetizerLenguage())
                utterance.rate = 0.35
                utterance.volume = 0.5
                utterance.pitchMultiplier = 1.0
                
                synthesizer.speak(utterance)
                
            }
        } else {
            synthesizer.continueSpeaking()
            
            }
        }
    
    
    @IBAction func speechStopButton(_ sender: UIButton) {
        synthesizer.stopSpeaking(at: AVSpeechBoundary.word)
        
    }
    
    
    @IBAction func speechBackButton(_ sender: UIButton) {
        synthesizer.stopSpeaking(at: AVSpeechBoundary.word)
        delegate?.didTappedBack(sender: self)
    }
    
    @IBAction func openSafariTapped(_ sender: Any) {
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    func selectSyntetizerLenguage() -> String {
        switch syntetizerLanguage {
        case "es", "es-MX":
            syntetizerLanguage = "es-MX"
            return syntetizerLanguage
        case "fr", "fr-FR":
            syntetizerLanguage = "fr-FR"
            return syntetizerLanguage
        case "it", "it-IT":
            syntetizerLanguage = "it-IT"
            return syntetizerLanguage
        case "de", "de-DE":
            syntetizerLanguage = "de-DE"
            return syntetizerLanguage
        default:
            syntetizerLanguage = "en-US"
            return syntetizerLanguage
            
        }
  
    }
    
    @IBAction func saveFavoriteButtonTapped(_ sender: UIBarButtonItem) {
        let service = NewsService()
        if let news = news {
            service.saveNews(news: news)
            favoriteButton.isEnabled = false
        }
        
    }

    
    

}
