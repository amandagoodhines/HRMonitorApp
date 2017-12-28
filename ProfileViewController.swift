//
//  ProfileViewController.swift
//  HeartRateApp
//
//  Created by Amanda Goodhines on 12/14/17.
//  Copyright © 2017 Amanda Goodhines. All rights reserved.
//

import UIKit
import os.log

class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    //MARK: Properties
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var sportTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var userIDTextField: UITextField!
    
    
    
    
    /* This value is either passed by 'ProfileTableViewController' in 'prepare(for:sender:)' or constructed as part of adding a new profile.*/
    var profile: Profile?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle text field's user input through delegate callbacks.
        nameTextField.delegate = self
        
        //enable the save button only if the text field has a valid profile name
       // updateSaveButtonState()
    }

    
    
    
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide keyboard
        textField.resignFirstResponder()
        return true
    }
    
    /* func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = title.text
    }*/
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //ensable the save button while editing
        saveButton.isEnabled = true
    }
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //dismiss the picker if canceled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //the info dictionary may contain multiple representations of the image. you want to use the original
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            fatalError("Expected a dictionary containing an image, but was provided the following \(info)")
        }
        
        //set photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        //dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //This method lets you configure a view controller before it's presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        super.prepare(for: segue, sender: sender)
        
        //configure the destination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button == saveButton else{
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let age = ageTextField.text
        let sport = sportTextField.text
        let photo = photoImageView.image
        let height = heightTextField.text
        let weight = weightTextField.text
        let userID = userIDTextField.text
        
     
        
    
        
        //set the profile to be passed to ProfileTableViewController after the unwind segue.... initializes them.
        profile = Profile(name:name, age:age!, sport:sport!, photo:photo, height:height!, weight:weight!, userID:userID!)
    }
    
  
    
    
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        //hides keyboard
        nameTextField.resignFirstResponder()
        
        //UIImagePickerController is a view controller that allows people to pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
        //only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        //make sure ProfileViewController is notified when the user picks an image
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
 
    
   /*
    //MARK: Private methods
    private func updateSaveButtonState(){
        //disable the save button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    */
    
  

   
}

