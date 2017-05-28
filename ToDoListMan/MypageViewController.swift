//
//  MypageViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 5. 28..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit
import Firebase

class MypageViewController: UIViewController {

    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtRank: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var ref = FIRDatabase.database().reference()
        ref.child("user").child((FIRAuth.auth()?.currentUser?.uid)!).observe(.value, with: { (dataSnapshot) in
            print(dataSnapshot)
            let a = dataSnapshot.value as! NSDictionary
            self.txtName.text = a["name"] as! String!
            self.txtRank.text = a["rank"] as! String!
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
