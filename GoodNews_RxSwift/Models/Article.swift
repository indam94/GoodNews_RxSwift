//
//  Article.swift
//  GoodNews_RxSwift
//
//  Created by DONGGUN LEE on 11/13/19.
//  Copyright © 2019 DONGGUN LEE. All rights reserved.
//

import Foundation

struct ArticleList: Decodable{
    let articles: [Article]
}

extension ArticleList{
    static var all: Resource<ArticleList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(NEWS_API_KEY)")!
        return Resource(url: url)
    }()
}

struct Article: Decodable{
    let title: String
    let description: String?
}
