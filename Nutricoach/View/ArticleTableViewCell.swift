//
//  ArticleTableViewCell.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 2/4/19.
//  Copyright © 2019 Milan Vidojevic. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var shadow: UILabel!
    
    var article: Article! {
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        thumbnailImageView.image = article.Thumbnail
        thumbnailImageView.layer.cornerRadius = 10
        thumbnailImageView.layer.masksToBounds = true
        titleLabel.text = article.Title
        bodyLabel.text = "  " + article.Text
        shadow.layer.cornerRadius = 10
        shadow.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
