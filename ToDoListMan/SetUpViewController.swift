//
//  SetUpViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 5. 28..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit
import Firebase

class SetUpViewController: UIViewController {

    @IBOutlet weak var txtVersion: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnLogOutClicked(_ sender: Any) {
        
        let alertController = UIAlertController(title: "경고", message: "로그아웃하시겠습니까?", preferredStyle: .alert)
        
        
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        let saveAction = UIAlertAction(title: "확인", style: .default, handler: {
            alert -> Void in
            
            do {
                try FIRAuth.auth()?.signOut()
            } catch{
                
            }
            
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
        

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
