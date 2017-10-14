//
//  DataService.swift
//  MultiThreading
//
//  Created by pari on 14/10/17.
//  Copyright © 2017 pari. All rights reserved.
//

import Foundation

class Contacts : Codable{
    let contacts : [contact]
    init(contacts:[contact]) {
        self.contacts = contacts
    }
}

class contact : Codable{
    let id : String
    let name : String
    let email : String
    let address : String
    let gender : String
    let phone : Phone
    init(id : String,name:String,email:String,address:String,gender:String,phone:Phone) {
        self.id = id
        self.name = name
        self.email = email
        self.address = address
        self.gender = gender
        self.phone = phone
    }
    
}

class Phone : Codable {
    let mobile : String
    let home : String
    let office : String
    init(mobile : String,home : String,office : String) {
        self.mobile = mobile
        self.home = home
        self.office = office
    }
}
