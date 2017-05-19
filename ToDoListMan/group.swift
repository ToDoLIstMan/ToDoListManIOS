//
//  group.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 5. 1..
//  Copyright © 2017년 tdl. All rights reserved.
//

import Foundation
import FirebaseDatabase

class group{
    
    var ref: FIRDatabaseReference?
    
    var groupName: String
    var id : Int
    var masterUid : String
    var memberName = [String?]()
    var memberUid = [String?]()
    
    let x: AnyObject = NSNull()
    
    init(groupName : String, id: Int, masterUid : String, memberName :[String], memberUid : [String]) {
        self.groupName = groupName
        self.id = id;
        self.masterUid = masterUid
        self.memberName = memberName
        self.memberUid = memberUid
    }
    

    var _gName : String{
        get{
            return self.groupName
        }
    }
    
}
