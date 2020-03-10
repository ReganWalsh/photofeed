//
//  ViewController.swift
//  21.PhotoMedia
//
//  Created by Regan  Walsh on 29/02/20.
//  Copyright © 2020 Regan  Walsh. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField! //Fields To Sign In
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func signInClicked(_ sender: Any) {
        
        if emailField.text != "" && passwordField.text != "" { //If There Are Characters In Each Field
       
            Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (authData, error) in //Sign Into Firebase
                if error != nil { //If There Is An Error
                    self.makeAlert(titleInput: "Error", messageInput: error!.localizedDescription) //Print It
                } else {
                    self.performSegue(withIdentifier: "toFeedViewController", sender: nil) //Else Perform A Segue
                }
            }
        } else {
            makeAlert(titleInput: "Error", messageInput: "Username And Password Are Both Required") //Else If Empty Then Make Alert
        }
        
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailField.text != "" && passwordField.text != "" {
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (authData, error) in //Create User
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedViewController", sender: nil)
                }
                
            }
            
            } else {
                makeAlert(titleInput: "Error", messageInput: "Username And Password Are Both Required")
            }

        }
        
    func makeAlert(titleInput: String, messageInput: String) { //Make Alert Function
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil);
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    

}
































