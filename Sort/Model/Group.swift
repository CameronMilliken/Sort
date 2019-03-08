//
//  Group.swift
//  Sort
//
//  Created by Cameron Milliken on 3/7/19.
//  Copyright © 2019 Cameron Milliken. All rights reserved.
//

import Foundation

class Group: Codable {
    
    var personOne: String
    var personTwo: String
    let personList : [String]
    
    init(personOne: String, personTwo: String) {
        self.personOne = personOne
        self.personTwo = personTwo
        self.personList = []
    }
}
