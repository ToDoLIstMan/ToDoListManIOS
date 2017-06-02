//
//  userChoos.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 6. 2..
//  Copyright © 2017년 tdl. All rights reserved.
//

import Foundation
class userChoose{
    
    
    var name: String
    var uid : String
    var isCheck : Bool
    var changeCheck : Bool {
        get {
            return self.isCheck
        }
        set(newVal) {
            self.isCheck = newVal
        }
    }
    
    init(name : String, uid : String, isCheck: Bool) {
        self.name = name
        self.uid = uid
        self.isCheck = isCheck
    }
    
}
