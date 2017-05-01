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
    
    let groupName: String
    let id : Int
    let masterUid : String
    let memberName : [String]
    let memberUid : [String]
    
    init(snapshot: FIRDataSnapshot) {
        ref = snapshot.ref
        
        print(snapshot.value)
        let data = snapshot.value as! Dictionary<String, Any>
        
        self.groupName = data["groupName"] as! String
        self.id = data["id"] as! Int
        self.masterUid = data["masterUid"] as! String
        self.memberUid = ["ㅁㄴㅇㄹ","ㅁㄴㅇㄹ"]
        self.memberName = ["ㄴㅇㄹㅎ","ㄴㅇㄹㅎ"]
        
    }
    
}
