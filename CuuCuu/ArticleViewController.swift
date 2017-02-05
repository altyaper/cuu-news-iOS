//
//  ArticleViewController.swift
//  CuuCuu
//
//  Created by Jorge Enrique Chavez on 2/4/17.
//  Copyright © 2017 Simplewa. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    var post: Post!
    
    @IBOutlet weak var headerHolderView: UIView!    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var navigationBar: UINavigationBar!

    @IBOutlet weak var fuenteLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.navigationBar.isTranslucent = true
        self.navigationBar.tintColor = UIColor.lightGray
        
        self.titleLabel.text = self.post.title
        
        
        let thumb:String = self.post.thumbnail
        var thumbs: [String] = thumb.characters.split{$0 == ","}.map(String.init)
        let thumbnailString:String = (thumbs[0]).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        self.image.sd_setImage(with: URL(string: thumbnailString))
        
        var urlString = (self.post.url).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let urlHost: URL = URL(string: urlString!)!
        
        self.fuenteLabel.text = urlHost.host
        
        self.content.text = self.post.content
        
    }
    @IBAction func dismissWindow(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    }
