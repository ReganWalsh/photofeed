//
//  SettingsViewController.swift
//  21.PhotoMedia
//
//  Created by Regan  Walsh on 29/02/20.
//  Copyright © 2020 Regan  Walsh. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        } catch {
            print("Error");
        }
        
        
    }
    
    



}
