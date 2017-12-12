//
//  MainTableViewController.swift
//  Nuntium
//
//  Created by Federico Flores on 14/11/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//


import UIKit
import AVFoundation

class MainTableViewController: UITableViewController,  NewsWithImageViewControllerDelegate {
    


    var infoOrigin = ""
    
    var selectedCategory : String = ""
    var selectedLanguage : String = ""
    var selectedCountry : String = ""
    
    var query = ""
    var selectedFromDate : String = ""
    var selectedToDate : String = ""
    
    var sourcesSelected : String = ""

    var newsArray: [News] = []
    

    var selectedNewsIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.isHidden = true
        
//        let defaults = UserDefaults .standard
//
//        selectedLanguage = defaults.object(forKey: "languageElected") as? String ?? ""
//
//        let service = NewsService()
//        if selectedLanguage != "" {
//        service.getNews(source: "", category: "", language: selectedLanguage, country: "", serviceCompletion: {response in
//            self.newsArray = response
//            self.tableView.reloadData()
//
//            let filteredArray = self.newsArray.filter {$0.source?.name != "ABC News" && $0.source?.name != "Al Jazeera English"}
//
//            self.newsArray = filteredArray
//            self.tableView.isHidden = false
//        })
//        } else {
//            service.getNews(source: "", category: "", language: "es", country: "", serviceCompletion: {response in
//                self.newsArray = response
//                self.tableView.reloadData()
//
//                let filteredArray = self.newsArray.filter {$0.source?.name != "ABC News" && $0.source?.name != "Al Jazeera English"}
//
//                self.newsArray = filteredArray
//                self.tableView.isHidden = false
//            })
//
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        let defaults = UserDefaults.standard
        
        selectedLanguage = defaults.object(forKey: "languageElected") as? String ?? ""
        
        switch infoOrigin {
        case "Categories" :
        let service = NewsService()
        service.getNews(sources: "", category: selectedCategory, language: selectedLanguage, country: "", serviceCompletion: {response in
            self.newsArray = response
            self.tableView.reloadData()
            
            let filteredArray = self.newsArray.filter {$0.source?.name != "ABC News" && $0.source?.name != "Al Jazeera English" && $0.source?.name != "BBC Sport" && $0.source?.name != "Vice News"}
            
            self.newsArray = filteredArray
            self.tableView.reloadData()
        })
        case "Query":
            let service = NewsService()
            service.getQuery(q: query, from: selectedFromDate, to: selectedToDate, language: selectedLanguage, serviceCompletion: {response in
                self.newsArray = response
                self.tableView.reloadData()
                let filteredArray = self.newsArray.filter {$0.source?.name != "ABC News" && $0.source?.name != "Al Jazeera English" && $0.source?.name != "BBC Sport" && $0.source?.name != "Vice News"}
                self.newsArray = filteredArray
                self.tableView.reloadData()
            })
        case "Sources":
            let service = NewsService()
            service.getNews(sources: sourcesSelected, category: "", language: selectedLanguage, country: "", serviceCompletion: {response in
                self.newsArray = response
                self.tableView.reloadData()
                
                let filteredArray = self.newsArray.filter {$0.source?.name != "ABC News" && $0.source?.name != "Al Jazeera English" && $0.source?.name != "BBC Sport" && $0.source?.name != "Vice News"}
                
                self.newsArray = filteredArray
                self.tableView.reloadData()
            })
            
        default:
            
            
            let service = NewsService()
            if selectedLanguage != "" {
                service.getNews(sources: "", category: "", language: selectedLanguage, country: "", serviceCompletion: {response in
                    self.newsArray = response
                    self.tableView.reloadData()
                    
                    let filteredArray = self.newsArray.filter {$0.source?.name != "ABC News" && $0.source?.name != "Al Jazeera English"}
                    
                    self.newsArray = filteredArray
                    self.tableView.isHidden = false
                })
            } else {
                service.getNews(sources: "", category: "", language: "es", country: "", serviceCompletion: {response in
                    self.newsArray = response
                    self.tableView.reloadData()
                    
                    let filteredArray = self.newsArray.filter {$0.source?.name != "ABC News" && $0.source?.name != "Al Jazeera English"}
                    
                    self.newsArray = filteredArray
                    self.tableView.isHidden = false
                })
                
            }
            
        break
        }
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.newsArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let news = newsArray[indexPath.row]
        if news.urlToImage != "no url" {
            return 356
        } else {
            return 237
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = newsArray[indexPath.row]
        if news.urlToImage != "no url" || news.urlToImage != ""  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newWithImage", for: indexPath)
            if let myCell = cell as? NewsWithImageTableViewCell {
                myCell.setup(news: news)
            }
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "notImageNews", for: indexPath)
            if let myCell = cell as? NotImageNewsTableViewCell {
                myCell.setup(news: news)
            }
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNews = newsArray[indexPath.row]
        if selectedNews.urlToImage != "no url" {
            performSegue(withIdentifier: "newsWithImage", sender: nil)
        }
        else {
            performSegue(withIdentifier: "notImageNews", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? NewsWithImageViewController {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                selectedNewsIndex = selectedIndexPath.row
                let selectedNews = newsArray[selectedIndexPath.row]
                destination.news = selectedNews
                destination.delegate = self
            }
        } else {
            if let destination = segue.destination as? NotImageNewsViewController {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    let selectedNews = newsArray[selectedIndexPath.row]
                    destination.news = selectedNews
                }
            }
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    func didTappedNext(sender: NewsWithImageViewController) {
        self.selectedNewsIndex = selectedNewsIndex + 1
        let nextNews = self.newsArray[selectedNewsIndex]
        sender.news = nextNews
        sender.syntetizerLanguage = selectedLanguage
        sender.reloadData()
    }
     func didTappedBack(sender: NewsWithImageViewController) {
            if selectedNewsIndex != 0 {
            self.selectedNewsIndex = selectedNewsIndex - 1
            let nextNews = self.newsArray[selectedNewsIndex]
            sender.news = nextNews
                sender.syntetizerLanguage = selectedLanguage
            sender.reloadData()
        }
    }

}
