//
//  BlogViewController.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 10/25/18.
//  Copyright © 2018 Milan Vidojevic. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class BlogViewController: UITableViewController {

    var articles = [(id: String, article: Article)]()
    var selectedArticleInex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("BLOG VIEW CONTROLLER")
        articleAddedListener()
        articleChangedListener()
        articleRemovedListener()
    }
    
    func articleAddedListener() {
        Database.database().reference().child("articles").observe(.childAdded) { (snapshot) in
            let id = snapshot.key
            let title = snapshot.childSnapshot(forPath: "title").value as! String
            let text = snapshot.childSnapshot(forPath: "text").value as! String
            var image : UIImage!
            Storage.storage().reference().child("articles/\(id).png").getData(maxSize: 1024*1024*4, completion: { (data, err) in
                if err != nil || data == nil {
                    image = UIImage(named: "gallery")
                } else {
                    image = UIImage(data: data!)
                }
                let article = Article(title: title, text: text, thumbnail: image)
                self.articles.insert((id, article), at: 0)
                self.articles.sort(by: { (arg0, arg1) -> Bool in
                    return(arg0.id > arg1.id)
                })
                self.tableView.reloadData()
            })
        }
    }
    
    func articleChangedListener() {
        Database.database().reference().child("articles").observe(.childChanged) { (snap) in
            let id = snap.key
            let title = snap.childSnapshot(forPath: "title").value as! String
            let text = snap.childSnapshot(forPath: "text").value as! String
            var image : UIImage!
            
            Storage.storage().reference().child("articles/\(id).png").getData(maxSize: 1024*1024*4, completion: { (data, err) in
                if err != nil {
                    image = UIImage(named: "gallery")
                } else {
                    image = UIImage(data: data!)
                }
                
                for i in 0..<self.articles.count {
                    if self.articles[i].id == id {
                        self.articles[i].article = Article(title: title, text: text, thumbnail: image)
                    }
                }
                self.tableView.reloadData()
            })
        }
    }
    
    func articleRemovedListener(){
        Database.database().reference().child("articles").observe(.childRemoved) { (snapshot) in
            let id = snapshot.key
            for index in 0..<self.articles.count {
                if self.articles[index].id == id {
                    self.articles.remove(at: index)
                    self.tableView.reloadData()
                    return
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        cell.article = articles[indexPath.row].article
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
            vc.article = articles[selectedArticleInex].article
        }
    }
    
    

}
