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
    
    @IBOutlet weak var languageButton: UIBarButtonItem!
    
    let disposeBag = DisposeBag()
    
    private var articles = [Article]()
    private var curLang = "ENG"

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
        
        if (self.curLang == "ENG") {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleCell else {
                fatalError("ArticleCell not found")
            }
            
            cell.titleLabel.text = self.articles[indexPath.row].title
            cell.descripLabel.text = self.articles[indexPath.row].description
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleKorTableViewCell", for: indexPath) as? ArticleKorCell else {
                fatalError("ArticleKorCell not found")
            }
            
            cell.titleLabel.text = self.articles[indexPath.row].title
            
            return cell
        }
        
    }
    
    @IBAction func langButtonPress() {
        if (self.curLang == "ENG") {
            self.curLang = "KOR"
            self.languageButton.title = "ENG"
            self.title = "굿뉴스"
            fetchKorNews()
        } else {
            self.curLang = "ENG"
            self.languageButton.title = "KOR"
            self.title = "GoodNews"
            fetchEngNews()
        }
    }
    
    private func fetchEngNews() {
        
        URLRequest.load(resource: ArticlesList.eng)
            .subscribe(onNext: { [weak self] res in
                if let res = res {
                    self?.articles = res.articles
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
        
    }
    
    private func fetchKorNews() {
        
        URLRequest.load(resource: ArticlesList.kor)
            .subscribe(onNext: { [weak self] res in
                if let res = res {
                    self?.articles = res.articles
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
        
    }
}
