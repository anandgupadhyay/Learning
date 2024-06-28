//
//  keyValueObserving.swift
//  Learning
//
//  Created by Anand Upadhyay on 28/06/24.
//

import Foundation

class KVOEmployee: NSObject{
    
    internal init(firstName: String, eId: Int) {
        self.firstName = firstName
        self.eId = eId
    }
    
    @objc dynamic var firstName: String
    @objc dynamic var eId: Int
    
    
}
