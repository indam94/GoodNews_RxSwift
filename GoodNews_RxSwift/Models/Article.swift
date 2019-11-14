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

struct Article: Decodable{
    let title: String
    let description: String
}
