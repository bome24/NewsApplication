//
//  NewsTableViewController.swift
//  GoodNewsApplication
//
//  Created by BoMin on 2023/03/08.
//

import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    
    private var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchEngNews()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleCell else {
            fatalError("ArticleCell not found")
        }
        
        cell.titleLabel.text = self.articles[indexPath.row].title
        cell.descripLabel.text = self.articles[indexPath.row].description
        
        return cell
        
    }
    
    private func fetchEngNews() {
        
        let engURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=b85fd2ea4fda4570a2cd9e191a05f021")!
        
        Observable.just(engURL)
            .flatMap{ url -> Observable<Data> in
                let request = URLRequest(url: engURL)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> [Article]? in
                return try? JSONDecoder().decode(ArticlesList.self, from: data).articles
            }.subscribe(onNext: { [weak self] articles in
                
                if let articles = articles {
                    self?.articles = articles
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
                
            }).disposed(by: disposeBag)
        
    }
}
