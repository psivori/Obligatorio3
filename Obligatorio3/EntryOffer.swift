//
//  EntryOffer.swift
//  Obligatorio3
//
//  Created by Administrador on 16/6/16.
//  Copyright © 2016 MICHO. All rights reserved.
//

import Foundation

class EntryOffer{
    
    var title : String
    var name : String
    var lastName : String?
    var price : String?
    var details : String


    init(title : String, name : String, lastName : String, price : String, details : String){
        self.name = name
        self.title = title
        self.lastName = lastName
        self.price = price
        self.details = details
       
        }

    
}