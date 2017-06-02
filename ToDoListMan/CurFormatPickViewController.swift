//
//  CurFormatViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 6. 1..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit
import Firebase

class CurFormatPickViewController: UIViewController,UIPickerViewDelegate {

    @IBOutlet weak var formatPicker: UIPickerView!
    
    var myFormat : [String] = []
    var pickFormat = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.formatPicker.delegate = self
        
        var database = FIRDatabase.database()
        var ref = database.reference()
        ref.child("format").child((FIRAuth.auth()?.currentUser?.uid)!).observe(FIRDataEventType.childAdded, with: { (dataSnapShot) in
          

            self.myFormat.append(dataSnapShot.key)
            self.pickFormat = self.myFormat[0]
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myFormat.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myFormat[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //s self.pickGrpId = self.dump[row]
        self.pickFormat = myFormat[row]
        print(self.pickFormat)
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnCancelClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }

}
