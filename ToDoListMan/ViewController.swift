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

class ViewController: UIViewController {

    @IBOutlet weak var btnFBLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
   //     let loginButton = LoginButton(readPermissions: [ .publicProfile, .email ])
   //     loginButton.center = view.center
        
        
    //    view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnFBLoginPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "segNext", sender: self)
        /*
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) {(result, error) in
            if(error==nil){
                let alertController = UIAlertController(title: "계급을 입력하세요.", message: "", preferredStyle: .alert)
                
                let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
                    alert -> Void in
                    
                    let firstTextField = alertController.textFields![0] as UITextField
                    self.performSegue(withIdentifier: "segNext", sender: self)
                    
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
            }
            else{
            print(error)
            }
         }
         */
    }

}

