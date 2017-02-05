//
//  ViewController.swift
//  CuuCuu
//
//  Created by Jorge Enrique Chavez on 9/12/16.
//  Copyright © 2016 Simplewa. All rights reserved.
//

import UIKit
import Alamofire

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts:[Post] = []
    var selectedPost:Post!
    var lastId: Int = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func pulledDown() {
        
        if #available(iOS 10.0, *) {
            
            var urlLast: String = "https://cuu.herokuapp.com/api/articles/\(self.lastId)/recent"
            
            print(urlLast)
            Alamofire.request(urlLast).responseData { response in
                if let data = response.result.value, let jsonText: String = String(data: data, encoding: .utf8) {
                    
                    var newPosts: [Post] = []
                                        
                    newPosts = Cuu.serialize(jsonText: data)
                    self.posts = newPosts + self.posts
                    if ( newPosts.count != 0) {
                        self.lastId = newPosts.last!.articleId
                    } else {
                        return 
                    }
                    if #available(iOS 10.0, *) {
                        self.tableView.refreshControl?.endRefreshing()
                    } else {
                        // Fallback on earlier versions
                    }
                    self.tableView.reloadData()
                }
            }
            
            self.tableView.refreshControl?.endRefreshing()
        } else {
            // Fallback on earlier versions
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 86/255, green: 67/255, blue: 144/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        let refresh = UIRefreshControl()
        refresh.backgroundColor = UIColor(red: 86/255, green: 67/255, blue: 144/255, alpha: 1)
        refresh.tintColor = UIColor.white
        refresh.addTarget(self, action: #selector(pulledDown), for: .valueChanged)                
        
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refresh
            self.tableView.refreshControl?.beginRefreshing()
        } else {
            // Fallback on earlier versions
        }
        
        Alamofire.request("https://cuu.herokuapp.com/api/articles").responseData { response in
            if let data = response.result.value, let _: String = String(data: data, encoding: .utf8) {
                self.posts = Cuu.serialize(jsonText: data)
                self.lastId = self.posts.last!.articleId
                if #available(iOS 10.0, *) {
                    self.tableView.refreshControl?.endRefreshing()
                } else {
                    // Fallback on earlier versions
                }
                self.tableView.reloadData()
            }
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
        
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellNew") as! NewTableViewCell
        
        cell.title.text = self.posts[indexPath.row].title
        
        cell.category.backgroundColor = UIColor.black    
        cell.category.text = self.posts[indexPath.row].category
        
        var urlString = (self.posts[indexPath.row].url).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlHost: URL = URL(string: urlString!)!
        cell.link.text = urlHost.host
        
        
        if self.posts[indexPath.row].thumbnail != "" {
            
            let thumb:String = self.posts[indexPath.row].thumbnail
            var thumbs: [String] = thumb.characters.split{$0 == ","}.map(String.init)
            let urlString:String = (thumbs[0]).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            cell.thumbnail.sd_setImage(with: URL(string: urlString))
            cell.thumbnail.setShowActivityIndicator(true)
            cell.thumbnail.contentMode = .scaleAspectFill            
        }
    
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.selectedPost = self.posts[indexPath.row]
        performSegue(withIdentifier: "articleSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "articleSegue") {
            
            let destinationVC: ArticleViewController = segue.destination as! ArticleViewController
            
            destinationVC.post = self.selectedPost
            
        }
    }
    
}
