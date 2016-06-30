//
//  EntryOffer.swift
//  Obligatorio3
//
//  Created by Administrador on 16/6/16.
//  Copyright © 2016 MICHO. All rights reserved.
//

import Foundation

class EntryOffer{
    
    var description : String
    var name : String
    var budget : String?
    var email : String

    init(description : String, name : String, budget : String, email : String){
        self.name = name
        self.description = description
        self.budget = budget
       self.email = email
        }

    
}