//
//  Source.swift
//  Nuntium
//
//  Created by Federico Flores on 14/11/17.
//  Copyright © 2017 Federico Flores. All rights reserved.
//


import Foundation

class Source {
    var id: String
    var name: String
    var description: String
    var url: String
    var category: String
    var language: String
    var country: String
    
    init(from CDSource: CDSource) {
        id = CDSource.id ?? ""
        name = CDSource.name ?? ""
        description = CDSource.descriptionn ?? ""
        url = CDSource.url ?? ""
        category = CDSource.category ?? ""
        language = CDSource.language ?? ""
        country = CDSource.country ?? ""
    }

    
    init(id: String, name: String, description: String, url: String, category: String, language: String, country: String, urlsToLogos: [String:String], sortBysAvailable: [String]) {
        self.id = id
        self.name = name
        self.description = description
        self.url = url
        self.category = category
        self.language = language
        self.country = country

    }
    
    
    init(dict: [String:String]) {
        self.id = dict["id"] ?? "no id"
        self.name = dict["name"] ?? "no name"
        self.description = dict["description"] ?? "no description"
        self.url = dict["url"] ?? "no url"
        self.category = dict["category"] ?? "no category"
        self.language = dict["language"] ?? "no language"
        self.country = dict["country"] ?? "no country"
        

        
    }
    
    
    
}

