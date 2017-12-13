//
//  FavoritesTableViewController.swift
//  Nuntium
//
//  Created by Federico Flores on 13/12/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    var newsArray: [News]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavorites()
    }
    
    func getFavorites() {
        let service = NewsService()
        newsArray = service.getFavorites()
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let news = self.newsArray {
            return news.count
        } else {
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 356
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let news = newsArray![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritedNews", for: indexPath)
        if let myCell = cell as? NewsFavoriteTableViewCell {
            myCell.setup(news: news)
        }
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newsArray = newsArray {
            let selectedNews = newsArray[indexPath.row]
            if selectedNews.urlToImage != "no url" {
                performSegue(withIdentifier: "newsWithImage", sender: nil)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FavoritesNewsViewController {
            if let selectedIndexPath = tableView.indexPathForSelectedRow, let newsArray = newsArray {
                
                let selectedNews = newsArray[selectedIndexPath.row]
                destination.news = selectedNews
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removedNews = newsArray!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            let service = NewsService()
            service.delete(news: removedNews)
        }
    }
    
}

