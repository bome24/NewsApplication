//
//  Article.swift
//  GoodNewsApplication
//
//  Created by BoMin on 2023/03/08.
//

import Foundation

struct ArticlesList: Decodable {
    let articles: [Article]
}

extension ArticlesList {
    
    static var eng: Resource<ArticlesList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=b85fd2ea4fda4570a2cd9e191a05f021")!
        return Resource(url: url)
    }()

    static var kor: Resource<ArticlesList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=kr&apiKey=b85fd2ea4fda4570a2cd9e191a05f021")!
        return Resource(url: url)
    }()
    
}

struct Article: Decodable {
    let title: String
    let description: String?
}
