//
//  ViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 4. 12..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController {
    
    var ref: FIRDatabaseReference!
    @IBOutlet weak var btnFBLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        print("aㅁㅁㅁㅁㅁdf")
        if FIRAuth.auth()?.currentUser != nil {
            let storyboard: UIStoryboard = UIStoryboard(name: "MainStoryBoard", bundle: nil)
            let nextView = storyboard.instantiateInitialViewController()
            self.present(nextView!, animated: true, completion: nil)
 
        
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnFBLoginPressed(_ sender: Any) {
       // self.performSegue(withIdentifier: "segNext", sender: self)
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) {(result, error) in
            if error == nil {
                
                
                 let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                    // ...
                     if error == nil {
                        
                        print(FIRAuth.auth()?.currentUser?.uid)
                        
                        self.ref = FIRDatabase.database().reference()
                       
                        self.ref.child("user").child((FIRAuth.auth()?.currentUser?.uid)!).observe(.value, with: { (snapshot) -> Void in
                            for itemSnapShot in snapshot.children {
                                if itemSnapShot == nil {      //유저가 없을 경우
                                    
                                    let alertController = UIAlertController(title: "계급을 입력하세요.", message: "", preferredStyle: .alert)
                                    
                                    let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
                                        alert -> Void in
                                        
                                        let firstTextField = alertController.textFields![0] as UITextField
                                        
                                        let storyboard: UIStoryboard = UIStoryboard(name: "MainStoryBoard", bundle: nil)
                                        let nextView = storyboard.instantiateInitialViewController()
                                        self.present(nextView!, animated: true, completion: nil)
                                        
                                        
                                    })
                                    
                                    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
                                        (action : UIAlertAction!) -> Void in
                                        
                                    })
                                    
                                    alertController.addTextField { (textField : UITextField!) -> Void in
                                        textField.placeholder = "Enter First Name"
                                    }
                                    
                                    alertController.addAction(saveAction)
                                    alertController.addAction(cancelAction)
                                    
                                    self.present(alertController, animated: true, completion: nil)
                                    
                                }else{      //있을 경우
                                    
                                   // self.performSegue(withIdentifier: "segNext", sender: self)
                               
                                    let storyboard: UIStoryboard = UIStoryboard(name: "MainStoryBoard", bundle: nil)
                                    let nextView = storyboard.instantiateInitialViewController()
                                    self.present(nextView!, animated: true, completion: nil)

                                    
                                    
                                }
                                
                            }
                            
                        })

                        
                        return
                    }
                    

                    
                
                }
                
                
                
            }
            else{
            print(error!)
            }
         }
        
    }

}

