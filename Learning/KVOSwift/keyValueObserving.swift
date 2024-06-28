//
//  keyValueObserving.swift
//  Learning
//
//  Created by Anand Upadhyay on 28/06/24.
//

//How to quickly generate initialiser for a class
//Just create your class, add your properties and then Right Click on it > Refactor > Generate Memberwise initializer as such: This will automatically create an initializer for you, which is at least for me a huge time saver, and one of the reasons that always made structs so appealing for me

import Foundation

class KVOEmployee: NSObject{
    
    internal init(firstName: String, eId: Int) {
        self.firstName = firstName
        self.eId = eId
    }
    
    @objc dynamic var firstName: String
    @objc dynamic var eId: Int
    
    
}
