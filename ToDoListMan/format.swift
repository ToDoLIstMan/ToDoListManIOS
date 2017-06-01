//
//  Format.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 5. 19..
//  Copyright © 2017년 tdl. All rights reserved.
//

import Foundation

//int id, String planName, String detail, String startTime, String endTime
class format{
    
    
    var planName: String
    var id : Int
    var detail : String
    var startTime : String
    var endTime : String
    
    
    init(planName : String, id: Int, detail : String, startTime : String, endTime : String) {
        self.planName = planName
        self.id = id;
        self.detail = detail
        self.startTime = startTime
        self.endTime = endTime
    }
}
