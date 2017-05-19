//
//  work.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 5. 1..
//  Copyright © 2017년 tdl. All rights reserved.
//

import Foundation
import FirebaseDatabase

class work {
    var ref: FIRDatabaseReference?
    
    var detail : String!
    var endTime : String!
    var startTime : String!
    var title : String!
    var id : Int!
    
    init(snapshot: FIRDataSnapshot) {
        ref = snapshot.ref
        
        var data = snapshot.value as! Dictionary<String, Any>
        
        id = data["id"] as! Int
        title = data["title"] as! String
        detail = data["detail"] as! String
        startTime = data["startTime"] as! String
        endTime  = data["endTime"] as! String
    }
}
