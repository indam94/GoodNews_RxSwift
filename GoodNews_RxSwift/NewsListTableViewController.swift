//
//  NewsListTableViewController.swift
//  GoodNews_RxSwift
//
//  Created by DONGGUN LEE on 11/13/19.
//  Copyright © 2019 DONGGUN LEE. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsListTableViewController: UITableViewController{
    
    let disposeBag = DisposeBag()
    
    private var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        populateNews()
    }
    
    private func populateNews(){
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(NEWS_API_KEY)")!
        
        Observable.just(url)
            .flatMap{ url -> Observable<Data> in
                let request = URLRequest(url: url)
                
                return URLSession.shared.rx.data(request: request)
        }.map{ data -> [Article]? in
            
            return try? JSONDecoder().decode(ArticleList.self, from: data).articles
            
        }.subscribe(onNext:{ [weak self] articles in
            
            if let articles = articles{
                self?.articles = articles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            
            }).disposed(by: disposeBag)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleListTableViewCell", for: indexPath) as? ArticleListTableViewCell else{
            fatalError("ArticleListTableViewCell is not exist")
        }
        cell.titleLabel?.text = self.articles[indexPath.row].title
        cell.descriptionLabel?.text = self.articles[indexPath.row].description
                
        return cell
    }
}
