//
//  Profile.swift
//  HeartRateApp
//
//  Created by Amanda Goodhines on 12/15/17.
//  Copyright © 2017 Amanda Goodhines. All rights reserved.
//

import UIKit
import og.log
class Profile: NSObject, NSCoding {
    
    //MARK: Properties
    var name: String
    var age: String
    var sport: String
    var photo: UIImage?
    var height: String
    var weight: String
    var userID: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("profiles")
    
    //MARK: Initialization
    init?(name:String, age:String, sport:String, photo:UIImage?, height: String, weight: String, userID: String){
        
        //the name musn't be empty
        guard !name.isEmpty else {
            return nil
        }
       
    
    
    // Initialize stored properties
    self.name = name
    self.age = age
    self.sport = sport
    self.photo = photo
    self.height = height
    self.weight = weight
    self.userID = userID
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(age, forKey: PropertyKey.age)
        aCoder.encode(sport, forKey: PropertyKey.sport)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(height, forKey: PropertyKey.height)
        aCoder.encode(weight, forKey: PropertyKey.weight)
        aCoder.encode(userID, forKey: PropertyKey.userID)
    }
    
    
    //note: look into which variables are optionals. and if they need to be unwinded (which requires the guard & else statement below)
    //other suggested solution is to not have the guard & else statement, and have a ! after the variable in the initialization statement instead. 
    required convenience init?(coder aDecoder: NSCoder) {
        //the name is required, so if we cannot decode a name string, the initializer should fail
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
            else{
                os_log("Unable to decode the name for a Profile object", log: OSLog.default, type: .debug)
                return nil
        }
        guard let age = aDecoder.decodeObject(forKey: PropertyKey.age) as? String
            else{
                os_log("Unable to decode the age for a Profile object", log: OSLog.default, type: .debug)
                return nil
        }
        guard let sport = aDecoder.decodeObject(forKey: PropertyKey.sport) as? String
            else{
                os_log("Unable to decode the sport for a Profile object", log: OSLog.default, type: .debug)
                return nil
        }
        //because photo is an optional property of Profile, jsut use conditional cast
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        guard let height = aDecoder.decodeObject(forKey: PropertyKey.height) as? String
            else{
                os_log("Unable to decode the height for a Profile object", log: OSLog.default, type: .debug)
                return nil
        }
        guard let weight = aDecoder.decodeObject(forKey: PropertyKey.weight) as? String
            else{
                os_log("Unable to decode the weight for a Profile object", log: OSLog.default, type: .debug)
                return nil
        }
        guard let userID = aDecoder.decodeObject(forKey: PropertyKey.userID) as? String
            else{
                os_log("Unable to decode the userid for a Profile object", log: OSLog.default, type: .debug)
                return nil
        }
        
        //Must call a designated initializer
        self.init(name: name, age: age, sport: sport, photo: photo, height: height, weight: weight, userID: userID)
    }
}
