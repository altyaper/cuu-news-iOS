//
//  Post.swift
//  CuuCuu
//
//  Created by Jorge Enrique Chavez on 1/31/17.
//  Copyright © 2017 Simplewa. All rights reserved.
//

import Foundation


class Post: SafeJsonObject {
    var articleId: Int = 0
    var title: String = ""
    var thumbnail: String = ""
    var content: String = ""
    var url: String = ""
    var date: String = ""
    var category: String = ""
    var author: String = ""        
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
    override init() {}
    
}
