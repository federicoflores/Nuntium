//
//  LocalDao.swift
//  Nuntium
//
//  Created by Federico Flores on 13/12/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import Foundation
import CoreData
import Alamofire

class LocalDao {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let storeContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save(news: News) {
        
        let cdNews = NSEntityDescription.insertNewObject(forEntityName: "CDNews", into: storeContext) as! CDNews
        
        cdNews.author = news.author
        cdNews.title = news.title
        cdNews.descriptionn = news.description
        cdNews.url = news.url
        cdNews.urlToImage = news.urlToImage
        cdNews.publishedAt = news.publishedAt
        if let theSource = news.source {
            
            let cdSource = NSEntityDescription.insertNewObject(forEntityName: "CDSource", into: storeContext) as! CDSource
            
            cdSource.id = theSource.id
            cdSource.name = theSource.name
            cdSource.descriptionn = theSource.description
            cdSource.url = theSource.url
            cdSource.category = theSource.category
            cdSource.language = theSource.language
            cdSource.country = theSource.country
            
            cdNews.source = cdSource
        }
        appDelegate.saveContext()
    }
    
    func getLocalNews(query: String) -> [News] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CDNews")
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", query)
        request.sortDescriptors = [NSSortDescriptor(key: "publishedAt", ascending: true)]
        
        let news = fetchCoreDataRequest(request: request)
        return news
    }
    
    func getLocalNews() -> [News] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CDNews")
        let news = fetchCoreDataRequest(request: request)
        return news
    }
    
    
    
    private func fetchCoreDataRequest(request: NSFetchRequest<NSFetchRequestResult>) -> [News] {
        do {
            let cdNews = try storeContext.fetch(request) as! [CDNews]
            
            var news: [News] = []
            for aCDNews in cdNews {
                let aNews = News(from: aCDNews)
                news.append(aNews)
            }
            return news
        } catch {
            print("Hubo un error al querer leer CDNews de CoreData")
        }
        return []
    }
    
    func delete(news: News) {
        if let cdNews = getCoreDataNews(url: news.url) {
            storeContext.delete(cdNews)
            appDelegate.saveContext()
        }
    }
    
    private func getCoreDataNews(url: String) -> CDNews? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CDNews")
        request.predicate = NSPredicate(format: "url == %@", url)
        
        do {
            let cdNews = try storeContext.fetch(request) as! [CDNews]
            return cdNews.first
        } catch {
            print("Hubo un error al querer leer CDNews en CoreData")
        }
        return nil
    }
    
    
    
    
}


