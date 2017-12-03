//
//  News.swift
//  Nuntium
//
//  Created by Federico Flores on 14/11/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import Foundation

class News {
    var author: String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var source: Source?
    
    init(author: String, title: String, description: String, url: String, urlToImage: String, publishedAt: String, hasImage: Bool, source: String) {
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        
    }
    
    init(dict:[String:AnyObject]) {
        self.author = dict["author"] as? String ?? ""
        self.title = dict["title"] as? String ?? "no title"
        self.description = dict["description"] as? String ?? "no description"
        self.url = dict["url"] as? String ?? "no url"
        self.urlToImage = dict["urlToImage"] as? String ?? "no urlToImage"
        self.publishedAt = dict["publishedAt"] as? String ?? "no publishedAt"
        if let sourceInfo = dict["source"] as? [String:String] {
            let sourceValue = Source(dict: sourceInfo)
            self.source = sourceValue
        }
    }
}


