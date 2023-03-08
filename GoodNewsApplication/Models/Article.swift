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

struct Article: Decodable {
    let title: String
    let description: String
}
