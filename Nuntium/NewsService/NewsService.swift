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
    
    func getNews(sources: String, category: String, language: String, country: String, serviceCompletion: @escaping ([News]) -> Void) {
        let dao = NewsDAO()
        dao.getNews(sources: sources, category: category, language: language, country: country, daoCompletion: serviceCompletion)
    }
    
    func getQuery(q: String, from: String, to: String, language: String, serviceCompletion: @escaping ([News]) -> Void) {
        let dao = NewsDAO()
        dao.getQuery(q: q, from: from, to: to, language: language, daoCompletion: serviceCompletion)
    }
    
    func getSources(category: String, language: String, country: String, serviceCompletion: @escaping ([Source]) -> Void) {
        let dao = NewsDAO()
        dao.getSources(category: category, language: language, country: country, daoCompletion: serviceCompletion)
    }


}
