//
//  ProfileTableViewController.swift
//  HeartRateApp
//
//  Created by Amanda Goodhines on 12/15/17.
//  Copyright © 2017 Amanda Goodhines. All rights reserved.
//

import UIKit
impot os.log

class ProfileTableViewController: UITableViewController {

    //MARK: Properties
    var profiles = [Profile]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // use the edit button provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem
       
           //Load any saved profiles, otherwise upload sample data
        if let savedProfiles = loadProfiles() {
            profiles += savedProfiles
        }
        else{
            //load sample data
            loadSampleProfiles()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        //Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "ProfileTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProfileTableViewCell else{
            fatalError("The dequeued cell is not an instance of ProfileTableViewCell")
        }
        // fetches the appropriate profile for the data source layout
        let profile = profiles[indexPath.row]
        
        
        cell.nameLabel.text = profile.name
        cell.ageLabel.text = profile.age
        cell.sportLabel.text = profile.sport
        cell.photoImageView.image = profile.photo
        cell.heightLabel.text = profile.height
        cell.weightLabel.text = profile.weight
        cell.userIDLabel.text = profile.userID
        
        return cell
    }
  

   
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
   

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            profiles.remove(at: indexPath.row)
            saveProfiles()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

   
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
 

  
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
 

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender:sender)
        
        switch(segue.identifier ?? ""){
        
        case "AddItem":
            os_log("Adding a new profile", log: OSLog.default, type: .debug)
        
        case "ShowDetail":
            guard let profileDetailViewController = segue.destination as? ProfileViewController
                else{
                    fatalError("Unexpected Destination \(segue.destination) ")
            }
            
            guard let selectedProfileCell = sender as? ProfileTableViewCell else{
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedProfileCell) else{
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedProfile = profiles[indexPath.row]
            profileDetailViewController.profile = selectedProfile
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier) ")
        }    
    }
  
    
       //MARK: Actions
    @IBAction func unwindToProfileList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? ProfileViewController, let profile = sourceViewController.profile{
            
            
            if let selectedIndexpath = tableView.indexPathForSelectedRow{
                //Update existing meal.
                profiles[selectedIndexpath.row] = profile
                tableView.reloadRows(at: [selectedIndexpath], with: .none)
            }
            else{
                //add a new profile
                let newIndexPath = IndexPath(row:profiles.count, section:0)
                
                profiles.append(profile)
                
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            //Save the profiles
            saveProfiles()
        }
    }
    
    
    // MARK: Private Methods
    
    // helper method to load sample data
    private func loadSampleProfiles(){
   
        //load the images
        let photo1 = UIImage(named: "user1")
        let photo2 = UIImage(named: "user2")
        let photo3 = UIImage(named: "user3")
  
        //create three profile objects
        guard let profile1 = Profile(name: "Lauren Chester", age: "21", sport: "Soccer", photo: photo1, height: "68", weight: "160", userID: "LC08") else{fatalError( "Unable to instantiate profile1")}
        
        guard let profile2 = Profile(name: "Danielle Losquadro", age: "20", sport: "Soccer", photo: photo2, height: "65", weight: "152", userID: "D123") else{fatalError("Unable to instantiate profile2")}
        
        guard let profile3 = Profile(name: "Amanda Olsen", age: "22", sport: "Basketball", photo: photo3, height: "71", weight: "172", userID: "WO33") else{fatalError("Unable to instantiate profile3")}
        
        //add profiles to array
        profiles += [profile1, profile2, profile3]
    }
    
    private func saveProfiles(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(profiles, toFile: Profile.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Profiles successfully saved", log: OSLog.default, type: .debug)
        }else{
            os_log("Failed to save profiles...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadProfiles() -> [Profile]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Profile.ArchiveURL.path) as? [Profile]
    }

}
