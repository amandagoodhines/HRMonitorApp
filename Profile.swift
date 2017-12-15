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
    
    //MARK: Initialization
    init?(name:String, age:String, sport:String, photo:UIImage?){
        
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
    }
    
}
