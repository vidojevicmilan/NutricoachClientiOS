//
//  Article.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 2/4/19.
//  Copyright © 2019 Milan Vidojevic. All rights reserved.
//

import Foundation
import UIKit

class Article{
    
    var Title: String
    var Text: String
    var Thumbnail: UIImage
    
    init(title: String, text: String, thumbnail: UIImage){
        Title = title
        Text = text
        Thumbnail = thumbnail
    }
}
