//
//  BlogViewController.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 10/25/18.
//  Copyright © 2018 Milan Vidojevic. All rights reserved.
//

import UIKit
import Firebase

class BlogViewController: UITableViewController {

    var articles = [Article]()
    var selectedArticleInex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("BLOG VIEW CONTROLLER")
        fetchArticles()
    }
    
    func fetchArticles() {
        Database.database().reference().child("articles").observe(.childAdded) { (snapshot) in
            let title = snapshot.childSnapshot(forPath: "title").value as! String
            let text = snapshot.childSnapshot(forPath: "text").value as! String
            let imageBase64 = snapshot.childSnapshot(forPath: "thumbnail").value as! String
            let dataDecoded:NSData = NSData(base64Encoded: imageBase64, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
            
            let article = Article(title: title, text: text, thumbnail: UIImage(data: dataDecoded as Data)!)
            self.articles.insert(article,at: 0)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        cell.article = articles[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedArticleInex = indexPath.row
        performSegue(withIdentifier: "goToArticle", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToArticle" {
            let vc = segue.destination as! ArticleViewController
            vc.article = articles[selectedArticleInex]
        }
    }
    
    

}
