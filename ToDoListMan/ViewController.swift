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

        /*
        if FIRAuth.auth()?.currentUser != nil {
            
            print(FIRAuth.auth()?.currentUser?.uid)
            self.performSegue(withIdentifier: "segNext", sender: self)

            } else {
            
            print("ㅇㄹㅁㅇㄹㄴㄴㅇㄹ")
        }
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //화면이 뜨고난 직후 돌아가는 코드.
    override func viewDidAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser != nil {
            
            print(FIRAuth.auth()?.currentUser?.uid)
            self.performSegue(withIdentifier: "segNext", sender: self)
            
        } else {
            
            print("ㅇㄹㅁㅇㄹㄴㄴㅇㄹ")
        }
        
        
    }
    
    
    @IBAction func btnFBLoginPressed(_ sender: Any) {
       // self.performSegue(withIdentifier: "segNext", sender: self)
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) {(result, error) in
            if result != nil {
                
                
                 let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                    // ...
                     if user != nil {
                        
                        print(FIRAuth.auth()?.currentUser?.uid)
                        
                        self.ref = FIRDatabase.database().reference()
                       
                        var handle : UInt = 0
                        handle = self.ref.child("user").child((FIRAuth.auth()?.currentUser?.uid)!).observe(.value, with: { (snapshot) -> Void in
                                self.ref.removeObserver(withHandle: handle)
                                if !snapshot.exists() {      //유저가 없을 경우
                                    
                                    let alertController = UIAlertController(title: "이름과 계급을 입력하세요.", message: "", preferredStyle: .alert)
                                    
                                    let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
                                        alert -> Void in
                                        
                                        let firstTextField = alertController.textFields![0] as UITextField
                                        
                                        let secondTextField = alertController.textFields![1] as UITextField
                                        
                                         self.ref.child("user").child((FIRAuth.auth()?.currentUser?.uid)!).setValue(["name":firstTextField.text,
                                                                                                                     "rank":secondTextField.text])
                                        self.performSegue(withIdentifier: "segNext", sender: self)
                                        self.dismiss(animated: true, completion: nil)
                                        
                                    })
                                    
                                    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
                                        (action : UIAlertAction!) -> Void in
                                        
                                    })
                                    
                                    alertController.addTextField { (textField : UITextField!) -> Void in
                                        textField.placeholder = "이름을 입력하세요."
                                    }
                                    alertController.addTextField { (textField : UITextField!) -> Void in
                                        textField.placeholder = "계급을 입력하세요."
                                    }
                                    
                                    alertController.addAction(saveAction)
                                    alertController.addAction(cancelAction)
                                    
                                    self.present(alertController, animated: true, completion: nil)
                                    
                                }else{      //있을 경우
                                    
                                    print(FIRAuth.auth()?.currentUser?.uid,"hi!")
                                    self.performSegue(withIdentifier: "segNext", sender: self)
                                    self.dismiss(animated: true, completion: nil)
                              //      let storyboard: UIStoryboard = UIStoryboard(name: "MainStoryBoard", bundle: nil)
                              //      let nextView = storyboard.instantiateInitialViewController()
                               //     self.present(nextView!, animated: true, completion: nil)

                                    
                                    
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

