//
//  NewsService.swift
//  Nuntium
//
//  Created by Federico Flores on 14/11/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//

import Foundation

import Foundation

class NewsService {
    
    func getNews(source: String, category: String, language: String, country: String, serviceCompletion: @escaping ([News]) -> Void) {
        let dao = NewsDAO()
        dao.getNews(source: source, category: category, language: language, country: country, daoCompletion: serviceCompletion)
    }
    
    
}
