//
//  URLRequest+Extensions.swift
//  GoodNews_RxSwift
//
//  Created by DONGGUN LEE on 11/13/19.
//  Copyright © 2019 DONGGUN LEE. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T: Decodable>{
    let url: URL
}

extension URLRequest{
     
//    static func load<T>(resource: Resource<T>) -> Observable<T?>{
       static func load<T>(resource: Resource<T>) -> Observable<T>{
//        return Observable.from([resource.url])
//            .flatMap{ url -> Observable<Data> in
//                    let request = URLRequest(url: url)
//
//                    return URLSession.shared.rx.data(request: request)
//            }.map{ data -> T? in
//
//                return try? JSONDecoder().decode(T.self, from: data)
//
//        }.asObservable()
        
        return Observable.just(resource.url)
            .flatMap{ url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
        }.map{ data -> T in
            return try JSONDecoder().decode(T.self, from: data)
        }.asObservable()
        
    }
    
}
