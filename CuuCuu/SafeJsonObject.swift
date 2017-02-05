//
//  SafeJsonObject.swift
//  CuuCuu
//
//  Created by Jorge Enrique Chavez on 1/31/17.
//  Copyright © 2017 Simplewa. All rights reserved.
//

import Foundation

class SafeJsonObject: NSObject {
    
    override func setValue(_ value: Any?, forKey key: String) {
        var selectorString: String = "set\(key.uppercased().characters.first!)\(String(key.characters.dropFirst())):"        
        let selector = Selector(selectorString)
        if responds(to: selector) {
            super.setValue(value, forKey: key)
        }
    }
}
