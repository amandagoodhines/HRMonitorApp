//
//  Profile.swift
//  HeartRateApp
//
//  Created by Amanda Goodhines on 12/15/17.
//  Copyright © 2017 Amanda Goodhines. All rights reserved.
//

import UIKit
class Profile{
    //MARK: Properties
    
    var name: String
    var age: String
    var sport: String
    var photo: UIImage?
    var height: String
    var weight: String
    var userID: String
    
    //MARK: Initialization
    init?(name:String, age:String, sport:String, photo:UIImage?, height: String, weight: String, userID: String){
        
        //the name musn't be empty
        guard !name.isEmpty else {
            return nil
        }
        /*
        //the age has to be a positive number
        guard (age > 0)  else{
            return nil
        }*/
    
    
    // Initialize stored properties

    self.name = name
    self.age = age
    self.sport = sport
    self.photo = photo
    self.height = height
    self.weight = weight
    self.userID = userID

    }
    
}
