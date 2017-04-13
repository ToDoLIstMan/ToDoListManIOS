//
//  GrorupAddViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 4. 13..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit

class GrorupAddViewController: UIViewController {

    @IBOutlet weak var txtGrpName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTouch(_ sender: Any) {
        let alert = UIAlertController(title: txtGrpName.text, message:"추가하시겠습니까?",preferredStyle:UIAlertControllerStyle.alert)
        let onActionYes = UIAlertAction(title: "네",style:UIAlertActionStyle.default,handler:nil)
        let onActionNo = UIAlertAction(title: "아니오",style:UIAlertActionStyle.default,handler:nil)
        
        alert.addAction(onActionYes)
        alert.addAction(onActionNo)
        present(alert, animated:true, completion:nil)
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
