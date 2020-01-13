//
//  ViewController.swift
//  QittaApiApp
//
//  Created by 小澤謙太郎 on 2020/01/12.
//  Copyright © 2020 小澤謙太郎. All rights reserved.
//

import UIKit
import SafariServices
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,SFSafariViewControllerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    let qittaViewModel = QiitaViewModel()
    fileprivate var articles: [QiitaStruct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        title = "Qitta記事"
        qittaViewModel.fetchArticle(completion: { (articles) in
            self.articles = articles
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let safariViewController = SFSafariViewController(url: articles[indexPath.row].url)
        safariViewController.delegate  = self
        present(safariViewController,animated: true,completion: nil)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.title
        cell.detailTextLabel?.text = article.user.name
        return cell
    }
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }

}

