//
//  NewsDao.swift
//  Nuntium
//
//  Created by Federico Flores on 14/11/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import Foundation
import Alamofire

class NewsDAO {
    
    var receivedSources: [Source] = []
    
    func getNews(source: String, category: String, language: String, country: String, daoCompletion: @escaping ([News]) -> Void) {
        
        let parameters = ["source": source,"category": category, "language": language,"country": country, "apiKey": "473528cc5b7d44fa85b372bb1b8dde72"]
        
        Alamofire.request("https://newsapi.org/v2/top-headlines", parameters: parameters, encoding: URLEncoding.default).responseJSON(completionHandler: { response in
            
            var receivedNews: [News] = []
            
            if let value = response.result.value as? [String:AnyObject], let results = value["articles"] as? [[String:AnyObject]] {
                for result in results {
                    let pieceOfNews = News(dict: result)
                    receivedNews.append(pieceOfNews)
                }
                daoCompletion(receivedNews)
            }
        })
    }
    
    
    func getSources(language: String, country: String, category: String, daoCompletion: @escaping ([Source]) -> Void) {
        
        let parameters = ["language": language, "category": category, "country": country]
        
        Alamofire.request("https://newsapi.org/v2/sources", parameters: parameters, encoding: URLEncoding.default).responseJSON(completionHandler: { response in
            
            if let value = response.result.value as? [String:AnyObject], let results = value["sources"] as? [[String:String]] {
                for result in results {
                    let source = Source(dict: result)
                    self.receivedSources.append(source)
                }
                daoCompletion(self.receivedSources)
            }
        })
    }
}

