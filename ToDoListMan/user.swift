//
//  user.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 5. 1..
//  Copyright © 2017년 tdl. All rights reserved.
//

import Foundation

class user{
    
    var rank : String
    var name : String
    var groups = [Int]()
    var groupName = [String]()
    var masterGroups = [Int]()
    var masterGroupName = [String]()
    
    
    //String name, String rank, List<Integer> groups, List<String> groupName, List<Integer> masterGroups, List<String> masterGroupName
    init(name : String, rank : String, groups : [Int], groupName : [String], masterGroups : [Int], masterGroupName : [String]) {
        
        self.rank = rank
        self.name = name
        self.groups = groups
        self.groupName = groupName
        self.masterGroups = masterGroups
        self.masterGroupName = masterGroupName
    }
}
