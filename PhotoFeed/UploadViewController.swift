//
//  UploadViewController.swift
//  21.PhotoMedia
//
//  Created by Regan  Walsh on 29/02/20.
//  Copyright © 2020 Regan  Walsh. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
     override func viewDidLoad() {
           super.viewDidLoad()
           imageView.isUserInteractionEnabled = true //Allow Interaction With ImageView
           let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage)) //Gesture Recogniser To Pick Image
           imageView.addGestureRecognizer(gestureRecognizer)
           
       }
       
       @objc func chooseImage() { //Image Picker
           let pickerController = UIImagePickerController()
           pickerController.delegate = self
           pickerController.sourceType = .photoLibrary
           present(pickerController, animated: true, completion: nil)
           
       }
       
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           imageView.image = info[.originalImage] as? UIImage //Dont Allow Editing
           self.dismiss(animated: true, completion: nil) //Then Dismiss
       }
       
       func makeAlert(titleInput: String, messageInput: String) { //Make Alert Function Again
           let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
           let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
           alert.addAction(okButton)
           self.present(alert, animated: true, completion: nil)
       }
       

       @IBAction func saveButtonClicked(_ sender: Any) {
           let storage = Storage.storage() //Firebase Storage Reference
           let storageReference = storage.reference(
           let mediaFolder = storageReference.child("media") //Child Of Media Folder
    
           if let data = imageView.image?.jpegData(compressionQuality: 0.5) { //Convert Image To Data
               
               let uuid = UUID().uuidString
               let imageReference = mediaFolder.child("\(uuid).jpg") //Saving Image
               imageReference.putData(data, metadata: nil) { (metadata, error) in
                   if error != nil { //If There Is An Error Then Make Alert
                       self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                   } else {
                       imageReference.downloadURL { (url, error) in
                           
                           if error == nil {
                               
                               let imageUrl = url?.absoluteString
                               
                               
                               //DATABASE
                               
                               let firestoreDatabase = Firestore.firestore()
                               
                               var firestoreReference : DocumentReference? = nil
                               
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.descriptionText.text!,"date" : FieldValue.serverTimestamp(), "likes" : 0 ] as [String : Any] //Post As Dictionary

                               firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                   if error != nil {
                                       
                                       self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                                       
                                   } else {
                                       
                                       self.imageView.image = UIImage(named: "select.png")
                                       self.descriptionText.text = ""
                                       self.tabBarController?.selectedIndex = 0
                                       
                                   }
                               })
                               
                               
                               
                           }
                           
                           
                       }
                       
                   }
               }
               
               
           }
}
}
