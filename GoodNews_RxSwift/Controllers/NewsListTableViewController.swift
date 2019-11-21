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
    
    private var articleListVM: ArticleListViewModel!
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        populateNews()
    }
    
    private func populateNews(){
        
//        URLRequest.load(resource: ArticleList.all).subscribe(onNext:{
//            [weak self] result in
//            if let result = result {
//                self?.articles = result.articles
//                DispatchQueue.main.async {
//                    self?.tableView.reloadData()
//                }
//            }
//            }).disposed(by: disposeBag)
        
        URLRequest.load(resource: ArticleList.all).subscribe(
            onNext: { articleResponse in
                let articles = articleResponse.articles
                self.articleListVM = ArticleListViewModel(articles)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.articlesVM.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleListTableViewCell", for: indexPath) as? ArticleListTableViewCell else{
            fatalError("ArticleListTableViewCell is not exist")
        }
        
        let articleVM = self.articleListVM.articleAt(indexPath.row)
        
        articleVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        articleVM.description.asDriver(onErrorJustReturn: "")
        .drive(cell.descriptionLabel.rx.text)
        .disposed(by: disposeBag)
                
        return cell
    }
}
