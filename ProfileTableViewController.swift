//
//  ProfileTableViewController.swift
//  HeartRateApp
//
//  Created by Amanda Goodhines on 12/15/17.
//  Copyright © 2017 Amanda Goodhines. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    //MARK: Properties
    var profiles = [Profile]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //load sample data
       // loadSampleProfiles()
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
  
       //MARK: Actions
    @IBAction func unwindToProfileList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? ProfileViewController, let profile = sourceViewController.profile{
            
            //add new meal
            let newIndexPath = IndexPath(row: profiles.count, section: 0)
            
            profiles.append(profile)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    
    // MARK: Private Methods
    
    // helper method to load sample data
    private func loadSampleMeals(){
   
        //load the images
        let photo1 = UIImage(named: "user1")
        let photo2 = UIImage(named: "user2")
        let photo3 = UIImage(named: "user3")
  
        //create three profile objects
        guard let profile1 = Profile(name: "Lauren Chester", age: "21", sport: "Soccer", photo: photo1) else{fatalError( "Unable to instantiate profile1")}
        
        guard let profile2 = Profile(name: "Danielle Losquadro", age: "20", sport: "Soccer", photo: photo2) else{fatalError("Unable to instantiate profile2")}
        
        guard let profile3 = Profile(name: "Amanda Goodhines", age: "20", sport: "Soccer", photo: photo3) else{fatalError("Unable to instantiate profile3")}
        
        //add profiles to array
        profiles += [profile1, profile2, profile3]
    }
    
    

}