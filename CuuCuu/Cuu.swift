//
//  Cuu.swift
//  CuuCuu
//
//  Created by Jorge Enrique Chavez on 1/31/17.
//  Copyright © 2017 Simplewa. All rights reserved.
//

import Foundation


class Cuu: SafeJsonObject {
    
    static func serialize(jsonText: Data) -> [Post] {
        
        
        var posts:[Post] = []
        do {
            
            let jsonPost = try? JSONSerialization.jsonObject(with: jsonText) as! [Dictionary<String, AnyObject>]
                        
            for post in jsonPost! {
                
                if let postDictionary = post as? [String: AnyObject] {
                    let postObject: Post = Post()                    
                    postObject.setValuesForKeys(postDictionary)
                    posts.append(postObject)
                }
            }
            
            return posts                        
            
        } catch let error as NSError {
            print( "Error: \(error)")
        }
        return posts
        
        
    }
    
    
    
    
}
