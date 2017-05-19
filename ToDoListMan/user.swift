//
//  user.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 5. 1..
//  Copyright © 2017년 tdl. All rights reserved.
//

import Foundation
import FirebaseDatabase

class user{
    var ref: FIRDatabaseReference?
    
    var rank : String
    var name : String
    var groups = [Int]()
    var groupName = [String]()
    var masterGroups = [Int]()
    var masterGroupName = [String]()
    
    init(snapshot: FIRDataSnapshot) {
        ref = snapshot.ref
        
        let data = snapshot.value as! Dictionary<String, Any>
        self.rank = data["rank"] as! String
        self.name = data["name"] as! String
        self.groups.append(contentsOf: (data["groups"] as! [Int]))
        self.groupName.append(contentsOf: data["groupName"] as! [String])
        self.masterGroups.append(contentsOf: data["masterGroups"] as! [Int])
        self.masterGroupName.append(contentsOf: data["masterGroupName"] as! [String])
    }
}
