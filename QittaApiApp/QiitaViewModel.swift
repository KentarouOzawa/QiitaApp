//
//  QiitaViewModel.swift
//  QittaApiApp
//
//  Created by 小澤謙太郎 on 2020/01/12.
//  Copyright © 2020 小澤謙太郎. All rights reserved.
//
import UIKit
struct QiitaStruct:Codable {
    var title:String
    var user:User
    var url:URL
    struct User:Codable {
        var name:String
    }
}

class QiitaViewModel{
     func fetchArticle(completion:@escaping([QiitaStruct])-> Swift.Void){
        let url = "https://qiita.com/api/v2/items"
        guard var urlComponents = URLComponents(string:url) else {
            return
        }
        urlComponents.queryItems = [
            URLQueryItem(name:"per_pege",value:"50")]
        let task = URLSession.shared.dataTask(with: urlComponents.url!){data,response,error in
        guard let jsonData = data else { return }
        
        do {
            let articles = try JSONDecoder().decode([QiitaStruct].self, from: jsonData)
            completion(articles)
        } catch  {
            print(error.localizedDescription)
            }
        }
    task.resume()
}

}

