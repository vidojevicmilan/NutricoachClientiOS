//
//  ArticleViewController.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 2/4/19.
//  Copyright © 2019 Milan Vidojevic. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initScrollView()
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func initScrollView(){
        let sv = UIScrollView()
        sv.backgroundColor = .white
        sv.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sv)
        NSLayoutConstraint.activate([
            sv.topAnchor.constraint(equalTo: self.view.topAnchor),
            sv.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            sv.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            sv.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        let aspect: Float = Float(article!.Thumbnail.size.width) / Float(article!.Thumbnail.size.height)
        let thumbnailImage = UIImageView()
        thumbnailImage.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImage.image = article?.Thumbnail
        sv.addSubview(thumbnailImage)
        thumbnailImage.topAnchor.constraint(equalTo: sv.topAnchor).isActive = true
        thumbnailImage.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        thumbnailImage.heightAnchor.constraint(equalToConstant: (self.view.frame.width / CGFloat(aspect))).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = article?.Title
        sv.addSubview(titleLabel)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleLabel.leadingAnchor.constraint(equalTo: sv.leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: thumbnailImage.bottomAnchor, constant: 10).isActive = true
        titleLabel.numberOfLines = 0
        titleLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width - 40).isActive = true
        
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = article!.Text + article!.Text + article!.Text
        sv.addSubview(textLabel)
        textLabel.leadingAnchor.constraint(equalTo: sv.leadingAnchor, constant: 10).isActive = true
        textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        textLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width-20).isActive = true
        textLabel.numberOfLines = 0
        
        sv.bottomAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20).isActive = true
        
    }
    
    

}
