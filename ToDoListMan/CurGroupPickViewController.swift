//
//  CurGroupPickViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 6. 1..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit
import Firebase

class CurGroupPickViewController: UIViewController,UIPickerViewDelegate  {

    @IBOutlet weak var groupPicker: UIPickerView!
    
    var myGroup : [String] = ["h1","h2","h3"]
    var myGroupId : [Int] = [1,2,3]
    var pickGroup = ""
    var pickGrpId :Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.groupPicker.delegate = self
        // Do any additional setup after loading the view.
        
        var database = FIRDatabase.database()
        var ref = database.reference()
        ref.child("user").child((FIRAuth.auth()?.currentUser?.uid)!).observe(FIRDataEventType.value, with: { (dataSnapShot) in
            let a = dataSnapShot.value as! NSDictionary
            
            self.myGroup = (a["groupName"] as! Array!)
            self.myGroupId = a["groups"] as! Array!
            
            self.pickGroup = self.myGroup[0]
            self.pickGrpId = self.myGroupId[0]
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myGroup.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myGroup[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //s self.pickGrpId = self.dump[row]
        self.pickGroup = myGroup[row]
        pickGrpId  = myGroupId[row]
        
    }
    
    @IBAction func btnCancelClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }

}
