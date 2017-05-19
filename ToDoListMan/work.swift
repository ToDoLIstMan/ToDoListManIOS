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
    var name = [String]()
    var uId = [String]()
    var isDone = [Bool] ()
    
    //int id, String title, String detail, String startTime, String endTime,List<String> name,List<String> uId,List<Boolean> isDone
    init(id :Int, title : String, detail : String, startTime : String, endTime : String, name : [String], uId : [String], isDone : [Bool]) {
        self.id = id
        self.title = title
        self.detail = detail
        self.startTime = startTime
        self.endTime = endTime
        self.name = name
        self.uId = uId
        self.isDone = isDone
    }
}
